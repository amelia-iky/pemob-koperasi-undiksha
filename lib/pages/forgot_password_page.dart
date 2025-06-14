import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _resetPassword() {
    if (_newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password tidak cocok")),
      );
      return;
    }

    // Tambahkan logic penyimpanan password baru di sini (opsional)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Password berhasil diubah")),
    );

    Navigator.pop(context); // Kembali ke login
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reset Password")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password Baru"),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Konfirmasi Password"),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _resetPassword,
              child: Text("Simpan Password Baru"),
            ),
          ],
        ),
      ),
    );
  }
}
