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
          const Text("Chain Catering", style: TextStyle(color: Colors.white70, fontSize: 16)),
          const SizedBox(height: 4),
          const Text("Current Balance", style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 6),
          Text(
            "\$2000.00",
            style: TextStyle(
              fontSize: 36,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBalanceItem("Total Income", "\$1358.5"),
              _buildBalanceItem("Total Outcome", "\$266.0"),
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
      {"icon": Icons.account_balance_wallet, "label": "Cash Withdrawal", "route": "/laporan-simpanan"},
      {"icon": Icons.attach_money, "label": "Withdrawal Record", "route": "/laporan-pinjaman"},
      {"icon": Icons.credit_card, "label": "My Bank Card", "route": "/profil"},
      {"icon": Icons.store, "label": "Store Info", "route": "/pengaturan"},
      {"icon": Icons.share, "label": "Share Plan", "route": "/download-laporan"},
      {"icon": Icons.pie_chart, "label": "Distribution", "route": "/laporan-keuangan"},
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
        "We wish everyone a prosperous and prosperous future. Happy New Year!",
        style: TextStyle(fontSize: 14, color: Colors.black87),
        textAlign: TextAlign.center,
      ),
    );
  }
}
