import 'package:aplikasi_koperasi1/screens/bantuan_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';

// Import semua file
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/widged/DashboardAnggota.dart';
import 'screens/riwayat_transaksi_screen.dart';
import 'screens/pengajuan_pinjaman_screen.dart';
import 'screens/profil_screen.dart';
import 'screens/notifikasi_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Wajib agar async bisa jalan
  await initializeDateFormatting('id_ID', null); // Inisialisasi format lokal

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget _initialScreen = const Scaffold(
    body: Center(child: CircularProgressIndicator()),
  );

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getString('token') != null;

    setState(() {
      _initialScreen = isLoggedIn ? const DashboardScreen() : const LoginScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Koperasi Simpan Pinjam',
      debugShowCheckedModeBanner: false,
      home: _initialScreen,
      routes: {
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/dashboardAnggota': (context) => DashboardAnggota(dashboardData: {"saldo": 5000000}),
        '/riwayat': (context) => RiwayatTransaksiScreen(),
        '/pengajuan': (context) => PengajuanPinjamanScreen(),
        '/profil': (context) => const ProfilScreen(),
        '/notifikasi': (context) => const NotifikasiScreen(),
        '/bantuan': (context) => const BantuanScreen(),
      },
    );
  }
}
