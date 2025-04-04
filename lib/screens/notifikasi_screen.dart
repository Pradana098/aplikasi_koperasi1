import 'package:flutter/material.dart';

class NotifikasiScreen extends StatelessWidget {
  const NotifikasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notifikasi",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: false, // Posisi judul di kiri
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          Card(
            child: ListTile(
              title: Text("Pemberitahuan Penting"),
              subtitle: Text("Pengajuan pinjaman Anda telah disetujui."),
              leading: Icon(Icons.notifications_active, color: Colors.blue),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Pembayaran"),
              subtitle: Text("Jatuh tempo cicilan Anda dalam 3 hari."),
              leading: Icon(Icons.warning, color: Colors.red),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Info Koperasi"),
              subtitle: Text("Rapat tahunan koperasi akan diadakan bulan depan."),
              leading: Icon(Icons.info, color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}
