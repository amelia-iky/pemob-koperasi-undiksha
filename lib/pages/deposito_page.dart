import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/nasabah.dart';
import '../models/deposito.dart';

class DepositoPage extends StatefulWidget {
  final Nasabah nasabah;

  const DepositoPage({Key? key, required this.nasabah}) : super(key: key);

  @override
  State<DepositoPage> createState() => _DepositoPageState();
}

class _DepositoPageState extends State<DepositoPage> {
  final TextEditingController _nominalController = TextEditingController();
  String? _selectedTenor;
  final List<String> _tenorOptions = ['3 Bulan', '6 Bulan', '12 Bulan'];
  final formatCurrency = NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

  void _tambahDeposito() {
    int nominal = int.tryParse(
      _nominalController.text.replaceAll(RegExp(r'[^0-9]'), ''),
    ) ?? 0;

    if (nominal <= 0 || _selectedTenor == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lengkapi semua data deposito.")),
      );
      return;
    }

    if (nominal > widget.nasabah.saldo) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Saldo tidak mencukupi.")),
      );
      return;
    }

    setState(() {
      widget.nasabah.saldo -= nominal;
      widget.nasabah.daftarDeposito.add(
        Deposito(
          nominal: nominal,
          tenor: _selectedTenor!,
          tanggalPengajuan: DateTime.now(),
        ),
      );
      _nominalController.clear();
      _selectedTenor = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Deposito berhasil ditambahkan.")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deposito'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.account_balance_wallet),
                SizedBox(width: 8),
                Text(
                  "Saldo Anda: ${formatCurrency.format(widget.nasabah.saldo)}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: 16),

            TextField(
              controller: _nominalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Nominal Deposito',
                prefixText: 'Rp ',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.attach_money),
              ),
            ),
            SizedBox(height: 12),

            DropdownButtonFormField<String>(
              value: _selectedTenor,
              items: _tenorOptions
                  .map((tenor) => DropdownMenuItem(value: tenor, child: Text(tenor)))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  _selectedTenor = val;
                });
              },
              decoration: InputDecoration(
                labelText: 'Pilih Jangka Waktu',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.timer),
              ),
            ),
            SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: _tambahDeposito,
              label: Text("Ajukan Deposito"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
                backgroundColor: Colors.blue[800],
                foregroundColor: Colors.white,
              ),
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}