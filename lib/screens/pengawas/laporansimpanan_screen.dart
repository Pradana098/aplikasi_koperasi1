import 'package:flutter/material.dart';

class LaporanSimpananScreen extends StatelessWidget {
  const LaporanSimpananScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text("Laporan Simpanan"),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: ListView(
            children: [
              const Text(
                "Detail Simpanan Anggota",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildSimpananItem("Leo Eka Matra", "Rp 500.000", "Simpanan Pokok"),
              _buildSimpananItem("Ahmad Taufik", "Rp 250.000", "Simpanan Wajib"),
              _buildSimpananItem("Siti Aminah", "Rp 100.000", "Simpanan Sukarela"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSimpananItem(String nama, String jumlah, String jenis) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.savings, color: Colors.blue),
        title: Text(nama),
        subtitle: Text(jenis),
        trailing: Text(jumlah, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
