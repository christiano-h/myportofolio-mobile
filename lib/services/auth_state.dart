import 'package:flutter/foundation.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

/// Menyimpan token autentikasi sesi saat ini di memori dan memberi tahu
/// seluruh widget listener (melalui ChangeNotifier) ketika status login berubah.
class AuthState extends ChangeNotifier {
  AuthState(this._apiClient, {String? initialToken}) : _token = initialToken;

  final ApiClient _apiClient;
  String? _token;

  /// Mengembalikan token autentikasi aktif, atau null jika belum login.
  String? get token => _token;

  /// Menandakan apakah pengguna saat ini sudah terautentikasi.
  bool get isLoggedIn => _token != null;

  /// Melakukan login ke backend DRF untuk memperoleh token lalu memperbarui listener.
  Future<void> login(String username, String password) async {
    _token = await _apiClient.obtainToken(username, password);
    notifyListeners();
  }

  /// Mencabut token pada server dan selalu membersihkan state sesi lokal.
  Future<void> logout() async {
    final current = _token;
    if (current == null) return;

    try {
      // Meminta server mencabut token aktif via POST /api/v1/auth/logout/
      await _apiClient.logout(token: current);
    } on ApiException {
      // Abaikan error dari server (mis. token sudah kedaluwarsa) agar sesi lokal tetap dibersihkan
    } finally {
      // Selalu reset token lokal dan beri tahu listener meskipun request ke server gagal
      _token = null;
      notifyListeners();
    }
  }
}
