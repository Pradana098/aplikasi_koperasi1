import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

import 'package:path/path.dart'; // Import path package for basename
import 'package:flutter/foundation.dart'; // Import foundation for kIsWeb
import '../config/api_constants.dart';

class ApiService {
  // Register Function
  Future<bool> registerAnggota({
    required String name,
    required String no_telepon,
    required String password,
    required String konfirmasi_password,
    required String nip,
    required String tempat_lahir,
    required String tanggal_lahir,
    required String alamat_rumah,
    required String unit_kerja,
    required File sk_perjanjian_kerja,
  }) async {
    var uri = Uri.parse(ApiConstants.register);

    var request = http.MultipartRequest('Post', uri);
    request.headers.addAll({'Content-Type': 'application/json'});
    request.fields['name'] = name;
    request.fields['no_telepon'] = no_telepon;
    request.fields['password'] = password;
    request.fields['password_confirmation'] = konfirmasi_password;
    request.fields['nip'] = nip;
    request.fields['tempat_lahir'] = tempat_lahir;
    request.fields['tanggal_lahir'] = tanggal_lahir;
    request.fields['alamat_rumah'] = alamat_rumah;
    request.fields['unit_kerja'] = unit_kerja;
    if (kIsWeb) {
      // Web → gunakan bytes
      request.files.add(
        http.MultipartFile.fromBytes(
          'sk_perjanjian_kerja',
          sk_perjanjian_kerja.readAsBytesSync(),
          filename: basename(sk_perjanjian_kerja.path),
          contentType: MediaType('application', 'octet-stream'),
        ),
      );
    } else {
      // Android/iOS → gunakan path
      request.files.add(
        await http.MultipartFile.fromPath(
          'sk_perjanjian_kerja',
          sk_perjanjian_kerja.path,
          contentType: MediaType('application', 'octet-stream'),
        ),
      );
    }
    final response = await request.send();
    return response.statusCode == 201;
  }

  // Login Function
  Future<Map<String, dynamic>?> login(String nip, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.login),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"nip": nip, "password": password}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['access_token']);

        if (data['role'] != null) {
          await prefs.setString('role', data['role']);
        }

        if (data['status'] != null) {
          await prefs.setString('status', data['status']);
        }
        return data;
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Login gagal. Silakan coba lagi.',
          'statusCode': response.statusCode,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan: $e',
        'statusCode': 500,
      };
    }
  }

  Future<void> storeToken(String token, String role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('role', role);
  }

  // Fungsi untuk mengambil token yang sudah disimpan
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Logout Function
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    await http.post(
      Uri.parse(ApiConstants.logout),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    await prefs.clear();
  }

  // Fetch Dashboard Data
  Future<Map<String, dynamic>?> getDashboardData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? role = prefs.getString('role');

    if (role == null || token == null) return null;

    String endpoint;

    if (role == "pengawas") {
      endpoint = ApiConstants.dashboardPengawas;
    } else if (role == "pengurus") {
      endpoint = ApiConstants.dashboardPengurus;
    } else {
      endpoint = ApiConstants.dashboardAnggota;
    }

    final response = await http.get(
      Uri.parse(endpoint),
      headers: {"Authorization": "Bearer $token", "Accept": "application/json"},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("Gagal fetch dashboard: ${response.statusCode} - ${response.body}");
      return null;
    }
  }

  Future<int?> fetchTotalAnggota() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await http.get(
        Uri.parse(ApiConstants.jumlahAnggotaUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['total_anggota']; // hanya return datanya
      } else {
        debugPrint('Gagal mendapatkan data: ${response.body}');
        return null;
      }
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }

  }

