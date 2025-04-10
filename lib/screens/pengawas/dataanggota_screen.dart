import 'package:flutter/material.dart';

class DataAnggotaScreen extends StatelessWidget {
  const DataAnggotaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text("Data Anggota"),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(16),
          child: const Text(
            "Informasi tentang anggota koperasi akan ditampilkan di sini.",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
