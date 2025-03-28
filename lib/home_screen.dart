import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text("Koperasi Undiksha",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Nasabah", style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Ni Putu Ayu Kusuma Dewi"),
                          SizedBox(height: 5),
                          Text("Total Saldo Anda", style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Rp. 1.200.000"),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Menu
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  children: [
                    _buildMenuItem(Icons.account_balance_wallet, "Cek Saldo"),
                    _buildMenuItem(Icons.send, "Transfer"),
                    _buildMenuItem(Icons.savings, "Deposito"),
                    _buildMenuItem(Icons.payment, "Pembayaran"),
                    _buildMenuItem(Icons.attach_money, "Pinjaman"),
                    _buildMenuItem(Icons.history, "Mutasi"),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Butuh Bantuan?", style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("0878-1234-1024", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
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
                _buildBottomMenu(Icons.settings, "Setting"),
                _buildBottomMenu(Icons.qr_code, "Scan QR"),
                _buildBottomMenu(Icons.person, "Profile"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 40, color: Colors.blue),
        Text(label, textAlign: TextAlign.center),
      ],
    );
  }

  Widget _buildBottomMenu(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 40, color: Colors.blue),
        Text(label),
      ],
    );
  }
}
