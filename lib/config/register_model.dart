import 'dart:io';

class RegisterModel {
  String nama;
  String noTelepon;
  String password;
  String confirmPassword;
  String nip;
  String tempatLahir;
  String tanggalLahir;
  String alamatRumah;
  String unitKerja;
  File? skFile;

  RegisterModel({
    required this.nama,
    required this.noTelepon,
    required this.password,
    required this.confirmPassword,
    required this.nip,
    required this.tempatLahir,
    required this.tanggalLahir,
    required this.alamatRumah,
    required this.unitKerja,
    this.skFile,
  });
}
