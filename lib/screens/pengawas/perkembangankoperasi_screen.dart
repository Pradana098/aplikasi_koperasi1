import 'package:flutter/material.dart';

class PerkembanganKoperasiScreen extends StatelessWidget {
  const PerkembanganKoperasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text("Perkembangan Koperasi"),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(16),
          child: const Text(
            "Grafik dan data perkembangan koperasi akan ditampilkan di sini.",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
