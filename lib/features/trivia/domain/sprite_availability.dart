abstract interface class SpriteAvailability {
  /// El sprite ya está en disco y se puede mostrar sin conexión.
  Future<bool> isCached(int pokemonId);

  /// Intenta descargarlo; false si no se pudo (sin red, tiempo agotado...).
  Future<bool> download(int pokemonId);
}
