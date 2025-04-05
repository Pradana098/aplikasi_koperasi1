import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void _login() async {
    setState(() => isLoading = true);
    ApiService apiService = ApiService();

    try {
      final response = await apiService.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      setState(() => isLoading = false);

      if (!mounted) return;

      if (response != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      } else {
        _showErrorSnackbar("Login gagal! Periksa kembali email dan password.");
      }
    } catch (e) {
      setState(() => isLoading = false);
      _showErrorSnackbar("Terjadi kesalahan: ${e.toString()}");
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
      backgroundColor: Colors.grey.shade100, // Latar belakang abu-abu soft
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _logo(),
              const SizedBox(height: 20),
              _loginCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _logo() {
    return Column(
      children: [
        Image.asset(
          'assets/img/logo.png',
          width: 120,
        ),
        const SizedBox(height: 10),
        const Text(
          "Koperasi Simpan Pinjam",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget _loginCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blueAccent, width: 5),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Login ",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          _inputField(Icons.email, "Email", emailController, false),
          const SizedBox(height: 16),
          _inputField(Icons.lock, "Password", passwordController, true),
          const SizedBox(height: 24),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text("Login", style: TextStyle(fontSize: 18)),
                ),
        ],
      ),
    );
  }

  Widget _inputField(IconData icon, String hint, TextEditingController controller, bool obscure) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
