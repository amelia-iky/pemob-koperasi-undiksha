import 'package:flutter/material.dart';
import '../data/nasabah_data.dart';
import '../models/transaksi.dart';
import 'package:intl/intl.dart';

class PembayaranPage extends StatefulWidget {
  @override
  State<PembayaranPage> createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  final TextEditingController _nominalController = TextEditingController();
  String pesan = '';

  void _bayar() {
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
          deskripsi: "Pembayaran",
          jumlah: -jumlah,
          tanggal: DateTime.now(),
        ),
      );
      pesan = "Pembayaran berhasil!";
      _nominalController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final format = NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
      appBar: AppBar(title: Text("Pembayaran")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Saldo: ${format.format(nasabahDummy.saldo)}"),
            TextField(
              controller: _nominalController,
              decoration: InputDecoration(labelText: "Nominal Pembayaran"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(onPressed: _bayar, child: Text("Bayar")),
            if (pesan.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(pesan, style: TextStyle(color: Colors.blue)),
              )
          ],
        ),
      ),
    );
  }
}