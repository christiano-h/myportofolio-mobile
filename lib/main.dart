import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:provider/provider.dart';

void main() {
  // Menginisialisasi satu instance ApiClient untuk diinjeksikan ke seluruh widget tree
  runApp(MyApp(apiClient: ApiClient()));
}

/// Widget root aplikasi MyPortfolio Mobile yang menyisipkan dependensi
/// [ApiClient] dan [AuthState] menggunakan [MultiProvider].
class MyApp extends StatelessWidget {
  const MyApp({required this.apiClient, super.key});

  final ApiClient apiClient;

  @override
  Widget build(BuildContext context) {
    // MultiProvider membungkus aplikasi agar objek layanan dan state autentikasi
    // dapat diakses oleh layar maupun widget mana pun tanpa oper manual via constructor
    return MultiProvider(
      providers: [
        Provider.value(value: apiClient),
        ChangeNotifierProvider(create: (_) => AuthState(apiClient)),
      ],
      child: MaterialApp(
        title: 'MyPortfolio',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigo,
            secondary: Colors.amber[700],
          ),
          useMaterial3: true,
        ),
        home: MyHomePage(),
      ),
    );
  }
}
