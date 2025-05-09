import 'package:aplikasi_koperasi1/screens/dashboard/pengurus/laporan/laporan_keuangan_page.dart';
import 'package:aplikasi_koperasi1/screens/dashboard/pengurus/laporan/laporan_pinjaman_page.dart';
import 'package:aplikasi_koperasi1/screens/dashboard/pengurus/laporan/laporan_simpanan_page.dart';
import 'package:flutter/material.dart';

class LaporanPage extends StatelessWidget {
  const LaporanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(170),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context); // Kembali ke halaman sebelumnya
                  },
                ),
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Laporan',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildLaporanItem(
              context,
              title: 'Laporan Simpanan',
              icon: Icons.folder,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LaporanSimpananPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildLaporanItem(
              context,
              title: 'Laporan Pinjaman',
              icon: Icons.folder,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LaporanPinjamanPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildLaporanItem(
              context,
              title: 'Laporan Keuangan',
              icon: Icons.folder,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LaporanKeuanganPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context); // Navigasi ke halaman Home
              },
              icon: const Icon(Icons.home, color: Colors.black, size: 30),
            ),
            Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {
                  // Navigasi ke halaman Scan QRIS
                },
                icon: const Icon(Icons.qr_code_scanner, color: Colors.black, size: 30),
              ),
            ),
            IconButton(
              onPressed: () {
                // Navigasi ke halaman Pengaturan
              },
              icon: const Icon(Icons.settings, color: Colors.black, size: 30),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLaporanItem(BuildContext context,
      {required String title, required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 24, color: Colors.black),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward, color: Colors.black),
          ],
        ),
      ),
    );
  }
}