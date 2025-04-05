import 'package:flutter/material.dart';

class DashboardPengurus extends StatelessWidget {
  final Map<String, dynamic> dashboardData;

  const DashboardPengurus({Key? key, required this.dashboardData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Balance
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Saldo Simpanan", style: TextStyle(color: Colors.white70)),
                    const SizedBox(height: 10),
                    Text(
                      "Rp 25.000.000",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: const Text("Tambah Simpanan"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Quick Actions
              const Text("Menu Pengurus", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: const [
                  QuickAction(icon: Icons.send, label: "Kirim"),
                  QuickAction(icon: Icons.payment, label: "Bayar"),
                  QuickAction(icon: Icons.request_page, label: "Pengajuan"),
                  QuickAction(icon: Icons.people, label: "Anggota"),
                  QuickAction(icon: Icons.notifications, label: "Notifikasi"),
                  QuickAction(icon: Icons.analytics, label: "Laporan"),
                  QuickAction(icon: Icons.settings, label: "Pengaturan"),
                  QuickAction(icon: Icons.person, label: "Profil"),
                ],
              ),
              const SizedBox(height: 24),

              // Upcoming Tasks
              const Text("Aktivitas Terbaru", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 12),
              const ActivityCard(name: "Eric", amount: "- Rp 240.000", type: "Mengirim uang"),
              const ActivityCard(name: "Naufal", amount: "+ Rp 120.000", type: "Meminta dana"),
              const ActivityCard(name: "Dimas", amount: "+ Rp 500.000", type: "Pinjaman disetujui"),
            ],
          ),
        ),
      ),
    );
  }
}

class QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;

  const QuickAction({Key? key, required this.icon, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 4)],
          ),
          child: Icon(icon, color: Colors.blue),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12), textAlign: TextAlign.center),
      ],
    );
  }
}

class ActivityCard extends StatelessWidget {
  final String name;
  final String amount;
  final String type;

  const ActivityCard({Key? key, required this.name, required this.amount, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.indigo.shade100,
          child: Text(name[0], style: const TextStyle(color: Colors.black)),
        ),
        title: Text(name),
        subtitle: Text(type),
        trailing: Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
