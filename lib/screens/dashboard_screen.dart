import 'package:aplikasi_koperasi1/screens/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';
import 'widged/DashboardPengawas.dart';
import 'widged/DashboardPengurus.dart';
import 'widged/DashboardAnggota.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Map<String, dynamic>? dashboardData;
  String role = "";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadDashboard();
  }

  Future<void> _loadDashboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getString('role') ?? "";
    });

    ApiService apiService = ApiService();
    final data = await apiService.getDashboardData();

    if (mounted && data != null) {
      setState(() {
        dashboardData = data;
      });
    }
  }

  void _showSidebarMenu() {
   showDialog(
    context: context,
    barrierDismissible: true, // Bisa ditutup dengan tap di luar
    builder: (context) => Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: 250,
        height: double.infinity,
        color: Colors.white,
        child: SidebarMenu(role: role), // Panggil Sidebar yang sudah ada
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/img/logo.png',
              width: 50,
              height: 50,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Aplikasi Koperasi Kampus",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  "Politeknik Negeri Banyuwangi",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications, color: Colors.white),
          ),
            IconButton(
            onPressed: _showSidebarMenu, // Panggil sidebar menu saat tombol ditekan
            icon: const Icon(Icons.menu, color: Colors.white),
          ),
        ],
      ),
      // drawer: SidebarMenu(role: role),
      body:
          dashboardData == null
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Builder(
                        builder: (context) {
                          if (role == "pengawas") {
                            return DashboardPengawas(
                              dashboardData: dashboardData!,
                            );
                          } else if (role == "pengurus") {
                            return DashboardPengurus(
                              dashboardData: dashboardData!,
                            );
                          } else {
                            return DashboardAnggota(
                              dashboardData: dashboardData!,
                            );
                          }
                        },
                      ),
                    ),

                    // Tombol Logout (opsional, jika ingin diaktifkan)
                    /*
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: _logout,
                            icon: const Icon(Icons.logout, color: Colors.white),
                            label: const Text(
                              "Logout",
                              style: TextStyle(fontSize: 18),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              backgroundColor: Colors.redAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                  */
                  ],
                ),
              ),
    );
  }
}
