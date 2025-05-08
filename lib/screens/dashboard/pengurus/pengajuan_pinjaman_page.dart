import 'package:flutter/material.dart';

class PengajuanPinjamanPage extends StatefulWidget {
  const PengajuanPinjamanPage({super.key});

  @override
  State<PengajuanPinjamanPage> createState() => _PengajuanPinjamanPageState();
}

class _PengajuanPinjamanPageState extends State<PengajuanPinjamanPage> {
  // Daftar pengajuan pinjaman
  final List<Map<String, dynamic>> _pengajuanPinjaman = [
    {'nama': 'Andi', 'jumlah': 2000000, 'status': 'Menunggu'},
    {'nama': 'Doni', 'jumlah': 2000000, 'status': 'Menunggu'},
  ];

  String _filterStatus = 'Semua'; // Status filter default

  void _updateStatus(int index, String status) {
    setState(() {
      _pengajuanPinjaman[index]['status'] = status;
    });
  }

  List<Map<String, dynamic>> _getFilteredPengajuan() {
    if (_filterStatus == 'Semua') {
      return _pengajuanPinjaman;
    }
    return _pengajuanPinjaman
        .where((pengajuan) => pengajuan['status'] == _filterStatus)
        .toList();
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
                  'Pengajuan Pinjaman',
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
            _buildFilterButtons(),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _getFilteredPengajuan().length,
                itemBuilder: (context, index) {
                  final pengajuan = _getFilteredPengajuan()[index];
                  return _buildPengajuanCard(
                    nama: pengajuan['nama'],
                    jumlah: pengajuan['jumlah'],
                    status: pengajuan['status'],
                    onSetujui: () => _updateStatus(index, 'Disetujui'),
                    onTolak: () => _updateStatus(index, 'Ditolak'),
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

  Widget _buildFilterButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              _filterStatus = 'Semua'; // Tampilkan semua pengajuan
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _filterStatus == 'Semua'
                ? Colors.blueAccent
                : Colors.grey[300],
          ),
          child: const Text('Semua'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _filterStatus = 'Ditolak'; // Tampilkan pengajuan yang ditolak
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _filterStatus == 'Ditolak'
                ? Colors.blueAccent
                : Colors.grey[300],
          ),
          child: const Text('Tolak'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _filterStatus = 'Disetujui'; // Tampilkan pengajuan yang disetujui
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _filterStatus == 'Disetujui'
                ? Colors.blueAccent
                : Colors.grey[300],
          ),
          child: const Text('Disetujui'),
        ),
      ],
    );
  }

  Widget _buildPengajuanCard({
    required String nama,
    required int jumlah,
    required String status,
    required VoidCallback onSetujui,
    required VoidCallback onTolak,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (status == 'Disetujui' || status == 'Ditolak') // Tampilkan label status
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: status == 'Disetujui' ? Colors.green : Colors.red,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                status,
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
                radius: 20,
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Text(
                nama,
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
            'Jumlah: Rp ${jumlah.toString()}',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          if (status == 'Menunggu') // Tampilkan tombol hanya jika status "Menunggu"
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: onSetujui,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF00FF00),
                    ),
                    child: const Text('Setujui'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: onTolak,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Tolak'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}