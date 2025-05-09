import 'package:aplikasi_koperasi1/screens/dashboard/pengurus/anggota/rinciananggota.dart';
import 'package:flutter/material.dart';

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
                    Navigator.pop(context);
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
            // Tombol Filter
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFilterButton('semua'),
                _buildFilterButton('disetujui'),
                _buildFilterButton('ditolak'),
              ],
            ),
            const SizedBox(height: 20),

            // Daftar Anggota
            Expanded(
              child: ListView.builder(
                itemCount: filteredAnggota.length,
                itemBuilder: (context, index) {
                  final data = filteredAnggota[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigasi ke halaman rincian anggota
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RincianPendaftaranPage(data: data),
                        ),
                      );
                    },
                    child: _buildAnggotaCard(data, index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String label) {
    final isSelected = filter == label;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          filter = label;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue[800] : Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        label[0].toUpperCase() + label.substring(1),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildAnggotaCard(Map<String, String> data, int index) {
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
          if (data['status'] == 'disetujui' || data['status'] == 'ditolak') // Label status
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: data['status'] == 'disetujui' ? Colors.green : Colors.red,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                data['status']!.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
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
          Text('No Telp : ${data['noTelp']}',
              style: const TextStyle(color: Colors.black54)),
          Text('Alamat : ${data['alamat']}',
              style: const TextStyle(color: Colors.black54)),
          Text('NIP/NIK/NIPPPK : ${data['nip']}',
              style: const TextStyle(color: Colors.black54)),
          Text('Unit Kerja : ${data['unitKerja']}',
              style: const TextStyle(color: Colors.black54)),
          const SizedBox(height: 12),
          if (data['status'] == 'pending') // Tampilkan tombol jika status "pending"
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
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
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
                        horizontal: 24, vertical: 12),
                  ),
                  child: const Text('Tolak'),
                ),
              ],
            ),
        ],
      ),
    );
  }
}