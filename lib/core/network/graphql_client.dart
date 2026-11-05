import 'package:graphql/client.dart';
import 'package:http/http.dart' as http;

const pokeApiEndpoint = 'https://graphql.pokeapi.co/v1beta2';

/// Tiempo máximo de espera por petición (RNF-RES-01).
const requestTimeout = Duration(seconds: 15);

GraphQLClient createPokeApiClient({http.Client? httpClient}) {
  return GraphQLClient(
    link: HttpLink(pokeApiEndpoint, httpClient: httpClient),
    cache: GraphQLCache(),
  );
}
