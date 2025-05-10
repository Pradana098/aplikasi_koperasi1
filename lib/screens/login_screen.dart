import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aplikasi_koperasi1/screens/dashboard/anggota/dashboard_anggota.dart';
import 'package:aplikasi_koperasi1/screens/dashboard/pengawas/dashboard_pengawas.dart';
import 'package:aplikasi_koperasi1/screens/dashboard/pengurus/dashboard_pengurus.dart';
import '../services/api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController nipController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void _login() async {
    setState(() => isLoading = true);

    // Validasi form
    final nip = nipController.text.trim();
    final password = passwordController.text.trim();

    ApiService apiService = ApiService();
    final response = await apiService.login(nip, password);

    setState(() => isLoading = false);

    if (!mounted) return;

    if (response == null) {
      _showErrorSnackbar('Gagal terhubung ke server.');
      return;
    }

    if (response.containsKey('message') && response['access_token'] == null) {
      _showErrorSnackbar(response['message']);
      return;
    }

    if (!response.containsKey('user') || !response.containsKey('access_token')) {
      _showErrorSnackbar('Login gagal. Data tidak lengkap.');
      return;
    }

    final user = response['user'];
    final token = response['access_token'];
    final role = user['role'];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('role', role);

    if (role == 'pengawas') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PengawasDashboardScreen(data: user),
        ),
      );
    } else if (role == 'pengurus') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PengurusDashboardScreen(data: user),
        ),
      );
    } else if (role == 'anggota') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AnggotaDashboardScreen(data: user),
        ),
      );
    } else {
      _showErrorSnackbar('Role tidak dikenali.');
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4285F4),
      body: SafeArea(
        top: false,
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/img/Group 146.png',
                          width: 131,
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Center(
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Center(
                        child: Text(
                          "To continue your account",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                      const SizedBox(height: 40),
                      TextField(
                        controller: nipController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "NIP/NIK/NIPPPK",
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: "Password",
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text("Forgot Password?"),
                        ),
                      ),
                      const SizedBox(height: 20),
                      isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: _login,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF4285F4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/register');
                            },
                            child: const Text("Register"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
  }
}
