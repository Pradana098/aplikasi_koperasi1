import 'package:flutter/material.dart';

class AnggotaDisetujuiPage extends StatelessWidget {
  const AnggotaDisetujuiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final anggotaDisetujui = [
      {
        'nama': 'Andi',
        'noTelp': '0812345678',
        'alamat': 'Muncar',
        'nip': '088221',
        'unitKerja': 'ULT Poliwangi',
      },
      {
        'nama': 'Roy',
        'noTelp': '08123456978',
        'alamat': 'Genteng',
        'nip': '088233',
        'unitKerja': 'TI Poliwangi',
      },
    ];

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
                  'Anggota Disetujui',
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
        child: ListView.builder(
          itemCount: anggotaDisetujui.length,
          itemBuilder: (context, index) {
            final data = anggotaDisetujui[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.blueAccent,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        data['nama']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'No Telp : ${data['noTelp']}',
                    style: const TextStyle(color: Colors.black54),
                  ),
                  Text(
                    'Alamat : ${data['alamat']}',
                    style: const TextStyle(color: Colors.black54),
                  ),
                  Text(
                    'NIP/NIK/NIPPPK : ${data['nip']}',
                    style: const TextStyle(color: Colors.black54),
                  ),
                  Text(
                    'Unit Kerja : ${data['unitKerja']}',
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            );
          },
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