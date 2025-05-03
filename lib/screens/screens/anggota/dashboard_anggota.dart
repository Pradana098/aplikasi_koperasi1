import 'package:flutter/material.dart';

class AnggotaDashboardScreen extends StatelessWidget {
  late final Map<String, dynamic> data;

  AnggotaDashboardScreen({Key? key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard Anggota'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            Text(
              'Selamat Datang, Anggota!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Ini adalah dashboard anggota.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}