import 'package:flutter/material.dart';
import 'package:flutter_tugasbank_isyana/pages/pembayaran_page.dart';
import 'package:flutter_tugasbank_isyana/pages/profile_page.dart';
import 'package:flutter_tugasbank_isyana/pages/scanqr_page.dart';
import 'package:flutter_tugasbank_isyana/pages/setting_page.dart';
import 'package:flutter_tugasbank_isyana/pages/cek_saldo_page.dart';
import 'package:flutter_tugasbank_isyana/pages/deposito_page.dart';
import 'package:flutter_tugasbank_isyana/pages/mutasi_page.dart';
import 'package:flutter_tugasbank_isyana/pages/pinjaman_page.dart';
import 'package:flutter_tugasbank_isyana/pages/transfer_page.dart';
import 'package:flutter_tugasbank_isyana/models/nasabah.dart';
import 'package:flutter_tugasbank_isyana/models/transaksi.dart';
import '../data/nasabah_data.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  final Nasabah nasabah;

  const HomeScreen({Key? key, required this.nasabah}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Nasabah _nasabah;
  final NumberFormat currencyFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  @override
  void initState() {
    super.initState();
    _nasabah = widget.nasabah;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text(
          "Koperasi Undiksha",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.logout))],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                // Informasi Nasabah
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage("assets/profile.png"),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Nasabah",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              _nasabah.nama,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              "Total Saldo Anda",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(currencyFormat.format(_nasabah.saldo)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Menu Utama
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildMenuItem(
                      context,
                      Icons.account_balance_wallet,
                      "Cek Saldo",
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CekSaldoPage(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(context, Icons.send, "Transfer", () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TransferPage()),
                      );
                      setState(() {}); // Refresh setelah transfer
                    }),
                    _buildMenuItem(context, Icons.savings, "Deposito", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => DepositoPage(nasabah: nasabahDummy),
                        ),
                      );
                    }),
                    _buildMenuItem(context, Icons.payment, "Pembayaran", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PembayaranPage(),
                        ),
                      );
                    }),
                    _buildMenuItem(context, Icons.attach_money, "Pinjaman", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PinjamanPage()),
                      );
                    }),
                    _buildMenuItem(context, Icons.history, "Mutasi", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MutasiPage()),
                      );
                    }),
                  ],
                ),

                // Bantuan
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.phone, color: Colors.blue, size: 40),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Butuh Bantuan?",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "0815-4769-3347",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Menu Bawah
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildBottomMenu(
                  context,
                  Icons.settings,
                  "Setting",
                  SettingPage(),
                ),
                _buildBottomMenu(
                  context,
                  Icons.qr_code,
                  "Scan QR",
                  ScanQRPage(),
                ),
                _buildBottomMenu(
                  context,
                  Icons.person,
                  "Profile",
                  ProfilePage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String label,
    Function onTap,
  ) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.blue),
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomMenu(
    BuildContext context,
    IconData icon,
    String label,
    Widget page,
  ) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
        setState(() {}); // Refresh saldo jika ada perubahan dari halaman lain
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: Colors.blue),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
