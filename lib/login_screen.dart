import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String usernameError = '';
  String passwordError = '';

  void _login() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    const validUsername = "2315091018";
    const validPassword = "2315091018";

    setState(() {
      usernameError = '';
      passwordError = '';
    });

    if (username != validUsername) {
      setState(() {
        usernameError = "Username salah";
      });
    } else if (password != validPassword) {
      setState(() {
        passwordError = "Password salah";
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
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
          Image.asset('assets/logo.png', height: 100),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: "Username",
                    border: OutlineInputBorder(),
                    errorText: usernameError.isEmpty ? null : usernameError, // Menampilkan error jika ada
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                    errorText: passwordError.isEmpty ? null : passwordError, // Menampilkan error jika ada
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _login,
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
            child: Text("copyright @2025 by Ayukadw"),
          ),
        ],
      ),
    );
  }
}
