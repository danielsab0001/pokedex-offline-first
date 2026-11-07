import 'dart:async';
import 'dart:io';

import 'package:graphql/client.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/core/network/graphql_client.dart';
import 'package:pokedex/core/network/service_health.dart';
import 'package:pokedex/features/pokemon/data/pokemon_queries.dart';
import 'package:pokedex/features/pokemon/data/pokemon_species_dto.dart';

const catalogPageSize = 100;

class PokemonRemoteDataSource {
  PokemonRemoteDataSource(
    this._client, {
    this.timeout = requestTimeout,
    this.health,
  });

  final GraphQLClient _client;
  final Duration timeout;
  final ServiceHealth? health;
  final _document = gql(catalogPageQuery);

  /// Pide las especies con id mayor que [afterId] (paginación por cursor).
  /// Cada llamada deja constancia del resultado en [health] (IND-02).
  Future<RemoteCatalogPage> fetchCatalogPage({
    required int afterId,
    int pageSize = catalogPageSize,
  }) async {
    try {
      final page = await _request(afterId: afterId, pageSize: pageSize);
      health?.reportSuccess();
      return page;
    } on Failure catch (failure) {
      health?.reportFailure(failure);
      rethrow;
    }
  }

  Future<RemoteCatalogPage> _request({
    required int afterId,
    required int pageSize,
  }) async {
    final QueryResult result;
    try {
      result = await _client
          .query(
            QueryOptions(
              document: _document,
              variables: {'afterId': afterId, 'limit': pageSize},
              fetchPolicy: FetchPolicy.noCache,
            ),
          )
          .timeout(timeout);
    } on TimeoutException {
      throw TimeoutFailure(timeout);
    } on SocketException {
      throw const NetworkFailure();
    } on http.ClientException {
      throw const NetworkFailure();
    }

    final exception = result.exception;
    if (exception != null) throw _translate(exception);

    final data = result.data;
    if (data == null) {
      throw const InvalidResponseFailure('La respuesta no trae datos');
    }

    try {
      return RemoteCatalogPage.fromJson(data);
    } on Failure {
      rethrow;
    } catch (e) {
      throw InvalidResponseFailure('Formato inesperado: $e');
    }
  }

  Failure _translate(OperationException exception) {
    final link = exception.linkException;
    if (link != null) return _fromLink(link);

    final messages = [for (final e in exception.graphqlErrors) e.message];
    return GraphQlFailure(messages.join('; '));
  }

  Failure _fromLink(LinkException link) {
    if (link is HttpLinkServerException) return _fromHttp(link.response);
    if (link is HttpLinkParserException) return _fromHttp(link.response);
    return const NetworkFailure();
  }

  Failure _fromHttp(http.Response response) {
    final status = response.statusCode;
    if (status == 429) {
      return RateLimitFailure(
        retryAfter: _parseRetryAfter(response.headers['retry-after']),
      );
    }
    if (status >= 300) return HttpStatusFailure(status);
    return const InvalidResponseFailure('Respuesta sin datos ni errores');
  }

  /// Solo entiende segundos; si viene como fecha HTTP devuelve null.
  Duration? _parseRetryAfter(String? header) {
    final seconds = int.tryParse(header ?? '');
    return seconds == null ? null : Duration(seconds: seconds);
  }
}
