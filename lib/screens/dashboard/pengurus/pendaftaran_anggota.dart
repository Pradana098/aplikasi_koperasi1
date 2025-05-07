import 'package:flutter/material.dart';
import 'anggota_disetujui.dart'; // Import halaman Anggota Disetujui

class PendaftaranAnggotaPage extends StatefulWidget {
  const PendaftaranAnggotaPage({super.key});

  @override
  State<PendaftaranAnggotaPage> createState() => _PendaftaranAnggotaPageState();
}

class _PendaftaranAnggotaPageState extends State<PendaftaranAnggotaPage> {
  // Data anggota
  final List<Map<String, String>> anggota = [
    {
      'nama': 'Andi',
      'noTelp': '0812345678',
      'alamat': 'Muncar',
      'nip': '088221',
      'unitKerja': 'ULT Poliwangi',
      'status': 'disetujui',
    },
    {
      'nama': 'Roy',
      'noTelp': '08123456978',
      'alamat': 'Genteng',
      'nip': '088233',
      'unitKerja': 'TI Poliwangi',
      'status': 'ditolak',
    },
    {
      'nama': 'Reni',
      'noTelp': '08123456789',
      'alamat': 'Banyuwangi',
      'nip': '088245',
      'unitKerja': 'TI Poliwangi',
      'status': 'pending',
    },
  ];

  String filter = 'semua'; // Filter default

  @override
  Widget build(BuildContext context) {
    // Filter data anggota berdasarkan status
    final filteredAnggota = filter == 'semua'
        ? anggota
        : anggota.where((item) => item['status'] == filter).toList();

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
                  'Pendaftaran Anggota',
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
          children: [
            // Filter tombol
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFilterButton('Semua', Colors.blueAccent, () {
                  setState(() {
                    filter = 'semua';
                  });
                }),
                _buildFilterButton('Disetujui', Colors.blueAccent, () {
                  setState(() {
                    filter = 'disetujui';
                  });
                }),
                _buildFilterButton('Ditolak', Colors.blueAccent, () {
                  setState(() {
                    filter = 'ditolak';
                  });
                }),
              ],
            ),
            const SizedBox(height: 20),

            // Daftar anggota
            Expanded(
              child: ListView.builder(
                itemCount: filteredAnggota.length,
                itemBuilder: (context, index) {
                  final data = filteredAnggota[index];
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
                              backgroundColor: Colors.black,
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
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  data['status'] = 'disetujui';
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF00FF00),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                              child: const Text('Setujui'),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  data['status'] = 'ditolak';
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                              child: const Text('Tolak'),
                            ),
                          ],
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

  Widget _buildFilterButton(String label, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}