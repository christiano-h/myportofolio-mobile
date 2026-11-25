import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:provider/provider.dart';

/// Route guard untuk memastikan pengguna sudah terautentikasi sebelum mengakses
/// layar atau aksi yang dilindungi. Jika belum login, mendorong [LoginScreen].
Future<bool> ensureLoggedIn(BuildContext context) async {
  // Jika token sudah tersimpan di AuthState, langsung izinkan akses
  if (context.read<AuthState>().isLoggedIn) {
    return true;
  }

  // Jika belum login, buka LoginScreen dan tunggu hasil boolean dari Navigator.pop
  final loggedIn = await Navigator.push<bool>(
    context,
    MaterialPageRoute(builder: (_) => const LoginScreen()),
  );
  return loggedIn ?? false;
}
