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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['access_token']);

      if (data['role'] != null) {
        await prefs.setString('role', data['role']);
      }

      if (data['status'] != null) {
        await prefs.setString('status', data['status']);
      }

      return data;
    } else if (response.statusCode == 403) {
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

    await prefs.clear();
  }

  // Fetch Dashboard Data
  Future<Map<String, dynamic>?> getDashboardData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? role = prefs.getString('role');

    if (token == null || role == null) return null;

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
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("Gagal fetch dashboard: ${response.statusCode} - ${response.body}");
      return null;
    }
  }
}
