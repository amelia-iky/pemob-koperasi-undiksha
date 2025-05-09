import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/nasabah_data.dart';

class CekSaldoPage extends StatefulWidget {
  @override
  _CekSaldoPageState createState() => _CekSaldoPageState();
}

class _CekSaldoPageState extends State<CekSaldoPage> {
  final format = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  double? saldo;

  @override
  void initState() {
    super.initState();
    _loadSaldo();
  }

  void _loadSaldo() {
    setState(() {
      saldo = nasabahDummy.saldo; // Dummy fetch, bisa diganti ke API call
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cek Saldo"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child:
            saldo != null
                ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.account_balance_wallet,
                      size: 80,
                      color: Colors.blueAccent,
                    ),
                    const SizedBox(height: 16),
                    const Text('Saldo Anda', style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 8),
                    Text(
                      format.format(saldo),
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: _loadSaldo,
                      icon: const Icon(Icons.refresh),
                      label: const Text("Refresh Saldo"),
                    ),
                    const SizedBox(height: 12),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pop(context); // Kembali ke halaman sebelumnya
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text("Kembali"),
                    ),
                  ],
                )
                : const CircularProgressIndicator(),
      ),
    );
  }
}
