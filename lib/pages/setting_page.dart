import 'package:flutter/material.dart';
import 'package:flutter_utspemob_ameng/pages/change_pin_page.dart';
import 'package:flutter_utspemob_ameng/login_screen.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pengaturan")),
      body: ListView(
        children: [
          SizedBox(height: 12),
          Center(
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.settings, size: 40, color: Colors.white),
            ),
          ),
          SizedBox(height: 8),
          Center(child: Text("Pengaturan Aplikasi", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
          SizedBox(height: 20),

          ListTile(
            leading: Icon(Icons.help_outline),
            title: Text("Bantuan"),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text("Pusat Bantuan"),
                  content: Text("Untuk bantuan lebih lanjut, hubungi customer service."),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Tutup"),
                    ),
                  ],
                ),
              );
            },
          ),
          Divider(),

          ListTile(
            leading: Icon(Icons.lock),
            title: Text("Ganti PIN"),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ChangePinPage()),
              );
            },
          ),
          Divider(),

          // Fitur pengganti dark mode: Tentang Aplikasi
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text("Tentang Aplikasi"),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "UTS Pemob App",
                applicationVersion: "v1.0.0",
                applicationIcon: Icon(Icons.settings),
                children: [
                  Text("Aplikasi ini dibuat untuk memenuhi tugas UTS Pemrograman Mobile."),
                ],
              );
            },
          ),
          Divider(),

          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text("Logout", style: TextStyle(color: Colors.red)),
            trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.red),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text("Keluar Aplikasi"),
                  content: Text("Yakin ingin logout?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Batal"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => LoginScreen()),
                          (route) => false,
                        );
                      },
                      child: Text("Logout"),
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
