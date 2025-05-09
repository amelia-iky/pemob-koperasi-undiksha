import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = '';
  TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  // Ambil username dari SharedPreferences
  void _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'Guest';
    });
  }

  // Simpan username ke SharedPreferences
  void _saveUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _usernameController.text);
    setState(() {
      username = _usernameController.text;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Username berhasil disimpan!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0F2FF),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF0D47A1),
        title: Text('Profil', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Foto(),
              Nama(),
              SizedBox(height: 20),
              Text(
                "Welcome, $username!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Masukkan Username Baru',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _saveUsername,
                child: Text('Simpan Username'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Foto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 75,
      backgroundImage: AssetImage('assets/DSC05580.jpg'),
    );
  }
}

class Nama extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Text(
        'I Gusti Ayu Isyana Ariprabha',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}
