import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aplikasi_koperasi1/screens/dashboard/anggota/dashboard_anggota.dart';
import 'package:aplikasi_koperasi1/screens/dashboard/pengawas/dashboard_pengawas.dart';
import 'package:aplikasi_koperasi1/screens/dashboard/pengurus/dashboard_pengurus.dart';
import '../services/api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController nipController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void _login() async {
    setState(() => isLoading = true);
    ApiService apiService = ApiService();

    try {
      final response = await apiService.login(
        nipController.text.trim(),
        passwordController.text.trim(),
      );

      setState(() => isLoading = false);

      if (!mounted) return;

      if (response != null) {
        // Menangani error jika ada
        if (response.containsKey('message')) {
          _showErrorSnackbar(response['message']);
          return;
        }

       
        final role = response['user']['role']; 
        final token = response['access_token'];

        if (token != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          await prefs.setString('role', role);
        }
        if (role == 'pengawas') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PengawasDashboardScreen(data: response['user']),
            ),
          );
        } else if (role == 'pengurus') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PengurusDashboardScreen(data: response['user']),
            ),
          );
        } else if (role == 'anggota') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AnggotaDashboardScreen(data: response['user']),
            ),
          );
        } else {
          _showErrorSnackbar("Role tidak dikenali.");
        }
      } else {
        _showErrorSnackbar("Login gagal. Silakan coba lagi.");
      }
    } catch (e) {
      setState(() => isLoading = false);
      _showErrorSnackbar("Terjadi kesalahan. Silakan coba lagi.");
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
                      Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
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
                                onPressed: () {
                                  _login();
                                },
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
