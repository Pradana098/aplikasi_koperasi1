import 'package:aplikasi_koperasi1/services/api_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  PlatformFile? _skPejanjianKerja;

  int _currentStep = 0;

  final _namaController = TextEditingController();
  final _noHpController = TextEditingController();
  final _passwordController = TextEditingController();
  final _konfirmasiPasswordController = TextEditingController();
  final _nipController = TextEditingController();
  final _tempatLahirController = TextEditingController();
  final _tanggalLahirController = TextEditingController();
  final _alamatController = TextEditingController();
  final _unitKerjaController = TextEditingController();

  Future<void> _pickKtpFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      setState(() {
        _skPejanjianKerja = result.files.single;
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && _skPejanjianKerja != null) {
      final apiService = ApiService();
      final success = await apiService.registerAnggota(
        name: _namaController.text,
        no_telepon: _noHpController.text,
        password: _passwordController.text,
        konfirmasi_password: _konfirmasiPasswordController.text,
        nip: _nipController.text,
        tempat_lahir: _tempatLahirController.text,
        tanggal_lahir: _tanggalLahirController.text,
        alamat_rumah: _alamatController.text,
        unit_kerja: _unitKerjaController.text,
        sk_perjanjian_kerja: File(_skPejanjianKerja!.path!),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(success ? 'Registrasi berhasil' : 'Gagal registrasi')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Anggota'),
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep == 0 && _formKey.currentState!.validate()) {
            setState(() {
              _currentStep += 1;
            });
          } else if (_currentStep == 1 && _skPejanjianKerja != null) {
            setState(() {
              _currentStep += 1;
            });
          } else if (_currentStep == 2) {
            _submitForm();
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep -= 1;
            });
          }
        },
        steps: [
          Step(
            title: const Text('Isi Data'),
            content: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _namaController,
                    decoration: const InputDecoration(labelText: 'Nama'),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Nama tidak boleh kosong' : null,
                  ),
                  TextFormField(
                    controller: _noHpController,
                    decoration: const InputDecoration(labelText: 'No HP'),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'No HP tidak boleh kosong' : null,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Password tidak boleh kosong' : null,
                  ),
                  TextFormField(
                    controller: _konfirmasiPasswordController,
                    decoration: const InputDecoration(labelText: 'Konfirmasi Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Konfirmasi password tidak boleh kosong';
                      }
                      if (value != _passwordController.text) {
                        return 'Password tidak cocok';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _nipController,
                    decoration: const InputDecoration(labelText: 'NIP'),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'NIP tidak boleh kosong' : null,
                  ),
                  TextFormField(
                    controller: _tempatLahirController,
                    decoration: const InputDecoration(labelText: 'Tempat Lahir'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Tempat lahir tidak boleh kosong'
                        : null,
                  ),
                  TextFormField(
                    controller: _tanggalLahirController,
                    decoration: const InputDecoration(labelText: 'Tanggal Lahir'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Tanggal lahir tidak boleh kosong'
                        : null,
                  ),
                  TextFormField(
                    controller: _alamatController,
                    decoration: const InputDecoration(labelText: 'Alamat'),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Alamat tidak boleh kosong' : null,
                  ),
                  TextFormField(
                    controller: _unitKerjaController,
                    decoration: const InputDecoration(labelText: 'Unit Kerja'),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Unit kerja tidak boleh kosong' : null,
                  ),
                ],
              ),
            ),
          ),
          Step(
            title: const Text('Upload SK Perjanjian Kerja'),
            content: Column(
              children: [
                ElevatedButton(
                  onPressed: _pickKtpFile,
                  child: const Text('Pilih File'),
                ),
                if (_skPejanjianKerja != null)
                  Text('File: ${_skPejanjianKerja!.name}'),
              ],
            ),
          ),
          Step(
            title: const Text('Menunggu Persetujuan'),
            content: const Text(
              'Akun Anda sedang dalam proses persetujuan oleh pengurus. '
              'Silakan tunggu konfirmasi lebih lanjut.',
            ),
          ),
        ],
      ),
    );
  }
}
