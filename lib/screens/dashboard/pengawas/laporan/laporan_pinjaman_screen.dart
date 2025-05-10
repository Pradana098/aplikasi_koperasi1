import 'package:flutter/material.dart';
import 'package:aplikasi_koperasi1/screens/bottom_navbar.dart';

class LaporanPinjamanScreen extends StatelessWidget {
  const LaporanPinjamanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> laporanPinjaman = [
      {
        "nama": "Adi",
        "jumlahPinjaman": "Rp 2.000.000",
        "tanggalPengajuan": "01/02/2025",
        "status": "Disetujui"
      },
      {
        "nama": "Adi",
        "jumlahPinjaman": "Rp 2.000.000",
        "tanggalPengajuan": "01/02/2025",
        "status": "Menyetujui"
      },
    ];

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
          "Laporan Pinjaman",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Periode Laporan
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: const [
                  Icon(Icons.calendar_today, color: Colors.black),
                  SizedBox(width: 10),
                  Text(
                    "Januari - Maret 2025",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Daftar Laporan Pinjaman
            Expanded(
              child: ListView.builder(
                itemCount: laporanPinjaman.length,
                itemBuilder: (context, index) {
                  final laporan = laporanPinjaman[index];
                  return _buildLaporanCard(
                    nama: laporan["nama"]!,
                    jumlahPinjaman: laporan["jumlahPinjaman"]!,
                    tanggalPengajuan: laporan["tanggalPengajuan"]!,
                    status: laporan["status"]!,
                  );
                },
              ),
            ),

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

  Widget _buildLaporanCard({
    required String nama,
    required String jumlahPinjaman,
    required String tanggalPengajuan,
    required String status,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
              const CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Text(
                nama,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.monetization_on, color: Colors.black),
              const SizedBox(width: 10),
              Text("Jumlah Pinjaman : $jumlahPinjaman"),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.calendar_today, color: Colors.black),
              const SizedBox(width: 10),
              Text("Tanggal Pengajuan : $tanggalPengajuan"),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.assignment_turned_in, color: Colors.black),
              const SizedBox(width: 10),
              Text("Status : $status"),
            ],
          ),
        ],
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