import 'package:flutter/material.dart';

class HapusAnggotaPage extends StatelessWidget {
  const HapusAnggotaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Background hitam sesuai desain
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white, // Background putih untuk dialog
            borderRadius: BorderRadius.circular(16), // Border melengkung
          ),
          width: MediaQuery.of(context).size.width * 0.8, // Lebar dialog 80% dari layar
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Hapus Anggota',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Warna teks hitam
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Apakah Anda yakin ingin menghapus anggota ini?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54, // Warna teks abu-abu
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Kembali tanpa menghapus
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey, // Tombol batal warna abu-abu
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Border melengkung
                      ),
                    ),
                    child: const Text('Batal'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Logika hapus anggota
                      print('Anggota dihapus');
                      Navigator.pop(context); // Kembali setelah menghapus
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Tombol hapus warna merah
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Border melengkung
                      ),
                    ),
                    child: const Text('Hapus'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}