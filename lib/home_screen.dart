import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_utspemob_ameng/pages/pembayaran_page.dart';
import 'package:flutter_utspemob_ameng/pages/profile_page.dart';
import 'package:flutter_utspemob_ameng/pages/scanqr_page.dart';
import 'package:flutter_utspemob_ameng/pages/setting_page.dart';
import 'package:flutter_utspemob_ameng/pages/cek_saldo_page.dart';
import 'package:flutter_utspemob_ameng/pages/deposito_page.dart';
import 'package:flutter_utspemob_ameng/pages/mutasi_page.dart';
import 'package:flutter_utspemob_ameng/pages/pinjaman_page.dart';
import 'package:flutter_utspemob_ameng/pages/transfer_page.dart';
import 'package:flutter_utspemob_ameng/models/nasabah.dart';

class HomeScreen extends StatefulWidget {
  final Nasabah nasabah;
  const HomeScreen({super.key, required this.nasabah});

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
    int totalDeposito = _nasabah.daftarDeposito.fold(
      0,
      (sum, d) => sum + d.nominal,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF6F9FF),
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        elevation: 0,
        title: const Text(
          "Koperasi Undiksha",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        actions: [IconButton(icon: const Icon(Icons.logout), onPressed: () {})],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              children: [
                // Compact Card Profile + Saldo
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue[800]!, Colors.blue[400]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundImage: AssetImage("assets/logo.png"),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Halo,",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              _nasabah.nama,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Saldo: ${currencyFormat.format(_nasabah.saldo)}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Deposito: ${currencyFormat.format(totalDeposito)}",
                              style: TextStyle(
                                color: Colors.green[100],
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Menu Grid
                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.9,
                  children: [
                    _buildMenuCard(
                      Icons.account_balance_wallet,
                      "Cek Saldo",
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => CekSaldoPage()),
                        );
                      },
                    ),
                    _buildMenuCard(Icons.send, "Transfer", () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => TransferPage()),
                      );
                      setState(() {});
                    }),
                    _buildMenuCard(Icons.savings, "Deposito", () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DepositoPage(nasabah: _nasabah),
                        ),
                      );
                      setState(() {});
                    }),
                    _buildMenuCard(Icons.payment, "Pembayaran", () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => PembayaranPage()),
                      );
                      setState(() {});
                    }),
                    _buildMenuCard(Icons.attach_money, "Pinjaman", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => PinjamanPage()),
                      );
                    }),
                    _buildMenuCard(Icons.history, "Mutasi", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => MutasiPage()),
                      );
                    }),
                  ],
                ),

                const SizedBox(height: 20),

                // Bantuan
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Colors.blue[50],
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: const [
                        Icon(Icons.phone, size: 32, color: Colors.blue),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Butuh Bantuan?",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "0811-0262-41853",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Menu
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey, width: 0.2)),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBottomMenu(Icons.settings, "Setting", SettingPage()),
                _buildBottomMenu(Icons.qr_code, "Scan QR", ScanQRPage()),
                _buildBottomMenu(Icons.person, "Profile", ProfilePage()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 32, color: Colors.blue[700]),
              const SizedBox(height: 6),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomMenu(IconData icon, String label, Widget page) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(context, MaterialPageRoute(builder: (_) => page));
        setState(() {});
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 26, color: Colors.blue),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
