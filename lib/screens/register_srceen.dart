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

  bool isSubmitted = false;
  bool isApproved = false;

  @override
  void initState() {
    super.initState();
    _checkApprovalStatus();
  }

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

  void _submitRegister() {
    setState(() {
      isSubmitted = true;
      isApproved = false;
    });
    _nextPage();
  }

  void _checkApprovalStatus() {
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        isApproved = true;
      });
    });
  }

  void _showConfirmDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Konfirmasi"),
        content: Text("Are you sure you want to register as a member?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _submitRegister();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
            child: Text("Yes, Submit"),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildProgressStep(String title, IconData icon, bool isActive) {
    return Column(
      children: [
        Icon(icon, color: isActive ? Colors.blueAccent : Colors.grey, size: 30),
        SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(fontSize: 12, color: isActive ? Colors.blueAccent : Colors.grey),
        ),
      ],
    );
  }

  Widget _buildProgressLine() {
    return Expanded(
      child: Divider(color: Colors.grey, thickness: 2),
    );
  }

  Widget _buildProgressBar() {
    return Padding(
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
  }

  Widget _buildStep1Form() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          Text("Registration Form", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          _buildTextField("Nama Lengkap", namaController),
          SizedBox(height: 10),
          _buildTextField("NIP/NIK/NIPPPK", nipController),
          SizedBox(height: 10),
          _buildTextField("Tempat, Tanggal Lahir", tempatTanggalLahirController),
          SizedBox(height: 10),
          _buildTextField("Alamat Rumah", alamatController),
          SizedBox(height: 10),
          _buildTextField("Nomor HP/Whatsapp", nomorHpController),
          SizedBox(height: 10),
          _buildTextField("Unit Kerja", unitKerjaController),
          SizedBox(height: 10),
          _buildTextField("Buat Password", passwordController, obscureText: true),
          SizedBox(height: 10),
          _buildTextField("Konfirmasi Password", confirmPasswordController, obscureText: true),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _nextPage,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
            child: Text('Register'),
          ),
        ],
      ),
    );
  }

  Widget _buildStep2Terms() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Terms of Membership", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "1. Menyetujui AD/ART dan peraturan koperasi.\n\n"
                    "2. Melampirkan fotokopi SK Perjanjian Kerja.\n\n"
                    "3. Membayar Simpanan Pokok Rp 50.000,- saat mendaftar.\n\n"
                    "4. Membayar Simpanan Wajib Rp 40.000,- tiap awal bulan.\n\n"
                    "5. Simpanan Sukarela bersifat opsional.\n",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Logika upload dokumen
                    },
                    icon: Icon(Icons.upload_file),
                    label: Text("Upload Documents"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              ElevatedButton(
                onPressed: _prevPage,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                child: Text('Back'),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: _showConfirmDialog,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                child: Text("Register"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStep3Verification() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Registration Verification", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
          SizedBox(height: 20),
          Center(
            child: GestureDetector(
              onTap: () => setState(() => isApproved = true),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isApproved ? Icons.check_circle : Icons.hourglass_empty,
                      color: isApproved ? Colors.blueAccent : Colors.orange,
                      size: 30,
                    ),
                    SizedBox(width: 10),
                    Text(
                      isApproved ? "Registration Approved" : "Pending Verification",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isApproved ? Colors.blueAccent : Colors.orange),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text("Registration History", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("20 April 2025", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text("Membership Registration", style: TextStyle(fontSize: 14)),
                SizedBox(height: 5),
                Text(
                  isApproved ? "Registration Approved" : "Pending Verification",
                  style: TextStyle(fontSize: 14, color: isApproved ? Colors.blueAccent : Colors.orange),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          if (isApproved)
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                child: Text("Go To Login"),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Koperasi'),
        backgroundColor: Colors.blueAccent,
      ),
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
}
