import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';

void main() {
  test('graphql: se construye un cliente sin hacer red', () {
    final client = GraphQLClient(
      link: HttpLink('https://graphql.pokeapi.co/v1beta2'),
      cache: GraphQLCache(),
    );

    expect(client, isNotNull);
  });

  test('drift: Value distingue presente de ausente', () {
    const present = Value(5);
    const absent = Value<int>.absent();

    expect(present.present, isTrue);
    expect(absent.present, isFalse);
  });

  test('connectivity_plus: el tipo ConnectivityResult existe', () {
    expect(ConnectivityResult.values, contains(ConnectivityResult.none));
  });

  test('cached_network_image: el tipo se resuelve', () {
    expect(CachedNetworkImage, isNotNull);
  });
}
