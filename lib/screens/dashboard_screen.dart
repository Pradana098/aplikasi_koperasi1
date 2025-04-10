import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';
import 'menu_screen.dart'; // SidebarMenu
import 'pengawas/DashboardPengawas.dart';
import 'pengurus/DashboardPengurus.dart';
import 'anggota/DashboardAnggota.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Map<String, dynamic>? dashboardData;
  String role = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRoleAndDashboard();
  }

  Future<void> _loadRoleAndDashboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedRole = prefs.getString('role');

    if (storedRole == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    setState(() {
      role = storedRole;
    });

    ApiService apiService = ApiService();
    final data = await apiService.getDashboardData();

    if (mounted) {
      setState(() {
        dashboardData = data;
        isLoading = false;
      });
    }
  }

  void _showSidebarMenu() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Align(
        alignment: Alignment.centerRight,
        child: Container(
          width: 250,
          height: double.infinity,
          color: Colors.white,
          child: SidebarMenu(role: role),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        title: Row(
          children: [
            Image.asset('assets/img/logo.png', width: 40, height: 40),
            const SizedBox(width: 8),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Aplikasi Koperasi Kampus",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  Text(
                    "Politeknik Negeri Banyuwangi",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: Colors.white)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications, color: Colors.white)),
          IconButton(onPressed: _showSidebarMenu, icon: const Icon(Icons.menu, color: Colors.white)),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : dashboardData == null
              ? const Center(child: Text("Gagal memuat data dashboard."))
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Expanded(
                        child: Builder(
                          builder: (context) {
                            switch (role) {
                              case 'pengawas':
                                return DashboardPengawas(dashboardData: dashboardData!);
                              case 'pengurus':
                                return DashboardPengurus(dashboardData: dashboardData!);
                              default:
                                return DashboardAnggota(dashboardData: dashboardData!);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}