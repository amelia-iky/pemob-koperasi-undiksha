import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login(BuildContext context) {
    if (_usernameController.text == "2315091018" && _passwordController.text == "2315091018") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Username atau Password salah")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.blue[900],
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Text(
                "Koperasi Undiksha",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 20),
          Image.asset('assets/logo.png', height: 100), // Tambahkan gambar logo di folder assets
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: "Username", border: OutlineInputBorder()),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: "Password", border: OutlineInputBorder()),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _login(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text("Login", style: TextStyle(color: Colors.white)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(onPressed: () {}, child: Text("Daftar Mbanking")),
                    TextButton(onPressed: () {}, child: Text("Lupa password?")),
                  ],
                )
              ],
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.grey[300],
            child: Text("copyright @2022 by Undiksha"),
          ),
        ],
      ),
    );
  }
}
