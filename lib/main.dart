import 'package:flutter/material.dart';
import 'package:flutter_tugasbank_isyana/login_screen.dart';
import 'package:flutter_tugasbank_isyana/pages/theme_provider.dart';
import 'package:flutter_tugasbank_isyana/pages/setting_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Koperasi Undiksha",
      themeMode: themeProvider.currentTheme,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: LoginScreen(), // Ganti ke SettingPage() untuk preview
    );
  }
}
