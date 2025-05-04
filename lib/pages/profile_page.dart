import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = '';

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  void _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'Guest'; // GANTI key jadi 'username'
    });
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Foto(),
          Nama(),
          Web(),
          SizedBox(height: 20),
          Text(
            "Welcome, $username!",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}
}
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(), // GANTI ke ProfilePage
    );
  }
}

class Foto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 75,
      backgroundImage: AssetImage('assets/DSC05580.png'),
    );
  }
}

class Nama extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Text(
        'Ni Putu Ayu Kusuma Dewi',
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

class Web extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Text(
        'https://tinyurl.com/ayukadw1018',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}
