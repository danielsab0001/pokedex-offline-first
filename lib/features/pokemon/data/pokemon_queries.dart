/// Idiomas de PokeAPI usados en la consulta: 7 = español, 9 = inglés.
const spanishLanguageId = 7;
const englishLanguageId = 9;

/// Una página del catálogo más el total de especies, en una sola petición.
const catalogPageQuery = r'''
query CatalogPage($afterId: Int!, $limit: Int!) {
  pokemonspecies_aggregate {
    aggregate {
      count
    }
  }
  pokemonspecies(
    order_by: {id: asc}
    limit: $limit
    where: {id: {_gt: $afterId}}
  ) {
    id
    name
    generation_id
    pokemonspeciesnames(where: {language_id: {_in: [7, 9]}}) {
      language_id
      name
    }
    pokemons(where: {is_default: {_eq: true}}) {
      id
      pokemontypes {
        slot
        type {
          id
          name
        }
      }
    }
  }
}
''';
