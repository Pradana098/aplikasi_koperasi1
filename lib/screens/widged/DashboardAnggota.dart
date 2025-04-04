import 'package:flutter/material.dart';

class DashboardAnggota extends StatelessWidget {
  final Map<String, dynamic> dashboardData;

  const DashboardAnggota({super.key, required this.dashboardData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
         "Dashboard anggota"
        ),
        const Spacer(),
      ],
    );
  }
}
