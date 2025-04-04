import 'package:flutter/material.dart';

class DashboardPengawas extends StatelessWidget {
  final Map<String, dynamic> dashboardData;

  const DashboardPengawas({super.key, required this.dashboardData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
         "dashboard pengawas"
        ),
        const Spacer(),
      ],
    );
  }
}
