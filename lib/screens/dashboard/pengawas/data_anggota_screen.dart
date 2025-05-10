import 'package:aplikasi_koperasi1/screens/dashboard/pengawas/rincian_anggota_screen.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_koperasi1/screens/bottom_navbar.dart';

class DataAnggotaScreen extends StatefulWidget {
  @override
  _DataAnggotaScreenState createState() => _DataAnggotaScreenState();
}

class _DataAnggotaScreenState extends State<DataAnggotaScreen> {
  final List<Map<String, String>> anggotaData = [
    {"nama": "Andi", "nomor": "0812345678", "status": "Anggota"},
    {"nama": "Andi", "nomor": "0812345678", "status": "Anggota"},
    {"nama": "Doni", "nomor": "0812345678", "status": "Pengurus"},
    {"nama": "Andi", "nomor": "0812345678", "status": "Pengurus"},
    {"nama": "Shofi", "nomor": "0812345678", "status": "Anggota"},
    {"nama": "Shifa", "nomor": "0812345678", "status": "Pengurus"},
  ];

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
          "Data Anggota",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                hintText: "Search",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          // List Anggota
          Expanded(
            child: ListView.builder(
              itemCount: anggotaData.length,
              itemBuilder: (context, index) {
                final anggota = anggotaData[index];
                return _buildAnggotaCard(
                  nama: anggota["nama"]!,
                  nomor: anggota["nomor"]!,
                  status: anggota["status"]!,
                );
              },
            ),
          ),
        ],
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

  Widget _buildAnggotaCard({
    required String nama,
    required String nomor,
    required String status,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RincianAnggotaScreen(
              nama: nama,
              nomor: nomor,
              status: status,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF448AFF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: status == "Anggota" ? Colors.black : Colors.black,
              child: Text(
                nama[0], // Inisial nama
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nama,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Ubah warna menjadi hitam
                    ),
                  ),
                  Text(
                    nomor,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black, // Ubah warna menjadi hitam
                    ),
                  ),
                ],
              ),
            ),
            Text(
              status,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Ubah warna menjadi hitam
              ),
            ),
          ],
        ),
      ),
    );
  }
}