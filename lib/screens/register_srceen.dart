import 'dart:io';

import 'package:aplikasi_koperasi1/services/api_service.dart';
import 'package:file_picker/file_picker.dart';
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
  final TextEditingController tempatTanggalLahirController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController nomorHpController = TextEditingController();
  final TextEditingController unitKerjaController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  File? skKerjaFile;
  bool isApproved = false;
  bool isLoading = false;

  void _nextPage() {
    if (_currentIndex < 2) {
      _controller.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      setState(() => _currentIndex++);
    }
  }

  void _prevPage() {
    if (_currentIndex > 0) {
      _controller.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      setState(() => _currentIndex--);
    }
  }

  Future<void> _pickSKFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'jpg', 'png']);
    if (result != null) {
      setState(() {
        skKerjaFile = File(result.files.single.path!);
      });
    }
  }

  void _submitRegister() async {
    if (passwordController.text != confirmPasswordController.text) {
      _showErrorSnackbar("Password dan konfirmasi tidak cocok.");
      return;
    }

    setState(() => isLoading = true);

    final tempatTanggal = tempatTanggalLahirController.text.split(',');
    final tempat = tempatTanggal[0].trim();
    final tanggal = tempatTanggal.length > 1 ? tempatTanggal[1].trim() : '';

    try {
      final response = await ApiService().register(
        namaController.text.trim(),
        nomorHpController.text.trim(),
        nipController.text.trim(),
        tempat,
        tanggal,
        alamatController.text.trim(),
        unitKerjaController.text.trim(),
        passwordController.text.trim(),
        skKerjaFile,
      );

      setState(() => isLoading = false);

      if (!mounted) return;

      if (response != null) {
        if (response.containsKey('error')) {
          _showErrorSnackbar(response['error']);
        } else {
          _controller.jumpToPage(2);
        }
      } else {
        _showErrorSnackbar("Server tidak merespons.");
      }
    } catch (e) {
      setState(() => isLoading = false);
      debugPrint('Register error: $e');
      _showErrorSnackbar("Terjadi kesalahan koneksi atau format data tidak sesuai.");
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
      appBar: AppBar(title: Text('Register Koperasi'), backgroundColor: Colors.blueAccent),
      body: Column(
        children: [
          _buildProgressBar(),
          Expanded(
            child: PageView(
              controller: _controller,
              physics: NeverScrollableScrollPhysics(),
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

  Widget _buildProgressBar() => Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildProgressStep("Registration Form", Icons.edit, _currentIndex == 0),
        _buildProgressLine(),
        _buildProgressStep("Membership Terms", Icons.description, _currentIndex == 1),
        _buildProgressLine(),
        _buildProgressStep("Verification", Icons.check_circle, _currentIndex == 2),
      ],
    ),
  );

  Widget _buildProgressStep(String title, IconData icon, bool isActive) => Column(
    children: [
      Icon(icon, color: isActive ? Colors.blueAccent : Colors.grey, size: 30),
      SizedBox(height: 4),
      Text(title, style: TextStyle(fontSize: 12, color: isActive ? Colors.blueAccent : Colors.grey)),
    ],
  );

  Widget _buildProgressLine() => Expanded(child: Divider(color: Colors.grey, thickness: 2));

  Widget _buildStep1Form() => Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Registration Form", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 20),
        _buildTextField("Nama Lengkap", namaController),
        _buildTextField("NIP/NIK/NIPPPK", nipController),
        _buildTextField("Tempat, Tanggal Lahir", tempatTanggalLahirController),
        _buildTextField("Alamat Rumah", alamatController),
        _buildTextField("Nomor HP/Whatsapp", nomorHpController),
        _buildTextField("Unit Kerja", unitKerjaController),
        _buildTextField("Buat Password", passwordController, obscureText: true),
        _buildTextField("Konfirmasi Password", confirmPasswordController, obscureText: true),
        Spacer(),
        ElevatedButton(
          onPressed: _nextPage,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
          child: Text('Lanjut'),
        ),
      ],
    ),
  );

  Widget _buildTextField(String label, TextEditingController controller, {bool obscureText = false}) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
    ),
  );

  Widget _buildStep2Terms() => Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Terms of Membership", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
        SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            child: Text(
              "1. Menyetujui AD/ART Koperasi.\n2. Melampirkan SK Kerja.\n3. Membayar simpanan sesuai ketentuan.",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        ElevatedButton.icon(
          onPressed: _pickSKFile,
          icon: Icon(Icons.upload_file, color: Colors.white),
          label: Text(skKerjaFile != null ? "File Selected" : "Upload Documents"),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
        ),
        Row(
          children: [
            ElevatedButton(onPressed: _prevPage, child: Text('Back')),
            Spacer(),
            ElevatedButton(onPressed: _showConfirmDialog, child: Text("Register")),
          ],
        ),
      ],
    ),
  );

  Widget _buildStep3Verification() => Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Registration Verification", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
        SizedBox(height: 20),
        Center(
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.hourglass_empty, color: Colors.orange, size: 30),
                SizedBox(width: 10),
                Text("Pending Verification", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange)),
              ],
            ),
          ),
        ),
        Spacer(),
        Center(
          child: ElevatedButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
            child: Text("Go To Login", style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    ),
  );

  void _showConfirmDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Konfirmasi"),
        content: Text("Apakah data yang dimasukkan sudah benar?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Batal")),
          ElevatedButton(onPressed: () { Navigator.pop(context); _submitRegister(); }, child: Text("Ya, Daftar")),
        ],
      ),
    );
  }
}
