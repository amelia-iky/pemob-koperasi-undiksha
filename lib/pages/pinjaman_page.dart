import 'package:flutter/material.dart';
import '../data/nasabah_data.dart';
import '../models/transaksi.dart';
import 'package:intl/intl.dart';

class PinjamanPage extends StatefulWidget {
  @override
  State<PinjamanPage> createState() => _PinjamanPageState();
}

class _PinjamanPageState extends State<PinjamanPage> {
  final TextEditingController _nominalController = TextEditingController();
  String pesan = '';

  void _pinjam() {
    final double? jumlah = double.tryParse(_nominalController.text);
    if (jumlah == null || jumlah <= 0) {
      setState(() {
        pesan = "Nominal tidak valid.";
      });
      return;
    }

    setState(() {
      nasabahDummy.saldo += jumlah;
      nasabahDummy.tambahTransaksi(
        Transaksi(
          deskripsi: "Pinjaman Masuk",
          jumlah: jumlah,
          tanggal: DateTime.now(),
        ),
      );
      pesan = "Pinjaman berhasil ditambahkan ke saldo.";
      _nominalController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final format = NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
      appBar: AppBar(title: Text("Pinjaman")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Saldo Saat Ini: ${format.format(nasabahDummy.saldo)}"),
            TextField(
              controller: _nominalController,
              decoration: InputDecoration(labelText: "Nominal Pinjaman"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(onPressed: _pinjam, child: Text("Ajukan Pinjaman")),
            if (pesan.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(pesan, style: TextStyle(color: Colors.green)),
              )
          ],
        ),
      ),
    );
  }
}
