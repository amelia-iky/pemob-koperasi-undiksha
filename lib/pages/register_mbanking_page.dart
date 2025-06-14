import 'package:flutter/material.dart';

class RegisterMbankingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text("Daftar M-Banking"),
        leading: BackButton(color: Colors.white),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Isi form berikut untuk mendaftar M-Banking",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            _buildTextField("Nama Lengkap"),
            _buildTextField("Email"),
            _buildTextField("Nomor Telepon"),
            _buildTextField("Username"),
            _buildTextField("Password", obscure: true),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: logic pendaftaran
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                ),
                child: Text("Daftar"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
