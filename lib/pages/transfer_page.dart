import 'package:flutter/material.dart';
import '../data/nasabah_data.dart';
import '../models/transaksi.dart';

class TransferPage extends StatefulWidget {
  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  final TextEditingController _nominalController = TextEditingController();
  String pesan = '';
  double saldoTersisa = nasabahDummy.saldo; // Simpan saldo yang tersisa

  void _transfer() {
    final double? jumlah = double.tryParse(_nominalController.text);
    if (jumlah == null || jumlah <= 0) {
      setState(() {
        pesan = "Nominal tidak valid. Harap masukkan angka yang lebih besar dari 0.";
      });
      return;
    }

    if (jumlah > nasabahDummy.saldo) {
      setState(() {
        pesan = "Saldo tidak cukup.";
      });
      return;
    }

    setState(() {
      nasabahDummy.saldo -= jumlah; // Update saldo nasabah
      saldoTersisa = nasabahDummy.saldo; // Update saldo tersisa
      nasabahDummy.tambahTransaksi(
        Transaksi(
          deskripsi: "Transfer Dana",
          jumlah: -jumlah,
          tanggal: DateTime.now(),
        ),
      );
      pesan = "Transfer berhasil! Saldo tersisa: Rp ${saldoTersisa.toStringAsFixed(0)}";
    });

    // Clear text field setelah transfer
    _nominalController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Transfer")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Saldo Anda: Rp ${nasabahDummy.saldo.toStringAsFixed(0)}", // Menampilkan saldo awal
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            TextField(
              controller: _nominalController,
              decoration: InputDecoration(labelText: "Nominal"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _transfer,
              child: Text("Kirim"),
            ),
            SizedBox(height: 20),
            if (pesan.isNotEmpty)
              Text(
                pesan,
                style: TextStyle(color: pesan.contains("berhasil") ? Colors.green : Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
