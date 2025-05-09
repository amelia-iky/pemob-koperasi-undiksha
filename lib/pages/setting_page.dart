import 'package:flutter/material.dart';
import 'package:flutter_tugasbank_isyana/pages/edit_profile.dart';
import 'package:flutter_tugasbank_isyana/pages/change_pin_page.dart';
import 'package:flutter_tugasbank_isyana/login_screen.dart';
import 'package:flutter_tugasbank_isyana/pages/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Pengaturan")),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Ubah Profil"),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => EditProfilePage()),
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
          SwitchListTile(
            secondary: Icon(Icons.dark_mode),
            title: Text("Tema Gelap"),
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme(value);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text("Logout", style: TextStyle(color: Colors.red)),
            onTap: () {
              showDialog(
                context: context,
                builder:
                    (_) => AlertDialog(
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
        ],
      ),
    );
  }
}
