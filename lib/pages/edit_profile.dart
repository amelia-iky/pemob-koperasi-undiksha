import 'package:flutter/material.dart';

class EditProfilePage extends StatelessWidget {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ubah Profil")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _namaController,
              decoration: InputDecoration(labelText: "Nama Lengkap"),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Profil berhasil diperbarui")),
                );
              },
              child: Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}
