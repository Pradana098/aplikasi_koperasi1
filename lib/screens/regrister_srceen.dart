import 'package:flutter/material.dart';

class RegisterPageViewScreen extends StatefulWidget {
  @override
  _RegisterPageViewScreenState createState() => _RegisterPageViewScreenState();
}

class _RegisterPageViewScreenState extends State<RegisterPageViewScreen> {
  PageController _controller = PageController();
  int _currentIndex = 0;

  final namaController = TextEditingController();
  final passwordController = TextEditingController();

  bool isSubmitted = false;
  bool isApproved = false; // ganti true kalau sudah disetujui pengurus

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
      // Di sini kamu bisa kirim ke API Laravel
    });
    _nextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register Koperasi')),
      body: PageView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(), // agar tidak swipe manual
        children: [
          _buildStep1Form(),
          _buildStep2Terms(),
          _buildStep3Verification(),
        ],
      ),
    );
  }

  Widget _buildStep1Form() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text("Registration Form", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          TextField(decoration: InputDecoration(labelText: 'Nama Lengkap'), controller: namaController),
          TextField(decoration: InputDecoration(labelText: 'Password'), controller: passwordController, obscureText: true),
          Spacer(),
          ElevatedButton(
            onPressed: _nextPage,
            child: Text('Next'),
          )
        ],
      ),
    );
  }

  Widget _buildStep2Terms() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text("Terms of Membership", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                "✅ Menyetujui AD/ART\n"
                "✅ Fotokopi SK Kerja\n"
                "✅ Simpanan Pokok Rp 50.000\n"
                "✅ Simpanan Wajib Rp 40.000/bulan\n"
                "✅ Simpanan Sukarela sesuai keinginan\n",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Row(
            children: [
              ElevatedButton(onPressed: _prevPage, child: Text('Back')),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  _showConfirmDialog();
                },
                child: Text("Register"),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStep3Verification() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text("Registration Verification", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          if (!isSubmitted)
            Text("Belum mendaftar.")
          else if (!isApproved)
            Column(
              children: [
                Icon(Icons.hourglass_empty, color: Colors.orange, size: 60),
                Text("Pending Verification", style: TextStyle(fontSize: 18)),
              ],
            )
          else
            Column(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 60),
                Text("Registration Approved", style: TextStyle(fontSize: 18)),
                ElevatedButton(onPressed: () {
                  // redirect login
                }, child: Text("Go to Login"))
              ],
            )
        ],
      ),
    );
  }

  void _showConfirmDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Konfirmasi"),
        content: Text("Are you sure you want to register as a member?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          ElevatedButton(onPressed: () {
            Navigator.pop(context);
            _submitRegister();
          }, child: Text("Yes, Submit"))
        ],
      ),
    );
  }
}
