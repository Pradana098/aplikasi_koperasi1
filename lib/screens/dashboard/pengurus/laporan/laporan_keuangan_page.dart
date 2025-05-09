import 'package:flutter/material.dart';

class LaporanKeuanganPage extends StatelessWidget {
  const LaporanKeuanganPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(170),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context); // Kembali ke halaman sebelumnya
                  },
                ),
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Laporan Keuangan',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 24, color: Colors.black),
                const SizedBox(width: 12),
                const Text(
                  'Januari - Maret 2025',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildKeuanganCard(
              totalPemasukan: 30000000,
              totalPengeluaran: 10000000,
              saldoAkhir: 20000000,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Logika unduh PDF
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  icon: const Icon(Icons.download, color: Colors.white),
                  label: const Text(
                    'Unduh PDF',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Logika unduh Excel
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  icon: const Icon(Icons.download, color: Colors.white),
                  label: const Text(
                    'Unduh Excel',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context); // Navigasi ke halaman Home
              },
              icon: const Icon(Icons.home, color: Colors.black, size: 30),
            ),
            Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {
                  // Navigasi ke halaman Scan QRIS
                },
                icon: const Icon(Icons.qr_code_scanner, color: Colors.black, size: 30),
              ),
            ),
            IconButton(
              onPressed: () {
                // Navigasi ke halaman Pengaturan
              },
              icon: const Icon(Icons.settings, color: Colors.black, size: 30),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeuanganCard({
    required int totalPemasukan,
    required int totalPengeluaran,
    required int saldoAkhir,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.attach_money, size: 24, color: Colors.black),
              const SizedBox(width: 12),
              Text(
                'Total Pemasukan : Rp ${totalPemasukan.toString()}',
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.money_off, size: 24, color: Colors.black),
              const SizedBox(width: 12),
              Text(
                'Total Pengeluaran : Rp ${totalPengeluaran.toString()}',
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.account_balance, size: 24, color: Colors.black),
              const SizedBox(width: 12),
              Text(
                'Saldo Akhir : Rp ${saldoAkhir.toString()}',
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }
}