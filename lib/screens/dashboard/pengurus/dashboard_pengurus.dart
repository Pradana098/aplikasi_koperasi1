import 'package:aplikasi_koperasi1/screens/bottom_navbar.dart';
import 'package:aplikasi_koperasi1/screens/dashboard/pengurus/anggota/Kelola_anggota.dart';
import 'package:aplikasi_koperasi1/screens/dashboard/pengurus/laporan/laporan_page.dart';
import 'package:aplikasi_koperasi1/screens/dashboard/pengurus/pengajuan_pinjaman_page.dart';
import 'package:aplikasi_koperasi1/screens/dashboard/pengurus/simpan_pinjam/simpan_pinjam.dart';
import 'package:aplikasi_koperasi1/screens/dashboard/pengurus/kirim_notifikasi.dart';
import 'package:aplikasi_koperasi1/screens/profile_logo_screen.dart';
import 'package:aplikasi_koperasi1/services/api_service.dart';
import 'package:flutter/material.dart';

class PengurusDashboardScreen extends StatefulWidget {
  final Map<String, dynamic> data;

  const PengurusDashboardScreen({super.key, required this.data});

  @override
  State<PengurusDashboardScreen> createState() =>
      _PengurusDashboardScreenState();
}

class _PengurusDashboardScreenState extends State<PengurusDashboardScreen> {
  int _currentIndex = 0;
  int? _totalAnggota;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    getJumlahAnggota();
  }

  Future<void> getJumlahAnggota() async {
    try {
      final jumlah = await _apiService.fetchTotalAnggota();
      setState(() {
        _totalAnggota = jumlah;
      });
    } catch (e) {
      debugPrint('Error fetching total anggota: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final photoUrl = widget.data['profile_photo'] as String?;
    final userName = widget.data['nama'] ?? 'Pengurus';
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
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
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfilSelamatDatangWidget(
                    photoUrl:
                        (photoUrl != null && photoUrl.isNotEmpty)
                            ? photoUrl
                            : 'assets/profile/avatar_1.png',
                    nama: userName,
                    onNotificationTap: () {},
                  ),
                  const SizedBox(height: 10),
                  _buildStatisticsSection(),
                  _buildMenuGrid(),
                  _buildDevelopmentGraph(),
                  _buildActivityHistory(),
                  const SizedBox(height: 10),
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

  Widget _buildStatisticsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Statistik Koperasi',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  icon: Icons.group_outlined,
                  title: 'Total Anggota',
                  value: _totalAnggota?.toString() ?? '-',
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: _buildStatCard(
                  icon: Icons.account_balance_wallet_outlined,
                  title: 'Pinjaman Aktif',
                  value: '35',
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: _buildStatCard(
                  icon: Icons.account_balance_outlined,
                  title: 'Total Simpanan',
                  value: 'Rp 240.000.000',
                  isSmallText: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    bool isSmallText = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 1)),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: isSmallText ? 11 : 13,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuGrid() {
    final List<Map<String, dynamic>> menuItems = [
      {
        'icon': Icons.group,
        'label': 'Kelola Anggota',
        'route': '/kelolaAnggota',
      },
      {'icon': Icons.trending_up, 'label': 'Grafik', 'route': '/grafik'},
      {
        'icon': Icons.notifications,
        'label': 'Kirim Notifikasi',
        'route': '/notifikasi',
      },
      {
        'icon': Icons.money,
        'label': 'Pembayaran Pinjaman',
        'route': '/persetujuanPinjaman',
      },
      {'icon': Icons.description, 'label': 'Laporan', 'route': '/laporan'},
      {
        'icon': Icons.edit_note,
        'label': 'Pengajuan Pinjaman',
        'route': '/pengajuanPinjaman',
      },
      {
        'icon': Icons.account_balance_wallet,
        'label': 'Simpan Pinjam',
        'route': '/simpanPinjam',
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.count(
        crossAxisCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children:
            menuItems.map((item) {
              return _buildMenuItem(
                item['icon'],
                item['label'],
                route: item['route'],
              );
            }).toList(),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label, {String? route}) {
    return InkWell(
      onTap: () {
        if (route != null) {
          if (route == '/kelolaAnggota') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => KelolaAnggotaPage(),
              ), // Pastikan widget ini ada
            );
          } else if (route == '/simpanPinjam') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SimpanPinjamPage(),
              ), // Navigasi ke halaman Simpan Pinjam
            );
          } else if (route == '/pengajuanPinjaman') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PengajuanPinjamanPage(),
              ), // Navigasi ke halaman Pengajuan Pinjaman
            );
          } else if (route == '/notifikasi') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const KirimNotifikasiPage(),
              ),
            );
          } else if (route == '/laporan') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LaporanPage()),
            );
          } else {
            Navigator.of(context).pushNamed(route);
          }
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Icon(icon, size: 28, color: Colors.black),
          ),
          const SizedBox(height: 6),
          Flexible(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, color: Colors.black87),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDevelopmentGraph() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Grafik Perkembangan Koperasi',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              Icon(Icons.trending_up),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: const Center(child: Text('Grafik Perkembangan Koperasi')),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityHistory() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Riwayat Kegiatan',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: const Text('Belum ada riwayat kegiatan terbaru.'),
          ),
        ],
      ),
    );
  }
}
