import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RiwayatTransaksiScreen extends StatelessWidget {
  final List<Map<String, dynamic>> riwayatTransaksi = [
    {"tanggal": "2025-04-01", "keterangan": "Simpanan Pokok", "jumlah": 1000000},
    {"tanggal": "2025-03-15", "keterangan": "Pinjaman", "jumlah": -5000000},
    {"tanggal": "2025-03-10", "keterangan": "Angsuran", "jumlah": 500000},
  ];

  final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  Icon getIcon(String keterangan) {
    switch (keterangan.toLowerCase()) {
      case "simpanan pokok":
        return Icon(Icons.savings_rounded, color: Colors.green, size: 30);
      case "pinjaman":
        return Icon(Icons.money_off_csred_rounded, color: Colors.redAccent, size: 30);
      case "angsuran":
        return Icon(Icons.payments_rounded, color: Colors.blueAccent, size: 30);
      default:
        return Icon(Icons.receipt_long, color: Colors.grey, size: 30);
    }
  }

  String getDetailKeterangan(String keterangan) {
    switch (keterangan.toLowerCase()) {
      case "simpanan pokok":
        return "Simpanan Pokok adalah setoran awal yang wajib dibayarkan saat menjadi anggota koperasi.";
      case "pinjaman":
        return "Pinjaman adalah dana yang dipinjam oleh anggota dari koperasi dengan kesepakatan tertentu.";
      case "angsuran":
        return "Angsuran adalah pembayaran cicilan dari pinjaman yang telah diberikan koperasi.";
      default:
        return "Informasi tambahan tidak tersedia untuk jenis transaksi ini.";
    }
  }

  int getTotalSaldo() {
     return riwayatTransaksi.fold(0, (total, trx) => total + (trx["jumlah"] as int));;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Color(0xFFF2F4F8),
      appBar: AppBar(
        title: const Text("Riwayat Transaksi"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Header Ringkasan Saldo
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Total Aktivitas", style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 6),
                Text(
                  currencyFormatter.format(getTotalSaldo()),
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Daftar Transaksi
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: riwayatTransaksi.length,
              itemBuilder: (context, index) {
                final transaksi = riwayatTransaksi[index];
                final jumlah = transaksi['jumlah'] as int;
                final warna = jumlah < 0 ? Colors.red : Colors.green;

                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 3,
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    onTap: () => _showDetailDialog(context, transaksi),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade50,
                      radius: 28,
                      child: getIcon(transaksi['keterangan']),
                    ),
                    title: Text(
                      transaksi['keterangan'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      DateFormat('EEEE, d MMM yyyy', 'id_ID')
                          .format(DateTime.parse(transaksi["tanggal"])),
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    trailing: Text(
                      currencyFormatter.format(jumlah),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: warna,
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void _showDetailDialog(BuildContext context, Map<String, dynamic> transaksi) {
    final jumlah = transaksi['jumlah'] as int;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              getIcon(transaksi["keterangan"]),
              const SizedBox(width: 12),
              Text(transaksi["keterangan"]),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "📅 Tanggal: ${DateFormat('EEEE, d MMM yyyy', 'id_ID').format(DateTime.parse(transaksi["tanggal"]))}",
              ),
              const SizedBox(height: 8),
              Text(
                "💰 Jumlah: ${currencyFormatter.format(jumlah)}",
                style: TextStyle(
                  color: jumlah < 0 ? Colors.red : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(getDetailKeterangan(transaksi["keterangan"])),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Tutup"),
              style: TextButton.styleFrom(foregroundColor: Colors.blueAccent),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
