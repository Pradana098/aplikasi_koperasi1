import 'package:flutter/material.dart';

class PengaturanAplikasiScreen extends StatelessWidget {
  const PengaturanAplikasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text("Pengaturan Aplikasi"),
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
            "Pengaturan sistem koperasi akan ditampilkan di sini.",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
