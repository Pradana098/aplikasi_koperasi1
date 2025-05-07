import 'package:flutter/material.dart';

class RincianPendaftaranPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const RincianPendaftaranPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[700],
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(child: _buildDetailContainer()),
            _buildBottomNavBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black, size: 30),
            onPressed: () => Navigator.pop(context),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              'Rincian Pendaftaran\nAnggota Baru',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          buildDetailRow(Icons.person, 'Nama Lengkap', 'Roy'),
          buildDetailRow(Icons.badge, 'NIK', '243578906543258'),
          buildDetailRow(Icons.calendar_month, 'Tempat, tanggal lahir', 'Banyuwangi, 21 November 1998'),
          buildDetailRow(Icons.location_on, 'Alamat', 'Genteng'),
          buildDetailRow(Icons.phone_android, 'Nomor Telepon', '0812345678'),
          buildDetailRow(Icons.work, 'Unit Kerja', 'TI Poliwangi'),
          SizedBox(height: 24),
          Text('Lampiran:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          _buildAttachmentRow(),
          SizedBox(height: 40),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 28, color: Colors.blue),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: 14, color: Colors.black54)),
                SizedBox(height: 4),
                Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.description, color: Colors.blue),
            SizedBox(width: 8),
            Text('SK Perjanjian Kerja'),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            // Implementasi lihat dokumen
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          child: Text('Lihat'),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            // Logika tolak
          },
          icon: Icon(Icons.cancel),
          label: Text('Tolak'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            // Logika setuju
          },
          icon: Icon(Icons.check_circle),
          label: Text('Setuju'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavBar() {
  return Container(
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
            // Aksi tombol Home
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
              // Aksi tombol QR Code
            },
            icon: const Icon(Icons.qr_code_scanner,
                color: Colors.black, size: 30),
          ),
        ),
        IconButton(
          onPressed: () {
            // Aksi tombol Settings
          },
          icon: const Icon(Icons.settings, color: Colors.black, size: 30),
        ),
      ],
    ),
  );
}
}