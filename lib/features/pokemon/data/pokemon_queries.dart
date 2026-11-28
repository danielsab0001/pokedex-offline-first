/// Idiomas de PokeAPI usados en la consulta: 7 = español, 9 = inglés.
const spanishLanguageId = 7;
const englishLanguageId = 9;

/// Campos de una especie que comparten el catálogo y el detalle.
const speciesCoreFragment = r'''
fragment SpeciesCore on pokemonspecies {
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
    pokemonstats {
      base_stat
      stat {
        name
      }
    }
  }
}
''';

const _catalogPageBody = r'''
query CatalogPage($afterId: Int!, $limit: Int!, $includeTotal: Boolean!) {
  pokemonspecies_aggregate @include(if: $includeTotal) {
    aggregate {
      count
    }
  }
  pokemonspecies(
    order_by: {id: asc}
    limit: $limit
    where: {id: {_gt: $afterId}}
  ) {
    ...SpeciesCore
  }
}
''';

/// Una página del catálogo más el total de especies, en una sola petición.
const catalogPageQuery = _catalogPageBody + speciesCoreFragment;

const _pokemonDetailBody = r'''
query PokemonDetail($id: Int!) {
  pokemonspecies(where: {id: {_eq: $id}}) {
    ...SpeciesCore
    pokemonegggroups {
      egggroup {
        id
        name
      }
    }
    pokemons(where: {is_default: {_eq: true}}) {
      height
      weight
      pokemonabilities(order_by: {slot: asc}) {
        slot
        is_hidden
        ability {
          id
          name
          abilitynames(where: {language_id: {_in: [7, 9]}}) {
            language_id
            name
          }
          abilityeffecttexts(where: {language_id: {_eq: 9}}) {
            short_effect
          }
          abilityflavortexts(
            where: {language_id: {_eq: 7}}
            order_by: {version_group_id: desc}
            limit: 1
          ) {
            flavor_text
          }
        }
      }
    }
  }
}
''';

/// El núcleo de una especie más lo que solo necesita su pantalla de detalle.
const pokemonDetailQuery = _pokemonDetailBody + speciesCoreFragment;

/// Datos globales que no dependen de un Pokémon: tabla de tipos y juegos.
const referenceDataQuery = r'''
query ReferenceData {
  typeefficacy {
    damage_type_id
    target_type_id
    damage_factor
  }
  type(where: {id: {_lte: 18}}, order_by: {id: asc}) {
    id
    name
  }
  versiongroup(order_by: {order: asc}) {
    id
    name
    order
    generation_id
    versions {
      versionnames(where: {language_id: {_in: [7, 9]}}) {
        language_id
        name
      }
    }
  }
}
''';
