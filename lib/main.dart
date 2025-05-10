import 'package:aplikasi_koperasi1/screens/dashboard/pengawas/data_anggota_screen.dart';
import 'package:aplikasi_koperasi1/screens/dashboard/pengawas/rincian_anggota_screen.dart';
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
<<<<<<< HEAD
        '/register': (context) => RegisterPageViewScreen(),
        '/data-anggota': (context) => DataAnggotaScreen(),
        '/rincian-anggota': (context) => RincianAnggotaScreen(
              nama: "Andi",
              nomor: "0812345678",
              status: "Anggota",
            ),
=======
        '/register': (context) => const RegisterScreen(),
>>>>>>> ee332fc652b7e665faa78283f344195bcc4c92f9
      },
    );
}
}
