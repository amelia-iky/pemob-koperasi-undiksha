import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/nasabah_data.dart';

class CekSaldoPage extends StatelessWidget {
  final format = NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cek Saldo")),
      body: Center(
        child: Text(
          format.format(nasabahDummy.saldo),
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
