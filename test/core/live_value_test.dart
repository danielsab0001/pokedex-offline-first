import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/live_value.dart';

void main() {
  test('emite el valor actual al suscribirse y luego cada cambio', () async {
    final value = LiveValue(1);
    final seen = <int>[];
    final subscription = value.watch().listen(seen.add);
    await Future<void>.delayed(Duration.zero);

    value.value = 2;
    await Future<void>.delayed(Duration.zero);
    value.value = 3;
    await Future<void>.delayed(Duration.zero);

    await subscription.cancel();
    await value.dispose();
    expect(seen, [1, 2, 3]);
  });

  test('un valor igual al actual no emite', () async {
    final value = LiveValue('a');
    final seen = <String>[];
    final subscription = value.watch().listen(seen.add);
    await Future<void>.delayed(Duration.zero);

    value.value = 'a';
    await Future<void>.delayed(Duration.zero);

    await subscription.cancel();
    await value.dispose();
    expect(seen, ['a']);
  });
}
