import 'package:aplikasi_koperasi1/screens/bottom_navbar.dart';
import 'package:aplikasi_koperasi1/screens/profile_logo_screen.dart';
import 'package:flutter/material.dart';

class AnggotaDashboardScreen extends StatefulWidget {
  final Map<String, dynamic> data;

  const AnggotaDashboardScreen({Key? key, required this.data}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AnggotaDashboardScreenState createState() => _AnggotaDashboardScreenState();
}

class _AnggotaDashboardScreenState extends State<AnggotaDashboardScreen> {
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
                  ProfilSelamatDatangWidget(
                    photoUrl: photoUrl,
                    nama: userName,
                    onNotificationTap: () {},
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
}