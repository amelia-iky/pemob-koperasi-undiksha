import 'package:flutter/material.dart';
import '../data/nasabah_data.dart';
import 'package:intl/intl.dart';

class MutasiPage extends StatelessWidget {
  final format = NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    final histori = nasabahDummy.histori.reversed.toList();
    return Scaffold(
      appBar: AppBar(title: Text("Mutasi Transaksi")),
      body: ListView.builder(
        itemCount: histori.length,
        itemBuilder: (context, index) {
          final transaksi = histori[index];
          return ListTile(
            title: Text(transaksi.deskripsi),
            subtitle: Text("${transaksi.tanggal}"),
            trailing: Text(
              format.format(transaksi.jumlah),
              style: TextStyle(
                color: transaksi.jumlah < 0 ? Colors.red : Colors.green,
              ),
            ),
          );
        },
      ),
    );
  }
}
