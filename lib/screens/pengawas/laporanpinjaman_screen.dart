import 'package:flutter/material.dart';

class LaporanPinjamanScreen extends StatelessWidget {
  const LaporanPinjamanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text("Laporan Pinjaman"),
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
                "Detail Pinjaman Anggota",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildPinjamanItem("Leo Eka Matra", "Rp 2.000.000", "6 Bulan"),
              _buildPinjamanItem("Ahmad Taufik", "Rp 1.000.000", "3 Bulan"),
              _buildPinjamanItem("Siti Aminah", "Rp 500.000", "12 Bulan"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPinjamanItem(String nama, String jumlah, String lama) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.attach_money, color: Colors.orange),
        title: Text(nama),
        subtitle: Text("Lama Pinjaman: $lama"),
        trailing: Text(jumlah, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
