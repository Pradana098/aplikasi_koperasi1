import 'package:flutter/material.dart';

class LaporanKeuanganScreen extends StatelessWidget {
  const LaporanKeuanganScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: ListView(
                  children: [
                    _buildSectionTitle("Ringkasan Keuangan"),
                    _buildFinancialCard("Total Pemasukan", "Rp. 25.000.000", Colors.green),
                    _buildFinancialCard("Total Pengeluaran", "Rp. 10.500.000", Colors.red),
                    _buildFinancialCard("Saldo Akhir", "Rp. 14.500.000", Colors.blue),
                    const SizedBox(height: 20),
                    _buildSectionTitle("Catatan Transaksi"),
                    _buildTransactionItem("Pemasukan dari Simpanan Wajib", "Rp. 5.000.000", true),
                    _buildTransactionItem("Pembayaran Pinjaman", "Rp. 2.500.000", true),
                    _buildTransactionItem("Pembelian Alat Kantor", "Rp. 1.200.000", false),
                    _buildTransactionItem("Pembayaran Listrik", "Rp. 300.000", false),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue[700],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          const SizedBox(height: 12),
          const Text(
            "Laporan Keuangan",
            style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            "Ringkasan dan catatan keuangan koperasi",
            style: TextStyle(fontSize: 14, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildFinancialCard(String title, String amount, Color color) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(Icons.attach_money, color: color),
        ),
        title: Text(title),
        subtitle: Text(amount, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildTransactionItem(String desc, String amount, bool isIncome) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      leading: Icon(
        isIncome ? Icons.arrow_downward : Icons.arrow_upward,
        color: isIncome ? Colors.green : Colors.red,
      ),
      title: Text(desc),
      trailing: Text(
        amount,
        style: TextStyle(
          color: isIncome ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
