import 'package:flutter/material.dart';

class ChangePinPage extends StatelessWidget {
  final TextEditingController _oldPin = TextEditingController();
  final TextEditingController _newPin = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ganti PIN")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _oldPin,
              decoration: InputDecoration(labelText: "PIN Lama"),
              obscureText: true,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12),
            TextField(
              controller: _newPin,
              decoration: InputDecoration(labelText: "PIN Baru"),
              obscureText: true,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("PIN berhasil diubah")));
              },
              child: Text("Simpan PIN"),
            ),
          ],
        ),
      ),
    );
  }
}
