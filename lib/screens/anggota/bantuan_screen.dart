import 'package:flutter/material.dart';

class BantuanScreen extends StatelessWidget {
  const BantuanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bantuan'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Text("Hubungi Kami:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("📞 WhatsApp: 0812-3456-7890"),
            Text("✉️ Email: koperasi@poliwangi.ac.id"),
            SizedBox(height: 20),
            Text("FAQ:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("• Bagaimana cara menyetor simpanan?"),
            Text("• Bagaimana cara mengajukan pinjaman?"),
            // Tambahkan sesuai kebutuhan
          ],
        ),
      ),
    );
  }
}
