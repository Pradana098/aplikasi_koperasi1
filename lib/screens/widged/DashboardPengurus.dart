import 'package:flutter/material.dart';

class DashboardPengurus extends StatelessWidget {
  final Map<String, dynamic> dashboardData;

  const DashboardPengurus({super.key, required this.dashboardData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
        "dashboard pengurus"
        ),
        const Spacer(),
      ],
    );
  }
}
