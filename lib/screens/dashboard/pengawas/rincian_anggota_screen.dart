import 'package:flutter/material.dart';
import 'package:aplikasi_koperasi1/screens/bottom_navbar.dart';

class RincianAnggotaScreen extends StatelessWidget {
  final String nama;
  final String nomor;
  final String status;

  const RincianAnggotaScreen({
    Key? key,
    required this.nama,
    required this.nomor,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF448AFF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
        title: const Text(
          "Rincian Data Anggota",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Kartu Rincian Anggota
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: status == "Anggota" ? Colors.yellow : Colors.red,
                        radius: 30,
                        child: Text(
                          nama[0], // Inisial nama
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        nama,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text("No Telp : $nomor"),
                  Text("Alamat : Muncar"),
                  Text("NIP/NIK/NIPPPK : 088221"),
                  Text("Unit Kerja : ULT Poliwangi"),
                  Text("Pinjaman Sebesar : Rp 1.000.000"),
                  Text("Simpanan Pokok : Rp 1.000.000"),
                  Text("Simpanan Wajib : Rp 500.000"),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Tombol Unduh
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    _showDownloadDialog(context, "PDF");
                  },
                  icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
                  label: const Text("Unduh PDF"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    _showDownloadDialog(context, "Excel");
                  },
                  icon: const Icon(Icons.table_chart, color: Colors.white),
                  label: const Text("Unduh Excel"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 0, // Tetapkan index sesuai halaman aktif
        onTap: (index) {
          // Navigasi antar halaman
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/scan');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/settings');
          }
        },
      ),
    );
  }

  void _showDownloadDialog(BuildContext context, String format) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Pengunduhan Berhasil"),
        content: Text("Data berhasil diunduh dalam format $format."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}