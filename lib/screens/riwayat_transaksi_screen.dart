import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RiwayatTransaksiScreen extends StatelessWidget {
  final List<Map<String, dynamic>> riwayatTransaksi = [
    {"tanggal": "2025-04-01", "keterangan": "Simpanan Pokok", "jumlah": 1000000},
    {"tanggal": "2025-03-15", "keterangan": "Pinjaman", "jumlah": -5000000},
    {"tanggal": "2025-03-10", "keterangan": "Angsuran", "jumlah": 500000},
  ];

  final currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  Icon getIcon(String keterangan) {
    switch (keterangan.toLowerCase()) {
      case "simpanan pokok":
        return Icon(Icons.savings, color: Colors.green);
      case "pinjaman":
        return Icon(Icons.money_off, color: Colors.redAccent);
      case "angsuran":
        return Icon(Icons.payment, color: Colors.blue);
      default:
        return Icon(Icons.receipt_long, color: Colors.grey);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Riwayat Transaksi"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: riwayatTransaksi.length,
          itemBuilder: (context, index) {
            var transaksi = riwayatTransaksi[index];
            var jumlah = transaksi['jumlah'] as int;

            return Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.teal.shade50,
                  child: getIcon(transaksi["keterangan"]),
                ),
                title: Text(
                  transaksi["keterangan"],
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  DateFormat('EEEE, d MMM yyyy', 'id_ID')
                      .format(DateTime.parse(transaksi["tanggal"])),
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                trailing: Text(
                  currencyFormatter.format(jumlah),
                  style: TextStyle(
                    color: jumlah < 0 ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(transaksi["keterangan"]),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tanggal: ${DateFormat('EEEE, d MMM yyyy', 'id_ID').format(DateTime.parse(transaksi["tanggal"]))}",
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Jumlah: ${currencyFormatter.format(transaksi["jumlah"])}",
                              style: TextStyle(
                                color: jumlah < 0 ? Colors.red : Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(getDetailKeterangan(transaksi["keterangan"])),
                          ],
                        ),
                        actions: [
                          TextButton(
                            child: Text("Tutup"),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
