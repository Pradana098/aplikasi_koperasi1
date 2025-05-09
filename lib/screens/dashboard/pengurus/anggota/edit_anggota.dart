import 'package:flutter/material.dart';

class EditAnggotaPage extends StatefulWidget {
  final String nama;

  const EditAnggotaPage({required this.nama, super.key});

  @override
  _EditAnggotaPageState createState() => _EditAnggotaPageState();
}

class _EditAnggotaPageState extends State<EditAnggotaPage> {
  late TextEditingController _namaController;
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _noTeleponController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.nama);
  }

  void _simpanPerubahan() {
    print('Data Diubah: ${_namaController.text}');
    Navigator.pop(context); // Kembali ke halaman sebelumnya
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header dengan background biru
          Container(
            height: 170,
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
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context); // Kembali ke halaman sebelumnya
                    },
                  ),
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Edit Data Anggota',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Form Edit Anggota
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildTextFieldWithIcon(
                        _namaController,
                        'Nama Lengkap',
                        Icons.person,
                      ),
                      _buildTextFieldWithIcon(
                        _nikController,
                        'NIK',
                        Icons.badge,
                      ),
                      _buildTextFieldWithIcon(
                        _noTeleponController,
                        'No. Telepon',
                        Icons.phone,
                      ),
                      _buildTextFieldWithIcon(
                        _emailController,
                        'Email',
                        Icons.email,
                      ),
                      _buildTextFieldWithIcon(
                        _alamatController,
                        'Alamat',
                        Icons.location_on,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: _simpanPerubahan,
                            icon: const Icon(Icons.save),
                            label: const Text('Update'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.cancel),
                            label: const Text('Batal'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
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
                // Aksi untuk tombol Home
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
                  // Aksi untuk tombol QR Code
                },
                icon: const Icon(Icons.qr_code_scanner, color: Colors.black, size: 30),
              ),
            ),
            IconButton(
              onPressed: () {
                // Aksi untuk tombol Settings
              },
              icon: const Icon(Icons.settings, color: Colors.black, size: 30),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFieldWithIcon(
    TextEditingController controller,
    String label,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: label,
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
