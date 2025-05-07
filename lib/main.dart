<<<<<<< HEAD
//import 'package:aplikasi_koperasi1/screens/dashboard/pengurus/dashboard_pengurus.dart';
=======
>>>>>>> efc95936ece036f3c3afb20568e55c3a31bdd3ee
import 'package:aplikasi_koperasi1/screens/home_screen.dart';
import 'package:aplikasi_koperasi1/screens/login_screen.dart';
import 'package:aplikasi_koperasi1/screens/regrister_srceen.dart';
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
        '/register': (context) => RegisterPageViewScreen(),
      },
    );
}

}
