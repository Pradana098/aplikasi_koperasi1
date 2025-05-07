import 'package:flutter/material.dart';
import 'tambah_anggota.dart'; // Import halaman Tambah Anggota
import 'edit_anggota.dart'; // Import halaman Edit Anggota
import 'hapus_anggota.dart'; // Import halaman Hapus Anggota

class DataAnggotaPage extends StatelessWidget {
  const DataAnggotaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final names = ['Andi', 'Roy', 'Reni', 'Siti'];
    final phones = ['08123456789', '08123456780', '08123456781', '08123456782'];

    return Scaffold(
      backgroundColor: Colors.white, // Warna latar belakang paling belakang
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(170), // Tinggi AppBar diperpanjang hingga setengah layar
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blueAccent, // Warna latar belakang blueAccent
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppBar(
                backgroundColor: Colors.transparent, // Transparan agar warna container terlihat
                elevation: 0, // Hilangkan bayangan AppBar
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black), // Ikon panah warna putih
                  onPressed: () {
                    Navigator.pop(context); // Kembali ke halaman sebelumnya
                  },
                ),
                title: const Text(
                  'Data Anggota',
                  style: TextStyle(
                    color: Colors.black, // Warna teks putih
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          height: 500, // Tinggi border dibatasi
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[200], // Background abu-abu
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                // Search dan tombol tambah
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                            border: InputBorder.none,
                            icon: Icon(Icons.search, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TambahAnggotaPage(), // Navigasi ke halaman Tambah Anggota
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // Latar belakang putih
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(14),
                      ),
                      child: const Icon(Icons.add, color: Colors.black), // Ikon tambah warna hitam
                    )
                  ],
                ),

                const SizedBox(height: 20),

                // Daftar anggota
                Expanded(
                  child: ListView.builder(
                    itemCount: names.length, // Ganti sesuai jumlah data
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent, // Background putih untuk setiap anggota
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            // Ikon user
                            const Icon(Icons.person, color: Colors.black, size: 40),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    names[index],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black, // Warna teks hitam
                                    ),
                                  ),
                                  Text(
                                    phones[index],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54, // Warna teks abu-abu
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Tombol edit
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditAnggotaPage(nama: names[index]), // Navigasi ke halaman Edit Anggota
                                  ),
                                );
                              },
                              icon: const Icon(Icons.edit, color: Colors.green), // Ikon edit warna hijau
                              splashRadius: 24, // Ukuran lingkaran klik
                            ),
                            const SizedBox(width: 8),
                            // Tombol hapus
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HapusAnggotaPage(), // Navigasi ke halaman Hapus Anggota
                                  ),
                                );
                              },
                              icon: const Icon(Icons.delete, color: Colors.red), // Ikon hapus warna merah
                              splashRadius: 24, // Ukuran lingkaran klik
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16), // Lengkungan di sisi kiri atas
            topRight: Radius.circular(16), // Lengkungan di sisi kanan atas
          ),
          border: Border(top: BorderSide(color: Colors.blueAccent.shade700, width: 2)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Icon(Icons.home, color: Colors.black, size: 30), // Ikon warna hitam
            Icon(Icons.qr_code_scanner, color: Colors.black, size: 30), // Ikon warna hitam
            Icon(Icons.settings, color: Colors.black, size: 30), // Ikon warna hitam
          ],
        ),
      ),
    );
  }
}
