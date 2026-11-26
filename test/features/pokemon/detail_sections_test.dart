import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_detail.dart';
import 'package:pokedex/features/pokemon/presentation/detail/detail_abilities_section.dart';
import 'package:pokedex/features/pokemon/presentation/detail/detail_info_section.dart';
import 'package:pokedex/features/pokemon/presentation/detail/detail_pending_notice.dart';
import 'package:pokedex/features/pokemon/presentation/detail/detail_stats_section.dart';
import 'package:pokedex/features/pokemon/presentation/detail/egg_group_labels.dart';
import 'package:pokedex/l10n/app_localizations.dart';

const _pikachu = Pokemon(
  id: 25,
  nameEn: 'Pikachu',
  generationId: 1,
  types: [PokemonType(id: 13, slug: 'electric', slot: 1)],
);

const _stats = [
  PokemonStat(kind: StatKind.hp, baseStat: 35),
  PokemonStat(kind: StatKind.attack, baseStat: 55),
  PokemonStat(kind: StatKind.defense, baseStat: 40),
  PokemonStat(kind: StatKind.specialAttack, baseStat: 50),
  PokemonStat(kind: StatKind.specialDefense, baseStat: 50),
  PokemonStat(kind: StatKind.speed, baseStat: 90),
];

Widget host(Widget child, {String locale = 'es'}) {
  return MaterialApp(
    locale: Locale(locale),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(body: SingleChildScrollView(child: child)),
  );
}

void main() {
  group('estadísticas', () {
    testWidgets('muestra etiquetas, valores y total', (tester) async {
      await tester.pumpWidget(
        host(const DetailStatsSection(stats: _stats, total: 320)),
      );

      expect(find.text('Estadísticas base'), findsOneWidget);
      expect(find.text('PS'), findsOneWidget);
      expect(find.text('Velocidad'), findsOneWidget);
      expect(find.text('90'), findsOneWidget);
      expect(find.text('Total'), findsOneWidget);
      expect(find.text('320'), findsOneWidget);
    });

    testWidgets('cada barra llena su valor sobre 255', (tester) async {
      await tester.pumpWidget(
        host(const DetailStatsSection(stats: _stats, total: 320)),
      );

      final bars = tester
          .widgetList<LinearProgressIndicator>(
            find.byType(LinearProgressIndicator),
          )
          .toList();

      expect(bars, hasLength(6));
      expect(bars.last.value, closeTo(90 / 255, 0.0001));
    });

    testWidgets('cada fila se lee con valor y porcentaje', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        host(const DetailStatsSection(stats: _stats, total: 320)),
      );

      expect(
        find.bySemanticsLabel('Velocidad: 90 de 255, 35 %'),
        findsOneWidget,
      );
      handle.dispose();
    });

    testWidgets('sin total no muestra la fila Total', (tester) async {
      await tester.pumpWidget(
        host(const DetailStatsSection(stats: _stats, total: null)),
      );

      expect(find.text('Total'), findsNothing);
    });
  });

  group('habilidades', () {
    const abilities = [
      PokemonAbility(
        id: 9,
        slug: 'static',
        slot: 1,
        isHidden: false,
        nameEn: 'Static',
        nameEs: 'Elec. Estática',
        effectEn: 'May paralyze on contact.',
        effectEs: 'Puede paralizar al contacto.',
      ),
      PokemonAbility(
        id: 31,
        slug: 'lightning-rod',
        slot: 3,
        isHidden: true,
        nameEn: 'Lightning Rod',
      ),
    ];

    testWidgets('nombre, efecto y marca de oculta en español', (tester) async {
      await tester.pumpWidget(
        host(const DetailAbilitiesSection(abilities: abilities)),
      );

      expect(find.text('Habilidades'), findsOneWidget);
      expect(find.text('Elec. Estática'), findsOneWidget);
      expect(find.text('Puede paralizar al contacto.'), findsOneWidget);
      expect(find.text('Oculta'), findsOneWidget);
      expect(find.text('Lightning Rod'), findsOneWidget);
      expect(find.text('Sin descripción disponible'), findsOneWidget);
    });

    testWidgets('en inglés usa los textos en inglés', (tester) async {
      await tester.pumpWidget(
        host(const DetailAbilitiesSection(abilities: abilities), locale: 'en'),
      );

      expect(find.text('Static'), findsOneWidget);
      expect(find.text('May paralyze on contact.'), findsOneWidget);
      expect(find.text('Hidden'), findsOneWidget);
    });
  });

  group('datos', () {
    PokemonDetail detail({int? height, int? weight, List<EggGroup>? eggs}) {
      return PokemonDetail(
        pokemon: _pikachu,
        stats: _stats,
        height: height,
        weight: weight,
        eggGroups:
            eggs ??
            const [
              EggGroup(id: 5, slug: 'ground'),
              EggGroup(id: 6, slug: 'fairy'),
            ],
        detailSyncedAt: DateTime(2026),
      );
    }

    testWidgets('altura, peso y grupos huevo con coma decimal', (tester) async {
      await tester.pumpWidget(
        host(DetailInfoSection(detail: detail(height: 4, weight: 60))),
      );

      expect(find.text('0,4 m'), findsOneWidget);
      expect(find.text('6,0 kg'), findsOneWidget);
      expect(find.text('Campo, Hada'), findsOneWidget);
    });

    testWidgets('en inglés usa punto decimal', (tester) async {
      await tester.pumpWidget(
        host(
          DetailInfoSection(detail: detail(height: 4, weight: 60)),
          locale: 'en',
        ),
      );

      expect(find.text('0.4 m'), findsOneWidget);
      expect(find.text('Field, Fairy'), findsOneWidget);
    });

    testWidgets('los datos que faltan se muestran con un guion', (
      tester,
    ) async {
      await tester.pumpWidget(
        host(DetailInfoSection(detail: detail(eggs: []))),
      );

      expect(find.text('—'), findsNWidgets(3));
    });
  });

  group('grupos huevo', () {
    const slugs = [
      'monster',
      'water1',
      'bug',
      'flying',
      'ground',
      'fairy',
      'plant',
      'humanshape',
      'water3',
      'mineral',
      'indeterminate',
      'water2',
      'ditto',
      'dragon',
      'no-eggs',
    ];

    for (final code in ['es', 'en']) {
      test('los 15 slugs tienen texto traducido en $code', () async {
        final l10n = await AppLocalizations.delegate.load(Locale(code));

        for (final slug in slugs) {
          expect(eggGroupLabel(l10n, slug), isNot(slug), reason: slug);
        }
      });
    }

    test('un slug desconocido se muestra tal cual', () async {
      final l10n = await AppLocalizations.delegate.load(const Locale('es'));

      expect(eggGroupLabel(l10n, 'nuevo-grupo'), 'nuevo-grupo');
    });
  });

  group('aviso de datos pendientes', () {
    testWidgets('descargando', (tester) async {
      await tester.pumpWidget(
        host(const DetailPendingNotice(isRefreshing: true)),
      );

      expect(find.text('Descargando habilidades y datos…'), findsOneWidget);
    });

    testWidgets('no guardados', (tester) async {
      await tester.pumpWidget(
        host(const DetailPendingNotice(isRefreshing: false)),
      );

      expect(
        find.text(
          'Las habilidades y los datos de este Pokémon aún no están guardados.',
        ),
        findsOneWidget,
      );
    });
  });
}
