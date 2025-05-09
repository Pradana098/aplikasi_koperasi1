import 'package:aplikasi_koperasi1/screens/dashboard/pengurus/anggota/data_anggota.dart';
import 'package:aplikasi_koperasi1/screens/dashboard/pengurus/anggota/pendaftaran_anggota.dart';
import 'package:flutter/material.dart';
//import 'tambah_anggota.dart'; // Import halaman Tambah Anggota
//import 'edit_anggota.dart'; // Import halaman Edit Anggota
//import 'hapus_anggota.dart'; // Import halaman Hapus Anggota

class KelolaAnggotaPage extends StatelessWidget {
  const KelolaAnggotaPage({super.key});

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
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context); // Kembali ke halaman sebelumnya
                  },
                ),
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Pengelolaan Anggota',
                  style: TextStyle(
                    color: Colors.white,
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
            // Tombol Pendaftaran Anggota Baru
            _buildMenuButton(
              context,
              icon: Icons.folder,
              label: 'Pendaftaran Anggota Baru',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PendaftaranAnggotaPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            // Tombol Data Anggota
            _buildMenuButton(
              context,
              icon: Icons.folder,
              label: 'Data Anggota',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DataAnggotaPage(),
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
                // Aksi untuk tombol Home
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
                  // Aksi untuk tombol QR Code
                },
                icon: const Icon(Icons.qr_code_scanner,
                    color: Colors.black, size: 30),
              ),
            ),
            IconButton(
              onPressed: () {
                // Aksi untuk tombol Settings
              },
              icon: const Icon(Icons.settings, color: Colors.black, size: 30),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.black),
                const SizedBox(width: 12),
                Text(
                  label,
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
