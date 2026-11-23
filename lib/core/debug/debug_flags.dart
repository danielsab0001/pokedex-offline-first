import 'package:flutter/foundation.dart';

/// Herramientas de depuración: simulación de caídas de la API e inspector.
const debugToolsEnabled = kDebugMode || bool.fromEnvironment('DEBUG_TOOLS');
