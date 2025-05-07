import 'package:aplikasi_koperasi1/screens/dashboard/pengurus/dashboard_pengurus.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Anggota',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PengurusDashboardScreen(data: {},),  // Perbaikan nama kelas di sini
    );
  }
}
