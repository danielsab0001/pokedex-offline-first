import 'dart:async';
import 'dart:io';

import 'package:graphql/client.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/core/network/graphql_client.dart';
import 'package:pokedex/core/network/service_health.dart';
import 'package:pokedex/features/pokemon/data/pokemon_queries.dart';
import 'package:pokedex/features/pokemon/data/pokemon_species_dto.dart';
import 'package:pokedex/features/pokemon/data/reference_dto.dart';

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
  final _catalogDocument = gql(catalogPageQuery);
  final _detailDocument = gql(pokemonDetailQuery);
  final _referenceDocument = gql(referenceDataQuery);

  /// Pide las especies con id mayor que [afterId] (paginación por cursor).
  /// Con [includeTotal] pide además el total de especies de PokeAPI.
  Future<RemoteCatalogPage> fetchCatalogPage({
    required int afterId,
    int pageSize = catalogPageSize,
    bool includeTotal = false,
  }) {
    return _reporting(() async {
      final data = await _query(
        QueryOptions(
          document: _catalogDocument,
          variables: {
            'afterId': afterId,
            'limit': pageSize,
            'includeTotal': includeTotal,
          },
          fetchPolicy: FetchPolicy.noCache,
        ),
      );
      return _parse(() {
        final page = RemoteCatalogPage.fromJson(data);
        if (includeTotal && page.catalogTotalCount == null) {
          throw const InvalidResponseFailure('Se pidió el total y no llegó');
        }
        return page;
      });
    });
  }

  /// Núcleo y detalle de una especie; null si PokeAPI no la tiene.
  Future<PokemonDetailDto?> fetchDetail(int id) {
    return _reporting(() async {
      final data = await _query(
        QueryOptions(
          document: _detailDocument,
          variables: {'id': id},
          fetchPolicy: FetchPolicy.noCache,
        ),
      );
      return _parse(() => PokemonDetailDto.fromResponse(data));
    });
  }

  /// Tabla de tipos y grupos de versión; no depende de ningún Pokémon.
  Future<ReferenceDto> fetchReferenceData() {
    return _reporting(() async {
      final data = await _query(
        QueryOptions(
          document: _referenceDocument,
          fetchPolicy: FetchPolicy.noCache,
        ),
      );
      return _parse(() => ReferenceDto.fromJson(data));
    });
  }

  /// Cada llamada deja constancia del resultado en [health] (IND-02).
  Future<T> _reporting<T>(Future<T> Function() request) async {
    try {
      final value = await request();
      health?.reportSuccess();
      return value;
    } on Failure catch (failure) {
      health?.reportFailure(failure);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> _query(QueryOptions options) async {
    final QueryResult result;
    try {
      result = await _client.query(options).timeout(timeout);
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
    return data;
  }

  T _parse<T>(T Function() build) {
    try {
      return build();
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
