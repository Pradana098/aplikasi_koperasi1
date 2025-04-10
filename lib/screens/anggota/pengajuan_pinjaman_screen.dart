import 'package:flutter/material.dart';

class PengajuanPinjamanScreen extends StatefulWidget {
  @override
  _PengajuanPinjamanScreenState createState() => _PengajuanPinjamanScreenState();
}

class _PengajuanPinjamanScreenState extends State<PengajuanPinjamanScreen> {
  final TextEditingController jumlahController = TextEditingController();
  String? _selectedLama;
  final List<String> lamaOptions = ['12 Bulan'];

  @override
  void initState() {
    super.initState();
    _selectedLama = '12 Bulan';
  }

  double _hitungCicilan(String jumlahStr, String lamaStr) {
    double jumlah = double.tryParse(jumlahStr) ?? 0;
    int bulan = int.tryParse(lamaStr.split(" ")[0]) ?? 1;
    double bunga = 0.1; // bunga 10%
    double totalBayar = jumlah + (jumlah * bunga);
    return totalBayar / bulan;
  }

  void _ajukanPinjaman() {
    String jumlah = jumlahController.text;
    if (jumlah.isNotEmpty && _selectedLama != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Pinjaman Rp $jumlah berhasil diajukan untuk $_selectedLama!"))
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Harap isi jumlah pinjaman dan lama pinjaman."))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Color(0xFFF2F4F8),
      appBar: AppBar(
        title: Text("Pengajuan Pinjaman"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.account_balance_wallet_rounded, size: 64, color: Colors.white),
                  SizedBox(height: 12),
                  Text(
                    "Ajukan Pinjaman Baru",
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Isi form berikut untuk mengajukan pinjaman.",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
                  ],
                ),
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.orange),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Pinjaman tersedia mulai dari Rp 100.000 hingga Rp 10.000.000.",
                        style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
                  child: Column(
                    children: [
                      TextField(
                        controller: jumlahController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Jumlah Pinjaman",
                          prefixIcon: Icon(Icons.money),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                      ),
                      SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        value: _selectedLama,
                        decoration: InputDecoration(
                          labelText: "Lama Pinjaman",
                          prefixIcon: Icon(Icons.calendar_today_rounded),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                        items: lamaOptions.map((lama) {
                          return DropdownMenuItem(value: lama, child: Text(lama));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedLama = value;
                          });
                        },
                      ),
                      if (_selectedLama != null && jumlahController.text.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: Column(
                            children: [
                              Divider(),
                              Text(
                                "Simulasi Cicilan",
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Perkiraan cicilan per bulan:",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              SizedBox(height: 6),
                              Text(
                                "Rp ${_hitungCicilan(jumlahController.text, _selectedLama!).toStringAsFixed(0)} / bulan",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.send_rounded),
                          label: Text("Ajukan Sekarang"),
                          onPressed: _ajukanPinjaman,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
