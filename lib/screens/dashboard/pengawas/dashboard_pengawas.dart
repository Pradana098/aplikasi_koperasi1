import 'package:aplikasi_koperasi1/screens/bottom_navbar.dart';
import 'package:aplikasi_koperasi1/screens/dashboard/pengawas/laporan/laporan_screen.dart';
import 'package:aplikasi_koperasi1/screens/profile_logo_screen.dart';
import 'package:aplikasi_koperasi1/screens/dashboard/pengawas/data_anggota_screen.dart';
import 'package:flutter/material.dart';

class PengawasDashboardScreen extends StatefulWidget {
  final Map<String, dynamic> data;

  const PengawasDashboardScreen({super.key, required this.data});

  @override
  _PengawasDashboardScreenState createState() =>
      _PengawasDashboardScreenState();
}

class _PengawasDashboardScreenState extends State<PengawasDashboardScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final photoUrl = widget.data['profile_photo'] as String?;
    final userName = widget.data['nama'] ?? 'Pengawas';
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Header Background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: screenHeight * 0.25 + MediaQuery.of(context).padding.top,
              decoration: const BoxDecoration(
                color: Color(0xFF448AFF),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profil Selamat Datang
                  ProfilSelamatDatangWidget(
                    photoUrl: photoUrl,
                    nama: userName,
                    onNotificationTap: () {},
                  ),
                  const SizedBox(height: 20),

                  // Statistik Koperasi
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: _buildStatistikCard(
                            icon: Icons.people,
                            title: "Total Anggota",
                            value: "120",
                          ),
                        ),
                        const SizedBox(width: 10), // Jarak antar kartu
                        Expanded(
                          child: _buildStatistikCard(
                            icon: Icons.work,
                            title: "Pinjaman Aktif",
                            value: "35",
                          ),
                        ),
                        const SizedBox(width: 10), // Jarak antar kartu
                        Expanded(
                          child: _buildStatistikCard(
                            icon: Icons.savings,
                            title: "Total Simpanan",
                            value: "Rp 240.000.000",
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Menu Aksi
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildMenuCard(
                          icon: Icons.group,
                          title: "Daftar Anggota",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DataAnggotaScreen()),
                            );
                          },
                        ),
                        _buildMenuCard(
                          icon: Icons.insert_chart,
                          title: "Laporan",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LaporanScreen()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Grafik Perkembangan Koperasi
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Grafik Perkembangan Koperasi",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.show_chart,
                              size: 50,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Riwayat Aktivitas
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Riwayat Aktivitas Anggota dan Pengurus:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildRiwayatCard(
                          nama: "Andi",
                          aktivitas: "Mengajukan Pinjaman",
                          waktu: "10:45",
                        ),
                        _buildRiwayatCard(
                          nama: "Andi",
                          aktivitas: "Mengajukan Pinjaman",
                          waktu: "10:45",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }

  Widget _buildStatistikCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: Colors.blueAccent),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 30, color: Colors.blueAccent),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRiwayatCard({
    required String nama,
    required String aktivitas,
    required String waktu,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.access_time, color: Colors.blueAccent),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "$nama $aktivitas ($waktu)",
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
