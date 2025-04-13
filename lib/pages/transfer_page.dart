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

  void _transfer() {
    final double? jumlah = double.tryParse(_nominalController.text);
    if (jumlah == null || jumlah <= 0) {
      setState(() {
        pesan = "Nominal tidak valid.";
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
      nasabahDummy.saldo -= jumlah;
      nasabahDummy.tambahTransaksi(
        Transaksi(
          deskripsi: "Transfer Dana",
          jumlah: -jumlah,
          tanggal: DateTime.now(),
        ),
      );
      pesan = "Transfer berhasil!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Transfer")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nominalController,
              decoration: InputDecoration(labelText: "Nominal"),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(onPressed: _transfer, child: Text("Kirim")),
            if (pesan.isNotEmpty) Text(pesan),
          ],
        ),
      ),
    );
  }
}
