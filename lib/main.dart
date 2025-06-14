import 'package:flutter/material.dart';
import 'package:flutter_utspemob_ameng/login_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    // Only initialize if no Firebase app exists
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: 'AIzaSyDOSMHSfZJKn64U_SbeIJ_zt3hvw-Qi_yk',
          authDomain: 'fir-pemob-c2658.firebaseapp.com',
          projectId: 'fir-pemob-c2658',
          storageBucket: 'YOUR_PROJECT_ID.appspot.com',
          messagingSenderId: '250831992965',
          appId: '1:250831992965:android:9348e06d2d7c8512dad1ec',
        ),
      );
    }

    // Initialize date formatting for Indonesian locale
    await initializeDateFormatting('id_ID', null);
  } catch (e) {
    // Optionally handle initialization errors here
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Koperasi Undiksha",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      home: LoginScreen(), // Bisa diganti dengan SettingPage() untuk preview
    );
  }
}
