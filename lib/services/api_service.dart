import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_constants.dart';

class ApiService {
  // Login Function
  Future<Map<String, dynamic>?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(ApiConstants.login),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // Simpan token & role
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['access_token']);
      await prefs.setString('role', data['role']);
      await prefs.setString(
        'status',
        data['status'],
      ); // simpan status jika perlu

      return data;
    } else if (response.statusCode == 403) {
      // Akun belum disetujui / status pending
      throw Exception(data['message'] ?? "Akun Anda belum disetujui.");
    } else if (response.statusCode == 401) {
      throw Exception("Email atau password salah.");
    } else {
      throw Exception("Terjadi kesalahan saat login. Coba lagi nanti.");
    }
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

    await prefs.clear(); // Hapus token dan role saat logout
  }

  // Fetch Dashboard Data
  Future<Map<String, dynamic>?> getDashboardData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? role = prefs.getString('role');

    if (role == null || token == null) return null;

    String endpoint;

    // Tentukan endpoint berdasarkan role
    if (role == "pengawas") {
      endpoint = ApiConstants.dashboardPengawas;
    } else if (role == "pengurus") {
      endpoint = ApiConstants.dashboardPengurus;
    } else {
      endpoint = ApiConstants.dashboardAnggota;
    }

    final response = await http.get(
      Uri.parse(endpoint),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }
}
