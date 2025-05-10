import 'dart:io';

import 'package:aplikasi_koperasi1/services/api_service.dart';
import 'package:flutter/material.dart';

class RegisterPageViewScreen extends StatefulWidget {
  @override
  _RegisterPageViewScreenState createState() => _RegisterPageViewScreenState();
}

class _RegisterPageViewScreenState extends State<RegisterPageViewScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final TextEditingController namaController = TextEditingController();
  final TextEditingController nipController = TextEditingController();
  final TextEditingController tempatTanggalLahirController =
      TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController nomorHpController = TextEditingController();
  final TextEditingController unitKerjaController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController skKerjaController = TextEditingController();

  bool isSubmitted = false;
  bool isApproved = false; // Status awal adalah Pending Verification
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _currentIndex = _controller.page!.round();
      });
    });
  }

  void _nextPage() {
    if (_currentIndex < 2) {
      _controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => _currentIndex++);
    }
  }

  void _prevPage() {
    if (_currentIndex > 0) {
      _controller.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => _currentIndex--);
    }
  }

  void _submitRegister() async {
    setState(() {
      isLoading = true;
    });
    ApiService apiService = ApiService();
    try {
      final response = await apiService.register(
        namaController.text.trim(),
        nomorHpController.text.trim(),
        nipController.text.trim(),
        tempatTanggalLahirController.text.trim(),
        alamatController.text.trim(),
        unitKerjaController.text.trim(),
        passwordController.text.trim(),
        confirmPasswordController.text.trim(), // Added missing argument
        skKerjaController.text.trim() as File?, // Removed undefined named parameter
      );



      
register gagal  terus kjdpQAKD;La,mcx;, >X?




      setState(() {
        isLoading = false;
      });

      if (!mounted) return;

      if (response != null) {
        // Menangani error jika ada
        if (response.containsKey('error')) {
          _showErrorSnackbar(response['error']);
          return;
        }

        // Jika berhasil, navigasi ke halaman login
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _showErrorSnackbar("Terjadi kesalahan koneksi.");
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Koperasi'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          _buildProgressBar(),
          Expanded(
            child: PageView(
              controller: _controller,
              physics:
                  NeverScrollableScrollPhysics(), // Agar tidak bisa swipe manual
              children: [
                _buildStep1Form(),
                _buildStep2Terms(),
                _buildStep3Verification(),
              ],
            ),
          ),
        ],
      ),
    );
  }

    Widget _buildProgressBar() {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildProgressStep(
              "Registration Form",
              Icons.edit,
              _currentIndex == 0,
            ),
            _buildProgressLine(),
            _buildProgressStep(
              "Membership Terms",
              Icons.description,
              _currentIndex == 1,
            ),
            _buildProgressLine(),
            _buildProgressStep(
              "Verification",
              Icons.check_circle,
              _currentIndex == 2,
            ),
          ],
        ),
      );
    }

    Widget _buildProgressStep(String title, IconData icon, bool isActive) {
      return Column(
        children: [
          Icon(
            icon,
            color: isActive ? Colors.blueAccent : Colors.grey,
            size: 30,
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? Colors.blueAccent : Colors.grey,
            ),
          ),
        ],
      );
    }

    Widget _buildProgressLine() {
      return Expanded(child: Divider(color: Colors.grey, thickness: 2));
    }

    Widget _buildStep1Form() {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Registration Form",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildTextField("Nama Lengkap", namaController),
            SizedBox(height: 10),
            _buildTextField("NIP/NIK/NIPPPK", nipController),
            SizedBox(height: 10),
            _buildTextField(
              "Tempat, Tanggal Lahir",
              tempatTanggalLahirController,
            ),
            SizedBox(height: 10),
            _buildTextField("Alamat Rumah", alamatController),
            SizedBox(height: 10),
            _buildTextField("Nomor HP/Whatsapp", nomorHpController),
            SizedBox(height: 10),
            _buildTextField("Unit Kerja", unitKerjaController),
            SizedBox(height: 10),
            _buildTextField(
              "Buat Password",
              passwordController,
              obscureText: true,
            ),
            SizedBox(height: 10),
            _buildTextField(
              "Konfirmasi Password",
              confirmPasswordController,
              obscureText: true,
            ),
            Spacer(),
            ElevatedButton(
              onPressed: _nextPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
              child: Text('Register'),
            ),
          ],
        ),
      );
    }

    Widget _buildTextField(
      String label,
      TextEditingController controller, {
      bool obscureText = false,
    }) {
      return TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      );
    }

    Widget _buildStep2Terms() {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Terms of Membership",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "1. Menyetujui Anggaran Dasar dan Anggaran Rumah Tangga (AD/ART) dan peraturan yang berlaku di Koperasi Karyawan Politeknik Negeri Banyuwangi.\n\n"
                      "2. Melampirkan fotokopi SK Perjanjian Kerja.\n\n"
                      "3. Membayar Simpanan Pokok sebesar Rp. 50.000,- (Lima Puluh Ribu Rupiah) yang dibayarkan sekali pada saat mendaftar.\n\n"
                      "4. Membayar Simpanan Wajib setiap awal bulan sejak diterima menjadi anggota sebesar Rp. 40.000,- (Empat Puluh Ribu Rupiah) yang dibayarkan selama menjadi anggota koperasi.\n\n"
                      "5. Membayar Simpanan Sukarela (Tabungan) setiap bulan dengan nominal sesuai keinginan masing-masing anggota (tidak wajib). Simpanan Sukarela (tabungan) akan dibagikan bersama dengan bingkisan hari raya.\n",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Logika untuk upload dokumen
                      },
                      icon: Icon(Icons.upload_file, color: Colors.white),
                      label: Text("Upload Documents"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _prevPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  ),
                  child: Text('Back'),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    _showConfirmDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  ),
                  child: Text("Register"),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget _buildStep3Verification() {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul
            Text(
              "Registration Verification",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 20),

            // Status Verifikasi
            Center(
              child: GestureDetector(
                onTap: () {
                  // Ubah status menjadi Approved saat ditekan
                  setState(() {
                    isApproved = true;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isApproved ? Icons.check_circle : Icons.hourglass_empty,
                        color: isApproved ? Colors.blueAccent : Colors.orange,
                        size: 30,
                      ),
                      SizedBox(width: 10),
                      Text(
                        isApproved
                            ? "Registration Approved"
                            : "Pending Verification",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isApproved ? Colors.blueAccent : Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Registration History
            Text(
              "Registration History",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "20 April 2025",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Membership Registration",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  SizedBox(height: 5),
                  Text(
                    isApproved
                        ? "Registration Approved"
                        : "Pending Verification",
                    style: TextStyle(
                      fontSize: 14,
                      color: isApproved ? Colors.blueAccent : Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),

            // Tombol Go To Login
            if (isApproved)
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigasi ke halaman login
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  ),
                  child: Text(
                    "Go To Login",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      );
    }

    void _showConfirmDialog() {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: Text("Konfirmasi"),
              content: Text("Are you sure you want to register as a member?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _submitRegister();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: Text("Yes, Submit"),
                ),
              ],
            ),
      );
    }
  }

