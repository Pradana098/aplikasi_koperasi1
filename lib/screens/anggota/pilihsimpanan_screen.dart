import 'package:aplikasi_koperasi1/screens/anggota/simpananpokok_screen.dart';
import 'package:aplikasi_koperasi1/screens/anggota/simpananwajib_screen.dart';
import 'package:flutter/material.dart';


class PilihSimpananScreen extends StatelessWidget {
  const PilihSimpananScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FA),
      appBar: AppBar(
        title: const Text("Pilih Simpanan"),
        backgroundColor: const Color(0xFF3B82F6),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SimpananPokokScreen()),
                );
              },
              icon: const Icon(Icons.account_balance_wallet),
              label: const Text("Simpanan Pokok"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF1D4ED8),
                minimumSize: const Size.fromHeight(60),
                side: const BorderSide(color: Color(0xFF1D4ED8), width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SimpananWajibScreen()),
                );
              },
              icon: const Icon(Icons.savings),
              label: const Text("Simpanan Wajib"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF3B82F6),
                minimumSize: const Size.fromHeight(60),
                side: const BorderSide(color: Color(0xFF3B82F6), width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
