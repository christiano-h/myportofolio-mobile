/// Base URL of the Django REST Framework backend.
///
/// Defaults to `http://10.0.2.2:8000` (alamat IP mesin pengembangan lokal
/// yang dapat diakses dari Android emulator).
/// Timpa dengan `--dart-define=API_BASE_URL=http://localhost:8000` jika
/// melakukan pengujian di Chrome/Web browser.
const String apiBaseUrl = String.fromEnvironment(
  // Membaca konstanta environment saat compile-time dari flag --dart-define
  'API_BASE_URL',
  defaultValue: 'http://10.0.2.2:8000',
);
