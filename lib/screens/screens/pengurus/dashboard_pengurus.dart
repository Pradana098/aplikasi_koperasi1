import 'package:aplikasi_koperasi1/screens/bottom_navbar.dart';
import 'package:flutter/material.dart';

class PengurusDashboardScreen extends StatefulWidget {
  final Map<String, dynamic> data;

  const PengurusDashboardScreen({super.key, required this.data});

  @override
  _PengurusDashboardScreenState createState() =>
      _PengurusDashboardScreenState();
}

class _PengurusDashboardScreenState extends State<PengurusDashboardScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        top: false,
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height - 200,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFF448AFF),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
