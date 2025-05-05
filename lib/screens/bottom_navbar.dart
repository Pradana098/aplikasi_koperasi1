import 'package:flutter/material.dart';

/// A custom pill-shaped bottom navigation bar with three asset icons:
/// Home (assets/icons/icon_1.png), Scan (assets/icons/icon_3.png), and Settings (assets/icons/icon_2.png).
/// Icons size adjust responsively based on screen width.
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Color(0xFF448AFF),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: const Icon(Icons.home), onPressed: () {}, color: Colors.black),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
              child: const Icon(Icons.qr_code, color: Colors.black),
            ),
            IconButton(icon: const Icon(Icons.settings), onPressed: () {}, color: Colors.black),
          ],
        ),
      );
  }
}
