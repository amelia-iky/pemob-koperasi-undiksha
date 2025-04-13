import 'package:flutter/material.dart';
import 'package:flutter_tugasbank_ayuka/pages/pembayaran_page.dart';
import 'package:flutter_tugasbank_ayuka/pages/profile_page.dart';
import 'package:flutter_tugasbank_ayuka/pages/scanqr_page.dart';
import 'package:flutter_tugasbank_ayuka/pages/setting_page.dart';
import 'package:flutter_tugasbank_ayuka/pages/cek_saldo_page.dart';
import 'package:flutter_tugasbank_ayuka/pages/deposito_page.dart';
import 'package:flutter_tugasbank_ayuka/pages/mutasi_page.dart';
import 'package:flutter_tugasbank_ayuka/pages/pinjaman_page.dart';
import 'package:flutter_tugasbank_ayuka/pages/transfer_page.dart';
import 'package:flutter_tugasbank_ayuka/models/nasabah.dart';
import 'package:flutter_tugasbank_ayuka/models/transaksi.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  final NumberFormat currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    Nasabah nasabah = Nasabah(
      nama: "Ayu Kusuma",
      saldo: 3600000,
      histori: [
        Transaksi(deskripsi: "Transfer ke Budi", jumlah: 100000, tanggal: DateTime.now().subtract(Duration(days: 1))),
        Transaksi(deskripsi: "Deposit", jumlah: 500000, tanggal: DateTime.now().subtract(Duration(days: 2))),
      ],
      historiBayar: [
        Transaksi(deskripsi: "Bayar Listrik", jumlah: 200000, tanggal: DateTime.now().subtract(Duration(days: 3))),
        Transaksi(deskripsi: "Bayar Internet", jumlah: 150000, tanggal: DateTime.now().subtract(Duration(days: 4))),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text(
          "Koperasi Undiksha",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
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
                            const Text("Nasabah", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(nasabah.nama, overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 5),
                            const Text("Total Saldo Anda", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(currencyFormat.format(nasabah.saldo)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Menu
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildMenuItem(context, Icons.account_balance_wallet, "Cek Saldo", () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CekSaldoPage()));
                    }),
                    _buildMenuItem(context, Icons.send, "Transfer", () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TransferPage()));
                    }),
                    _buildMenuItem(context, Icons.savings, "Deposito", () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DepositoPage()));
                    }),
                    _buildMenuItem(context, Icons.payment, "Pembayaran", () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PembayaranPage()));
                    }),
                    _buildMenuItem(context, Icons.attach_money, "Pinjaman", () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PinjamanPage()));
                    }),
                    _buildMenuItem(context, Icons.history, "Mutasi", () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MutasiPage()));
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
                            Text("Butuh Bantuan?", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("0857-8497-8009", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                _buildBottomMenu(context, Icons.settings, "Setting", SettingPage()),
                _buildBottomMenu(context, Icons.qr_code, "Scan QR", ScanQRPage()),
                _buildBottomMenu(context, Icons.person, "Profile", ProfilePage()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String label, Function onTap) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.blue),
          const SizedBox(height: 5),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildBottomMenu(BuildContext context, IconData icon, String label, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
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
