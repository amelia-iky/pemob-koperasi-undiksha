import 'package:flutter/material.dart';
import '../data/nasabah_data.dart';
import '../models/transaksi.dart';

class TransferPage extends StatefulWidget {
  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  final TextEditingController _rekeningController = TextEditingController();
  final TextEditingController _nominalController = TextEditingController();

  void _showDialog(String title, String message, {bool success = true}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                success ? Icons.check_circle : Icons.warning,
                color: success ? Colors.green : Colors.red,
              ),
              SizedBox(width: 8),
              Text(title),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              child: Text("Tutup"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  void _transfer() {
    final String rekening = _rekeningController.text.trim();
    final double? jumlah = double.tryParse(_nominalController.text);

    if (rekening.isEmpty || rekening.length < 10) {
      _showDialog(
        "Gagal",
        "Nomor rekening tidak valid (minimal 10 digit).",
        success: false,
      );
      return;
    }

    if (jumlah == null || jumlah <= 0) {
      _showDialog("Gagal", "Nominal transfer tidak valid.", success: false);
      return;
    }

    if (jumlah > nasabahDummy.saldo) {
      _showDialog("Gagal", "Saldo tidak mencukupi.", success: false);
      return;
    }

    setState(() {
      nasabahDummy.saldo -= jumlah;
      nasabahDummy.tambahTransaksi(
        Transaksi(
          deskripsi: "Transfer ke $rekening",
          jumlah: -jumlah,
          tanggal: DateTime.now(),
        ),
      );
    });

    _showDialog(
      "Berhasil",
      "Transfer ke rekening $rekening sebesar Rp ${jumlah.toStringAsFixed(0)} berhasil!\nSaldo tersisa: Rp ${nasabahDummy.saldo.toStringAsFixed(0)}",
    );

    _rekeningController.clear();
    _nominalController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Transfer Dana")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.indigo.shade50,
              child: ListTile(
                leading: Icon(
                  Icons.account_balance_wallet,
                  color: Colors.indigo,
                ),
                title: Text(
                  "Saldo Anda",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "Rp ${nasabahDummy.saldo.toStringAsFixed(0)}",
                  style: TextStyle(fontSize: 20, color: Colors.indigo),
                ),
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: _rekeningController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Nomor Rekening Tujuan",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.account_circle),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _nominalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Nominal Transfer",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _transfer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: TextStyle(fontSize: 16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.send),
                    SizedBox(width: 8),
                    Text("Kirim Sekarang"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
