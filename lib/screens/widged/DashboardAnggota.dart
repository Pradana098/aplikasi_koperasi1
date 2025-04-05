import 'package:flutter/material.dart';

class DashboardAnggota extends StatelessWidget {
  final Map<String, dynamic> dashboardData;

  const DashboardAnggota({super.key, required this.dashboardData});

  @override
  Widget build(BuildContext context) {
    final nama = dashboardData['nama'] ?? 'Anggota';
    final saldo = dashboardData['saldo'] ?? 0;

    final List<Map<String, String>> catatanSimpanan = [
      {"tanggal": "01 April 2025", "jumlah": "Rp 100.000"},
      {"tanggal": "15 Maret 2025", "jumlah": "Rp 200.000"},
      {"tanggal": "28 Februari 2025", "jumlah": "Rp 150.000"},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Saldo Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.shade100,
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Available Balance", style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 10),
                  Text(
                    "Rp ${saldo.toString()}",
                    style: const TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/setor'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text("Setor Simpanan"),
                  )
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Menu Grid
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildMenuItem(context, Icons.history, 'Riwayat', '/riwayat'),
                _buildMenuItem(context, Icons.attach_money, 'Pinjaman', '/pengajuan'),
                _buildMenuItem(context, Icons.notifications, 'Notifikasi', '/notifikasi'),
                _buildMenuItem(context, Icons.person, 'Profil', '/profil'),
              ],
            ),

            const SizedBox(height: 30),

            // Catatan Keuangan
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Catatan Keuangan", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                ...catatanSimpanan.map((item) {
                  return _buildActivity("Setor Simpanan (${item['tanggal']})", "+${item['jumlah']}");
                }).toList(),
              ],
            ),

            const SizedBox(height: 30),

            // Ringkasan Informasi
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Ringkasan", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _buildSummaryItem("Pinjaman Aktif", "Rp 500.000"),
                  _buildSummaryItem("Total Simpanan", "Rp 1.500.000"),
                  _buildSummaryItem("Terakhir Login", "05 April 2025"),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Tombol Bantuan
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/bantuan'),
              icon: const Icon(Icons.help_outline),
              label: const Text("Bantuan"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade100,
                foregroundColor: Colors.blue.shade900,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),

            const SizedBox(height: 20),

            // Footer Branding
            Center(
              child: Column(
                children: const [
                  Text("Koperasi Poliwangi", style: TextStyle(fontSize: 14, color: Colors.grey)),
                  SizedBox(height: 4),
                  Text("© 2025 All Rights Reserved", style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String label, String route) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.blueAccent, size: 28),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildActivity(String title, String amount) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 14)),
          Text(amount, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 14, color: Colors.black87)),
          Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
