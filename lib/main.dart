import 'package:aplikasi_koperasi1/screens/dashboard/pengurus/dashboard_pengurus.dart';
import 'package:aplikasi_koperasi1/screens/home_screen.dart';
<<<<<<< HEAD
import 'package:aplikasi_koperasi1/screens/regrister_srceen.dart';
=======
import 'package:aplikasi_koperasi1/screens/login_screen.dart';
>>>>>>> f0c25b2ccc1ec1a5c1f073c899ee84f904aa41a7
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
<<<<<<< HEAD
        '/register': (context) => RegisterPageViewScreen(),
=======
        //'/register': (context) => RegisterPageViewScreen(),
>>>>>>> f0c25b2ccc1ec1a5c1f073c899ee84f904aa41a7
      },
    );
}

}
