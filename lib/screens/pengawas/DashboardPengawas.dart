import 'package:flutter/material.dart';

class DashboardPengawas extends StatelessWidget {
  final Map<String, dynamic> dashboardData;

  const DashboardPengawas({super.key, required this.dashboardData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: ListView(
                  children: [
                    const SizedBox(height: 16),
                    _buildCommonTools(context),
                    const SizedBox(height: 20),
                    _buildNotice(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue[700],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Dashboard Pengawas", style: TextStyle(color: Colors.white70, fontSize: 16)),
          const SizedBox(height: 4),
          const Text("Saldo Koperasi", style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 6),
          Text(
            "\Rp. 25.000.000",
            style: TextStyle(
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBalanceItem("Total Pemasukan", "\Rp. 35.000.000"),
              _buildBalanceItem("Total Pengeluaran", "\Rp. 10.000.000"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        Text(value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
      ],
    );
  }

  Widget _buildCommonTools(BuildContext context) {
    final tools = [
      {"icon": Icons.attach_money, "label": "Laporan Keuangan", "route": "/laporan-keuangan"},
      {"icon": Icons.savings, "label": "Laporan Simpanan", "route": "/laporan-simpanan"},
      {"icon": Icons.request_page, "label": "Laporan Pinjaman", "route": "/laporan-pinjaman"},
      {"icon": Icons.show_chart, "label": "Perkembangan Koperasi", "route": "/perkembangan-koperasi"},
      {"icon": Icons.group, "label": "Data Anggota", "route": "/data-anggota"},
      {"icon": Icons.settings, "label": "Pengaturan Aplikasi", "route": "/pengaturan"},
    ];

    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: tools.map((tool) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, tool["route"] as String);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue[100],
                radius: 28,
                child: Icon(tool["icon"] as IconData, color: Colors.blue[700]),
              ),
              const SizedBox(height: 8),
              Text(
                tool["label"] as String,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildNotice() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        "Selamat datang di dashboard pengawas. Pantau semua laporan dan data koperasi dengan mudah.",
        style: TextStyle(fontSize: 14, color: Colors.black87),
        textAlign: TextAlign.center,
      ),
    );
  }
}
