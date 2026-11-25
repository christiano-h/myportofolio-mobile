import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myportofolio_mobile/config.dart';
import 'package:myportofolio_mobile/models/project.dart';

/// Exception yang dilempar ketika permintaan API mengembalikan status HTTP non-2xx.
class ApiException implements Exception {
  const ApiException(this.statusCode, this.message);

  final int statusCode;
  final String message;

  @override
  String toString() => 'ApiException($statusCode): $message';
}

/// Klien HTTP untuk berkomunikasi dengan backend Django REST Framework MyPortfolio.
/// Menggunakan header string biasa (tanpa dart:io) agar 100% kompatibel di Android & Web.
class ApiClient {
  ApiClient({http.Client? client, this.baseUrl = apiBaseUrl})
    : _client = client ?? http.Client();

  final http.Client _client;
  final String baseUrl;

  /// Menggabungkan baseUrl dan path endpoint menjadi objek [Uri] yang valid.
  Uri _uri(String path) => Uri.parse('$baseUrl$path');

  /// Mengambil daftar seluruh proyek publik dari endpoint GET /api/v1/projects/.
  Future<List<Project>> getProjects() async {
    final response = await _client.get(
      _uri('/api/v1/projects/'),
      headers: const {'Accept': 'application/json'},
    );
    _ensureSuccess(response);

    // Mendekode array JSON lalu memetakan setiap elemen menjadi objek Project
    final decoded = jsonDecode(response.body) as List<dynamic>;
    return decoded
        .map((item) => Project.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  /// Mengirim data proyek baru ke endpoint POST /api/v1/projects/ dengan autentikasi token.
  Future<Project> createProject(
    Project project, {
    required String token,
  }) async {
    final response = await _client.post(
      _uri('/api/v1/projects/'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        // Menyertakan token DRF pada header Authorization sesuai skema TokenAuthentication
        'Authorization': 'Token $token',
      },
      body: jsonEncode(project.toJson()),
    );
    _ensureSuccess(response);

    // Mendekode objek JSON hasil kreasi server (termasuk UUID id yang dibuat Django)
    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    return Project.fromJson(decoded);
  }

  /// Menukar kredensial username dan password menjadi token DRF via POST /api/v1/auth/token/.
  Future<String> obtainToken(String username, String password) async {
    final response = await _client.post(
      _uri('/api/v1/auth/token/'),
      headers: const {
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'username': username, 'password': password}),
    );
    _ensureSuccess(response);

    // Mengekstrak nilai string token dari body JSON response
    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    return decoded['token'] as String;
  }

  /// Mencabut token sesi saat ini di server via POST /api/v1/auth/logout/.
  Future<void> logout({required String token}) async {
    final response = await _client.post(
      _uri('/api/v1/auth/logout/'),
      headers: {'Accept': 'application/json', 'Authorization': 'Token $token'},
    );
    _ensureSuccess(response);
  }

  /// Memvalidasi status kode HTTP berada pada rentang sukses (2xx).
  /// Jika gagal, melempar [ApiException] agar widget pemanggil dapat menangani error.
  void _ensureSuccess(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return;
    }
    throw ApiException(response.statusCode, response.body);
  }
}
