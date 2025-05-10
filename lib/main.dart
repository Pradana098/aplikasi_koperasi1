import 'package:aplikasi_koperasi1/screens/home_screen.dart';
import 'package:aplikasi_koperasi1/screens/login_screen.dart';
import 'package:aplikasi_koperasi1/screens/register_srceen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Koperasi Simpan Pinjam',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(), 
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
      },
    );
}
}
