import 'package:flutter/material.dart';

class LaporanPengajuanPinjamanScreen extends StatelessWidget {
  const LaporanPengajuanPinjamanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF448AFF),
        title: const Text("Laporan Pengajuan Pinjaman"),
        centerTitle: true,
      ),
      body: Center(
        child: const Text(
          "Halaman Laporan Pengajuan Pinjaman",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}