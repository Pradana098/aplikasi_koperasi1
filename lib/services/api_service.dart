import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_constants.dart';

class ApiService {
  // Login Function
  Future<Map<String, dynamic>?> login(String noTelepon, String password) async {
  try {
    final response = await http.post(
      Uri.parse(ApiConstants.login),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "no_telepon": noTelepon,
        "password": password,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      
      // Simpan token jika ada dan bertipe String
      final token = data['access_token'];
      if (token is String) {
        await prefs.setString('token', token);
      }

      // Simpan role jika ada dan bertipe String
      final role = data['role'];
      if (role is String) {
        await prefs.setString('role', role);
      }

      // Simpan status jika ada dan bertipe String
      final status = data['status'];
      if (status is String) {
        await prefs.setString('status', status);
      }

      return data;
    } else {
      return {
        'error': data['message'] ?? 'Login gagal.',
        'statusCode': response.statusCode,
      };
    }
  } catch (e) {
    return {
      'error': 'Terjadi kesalahan koneksi.',
      'statusCode': 500,
    };
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
