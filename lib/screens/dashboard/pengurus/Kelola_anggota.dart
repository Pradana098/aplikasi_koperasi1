import 'package:aplikasi_koperasi1/screens/bottom_navbar.dart';
import 'package:flutter/material.dart';

class KelolaAnggota extends StatefulWidget {
  final Map<String, dynamic> data;

  const KelolaAnggota({Key? key, required this.data}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _KelolaAnggotaState createState() => _KelolaAnggotaState();
}

class _KelolaAnggotaState extends State<KelolaAnggota> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
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
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(
                    top:
                        MediaQuery.of(context).padding.top +
                        4, // posisi lebih ke atas
                    left: 16,
                    right: 16,
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.arrow_back, color: Colors.black, size: 28),
                      SizedBox(width: 12),
                      Text(
                        'Pengelolaan Anggota',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.25),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 24),

                  // Kotak putih latar belakang menu
                  Center(
                    child: Container(
                      height: 300,
                      width: 448,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 75, 75, 75), // Warna latar belakang
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _MenuTile(
                            iconPath: 'assets/icons/icon_5.png',
                            title: 'Pendaftaran Anggota Baru',
                            onTap: () {
                              // Handle tap
                            },
                          ),
                          const SizedBox(height: 16),
                          _MenuTile(
                            iconPath: 'assets/icons/icon_5.png',
                            title: 'Data Anggota',
                            onTap: () {
                              // Handle tap
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Bottom Navigation
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}

// Reusable MenuTile widget
class _MenuTile extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback onTap;

  const _MenuTile({
    required this.title,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Image.asset(iconPath, width: 32, height: 32),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
