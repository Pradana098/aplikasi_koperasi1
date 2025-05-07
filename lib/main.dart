import 'package:aplikasi_koperasi1/screens/home_screen.dart';
import 'package:aplikasi_koperasi1/screens/regrister_srceen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

// Import semua file
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Wajib agar async bisa jalan
  await initializeDateFormatting('id_ID', null); // Inisialisasi format lokal

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
 Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Koperasi Simpan Pinjam',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(), 
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => RegisterPageViewScreen(),
      },
    );
  }
}
