import 'package:flutter/material.dart';

class TambahSimpananPage extends StatefulWidget {
  const TambahSimpananPage({super.key});

  @override
  State<TambahSimpananPage> createState() => _TambahSimpananPageState();
}

class _TambahSimpananPageState extends State<TambahSimpananPage> {
  final TextEditingController _nominalController = TextEditingController();
  final TextEditingController _catatanController = TextEditingController();
  String? _selectedRekening;

  final List<String> _rekeningOptions = ['BRI', 'BCA', 'BSI'];

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
                  'Tambah Simpanan',
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
            _buildInputField(
              icon: Icons.attach_money,
              label: 'Nominal',
              child: TextField(
                controller: _nominalController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Rp 0',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildInputField(
              icon: Icons.account_balance,
              label: 'Sumber Dana',
              child: DropdownButton<String>(
                value: _selectedRekening,
                hint: const Text('Pilih Rekening'),
                isExpanded: true,
                underline: const SizedBox(),
                items: _rekeningOptions.map((rekening) {
                  return DropdownMenuItem(
                    value: rekening,
                    child: Text(rekening),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedRekening = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            _buildInputField(
              icon: Icons.edit,
              label: 'Catatan',
              child: TextField(
                controller: _catatanController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Tambahkan catatan',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Kembali tanpa menyimpan
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('Batal'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Simpan data dan navigasi ke halaman sukses
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SimpananBerhasilPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('Kirim'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required IconData icon,
    required String label,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blueAccent, size: 30),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                child,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SimpananBerhasilPage extends StatelessWidget {
  const SimpananBerhasilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.blue, size: 100),
            const SizedBox(height: 16),
            const Text(
              'Simpanan Berhasil',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Terima kasih',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Kembali ke halaman sebelumnya
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
              ),
              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}