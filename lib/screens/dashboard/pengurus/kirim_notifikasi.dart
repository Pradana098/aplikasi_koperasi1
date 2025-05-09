import 'package:flutter/material.dart';

class KirimNotifikasiPage extends StatefulWidget {
  const KirimNotifikasiPage({super.key});

  @override
  State<KirimNotifikasiPage> createState() => _KirimNotifikasiPageState();
}

class _KirimNotifikasiPageState extends State<KirimNotifikasiPage> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _pesanController = TextEditingController();
  String _selectedPenerima = 'Semua Anggota'; // Default penerima

  final List<String> _penerimaOptions = [
    'Semua Anggota',
    'Anggota Aktif',
    'Anggota Tidak Aktif',
  ];

  void _kirimNotifikasi() {
    final judul = _judulController.text.trim();
    final pesan = _pesanController.text.trim();

    if (judul.isEmpty || pesan.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Judul dan pesan tidak boleh kosong!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Logika pengiriman notifikasi (contoh)
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Notifikasi Terkirim'),
          content: Text('Notifikasi berhasil dikirim ke $_selectedPenerima'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Tutup dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );

    // Reset form setelah pengiriman
    _judulController.clear();
    _pesanController.clear();
    setState(() {
      _selectedPenerima = 'Semua Anggota';
    });
  }

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
                  'Kirim Notifikasi',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Kepada',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedPenerima,
              items: _penerimaOptions
                  .map((penerima) => DropdownMenuItem(
                        value: penerima,
                        child: Text(penerima),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPenerima = value!;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Judul',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _judulController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                hintText: 'Masukkan judul notifikasi',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Pesan',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _pesanController,
              maxLines: 4,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                hintText: 'Masukkan pesan notifikasi',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: _kirimNotifikasi,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Kirim Notifikasi',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
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
                // Navigasi ke halaman Home
                Navigator.pop(context); // Contoh kembali ke halaman sebelumnya
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
}