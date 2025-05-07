import 'package:flutter/material.dart';

class TambahAnggotaPage extends StatefulWidget {
  @override
  _TambahAnggotaPageState createState() => _TambahAnggotaPageState();
}

class _TambahAnggotaPageState extends State<TambahAnggotaPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _noTeleponController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();

  void _simpanData() {
    print('Anggota Ditambahkan: ${_namaController.text}');
    Navigator.pop(context); // kembali ke halaman sebelumnya
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
                      Navigator.pop(context); // kembali ke halaman sebelumnya
                    },
                  ),
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Tambah Anggota Baru',
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

          // Form Tambah Anggota
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
                            onPressed: _simpanData,
                            icon: const Icon(Icons.save),
                            label: const Text('Simpan'),
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
