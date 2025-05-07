import 'package:flutter/material.dart';
import 'edit_anggota.dart'; // Import halaman Edit Anggota
import 'hapus_anggota.dart'; // Import halaman Hapus Anggota
import 'tambah_anggota.dart'; // Import halaman Tambah Anggota

class DataAnggotaPage extends StatelessWidget {
  const DataAnggotaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final names = ['Andi', 'Roy', 'Reni', 'Siti'];
    final phones = ['08123456789', '08123456780', '08123456781', '08123456782'];

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
                  icon: const Icon(Icons.arrow_back, color: Colors.black), // Warna ikon panah menjadi hitam
                  onPressed: () {
                    Navigator.pop(context); // Kembali ke halaman sebelumnya
                  },
                ),
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Data Anggota',
                  style: TextStyle(
                    color: Colors.black, // Warna teks menjadi hitam
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
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Search bar dan tombol tambah
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
                        icon: Icon(Icons.search, color: Colors.black), // Warna ikon search menjadi hitam
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Navigasi ke halaman Tambah Anggota
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TambahAnggotaPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(14),
                  ),
                  child: const Icon(Icons.add, color: Colors.black), // Warna ikon tambah menjadi hitam
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Daftar anggota dengan border
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1.5,
                  ),
                ),
                child: ListView.builder(
                  itemCount: names.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[200], // Warna background item menjadi abu-abu terang
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.person, color: Colors.black, size: 40), // Warna ikon user menjadi hitam
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
                                    color: Colors.black, // Warna teks nama menjadi hitam
                                  ),
                                ),
                                Text(
                                  phones[index],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54, // Warna teks nomor telepon menjadi abu-abu gelap
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // Navigasi ke halaman Edit Anggota
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditAnggotaPage(nama: names[index]),
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit, color: Colors.green),
                            splashRadius: 24,
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: () {
                              // Navigasi ke halaman Hapus Anggota
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HapusAnggotaPage(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.delete, color: Colors.red),
                            splashRadius: 24,
                          ),
                        ],
                      ),
                    );
                  },
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
                icon: const Icon(Icons.qr_code_scanner, color: Colors.black, size: 30),
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
}