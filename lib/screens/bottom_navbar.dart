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
    // Hitung ukuran responsif berdasarkan lebar layar
    final screenWidth = MediaQuery.of(context).size.width;
    final iconSize = screenWidth * 0.08; // misal 8% lebar layar
    final buttonMinSize = iconSize + 16;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF448AFF),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Home Icon
          IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(
              minWidth: buttonMinSize,
              minHeight: buttonMinSize,
            ),
            icon: SizedBox(
              width: iconSize,
              height: iconSize,
              child: Image.asset(
                'assets/icons/icon_1.png',
                fit: BoxFit.contain,
              ),
            ),
            onPressed: () => onTap(0),
          ),

          // Scan Icon (highlighted)
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(
                minWidth: buttonMinSize,
                minHeight: buttonMinSize,
              ),
              icon: SizedBox(
                width: iconSize,
                height: iconSize,
                child: Image.asset(
                  'assets/icons/icon_3.png',
                  fit: BoxFit.contain,
                ),
              ),
              onPressed: () => onTap(1),
            ),
          ),

          // Settings Icon
          IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(
              minWidth: buttonMinSize,
              minHeight: buttonMinSize,
            ),
            icon: SizedBox(
              width: iconSize,
              height: iconSize,
              child: Image.asset(
                'assets/icons/icon_2.png',
                fit: BoxFit.contain,
              ),
            ),
            onPressed: () => onTap(2),
          ),
        ],
      ),
    );
  }
}
