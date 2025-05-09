import 'package:flutter/material.dart';
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

  void _tambahDeposito() {
    int nominal = int.tryParse(_nominalController.text) ?? 0;

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
      // Kurangi saldo nasabah
      widget.nasabah.saldo -= nominal;

      // Tambahkan ke daftar deposito
      widget.nasabah.daftarDeposito.add(
        Deposito(
          nominal: nominal,
          tenor: _selectedTenor!,
          tanggalPengajuan: DateTime.now(),
        ),
      );

      // Reset form
      _nominalController.clear();
      _selectedTenor = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Deposito berhasil ditambahkan.")),
    );
  }

  @override
  Widget build(BuildContext context) {
    int totalDeposito = widget.nasabah.daftarDeposito.fold(0, (sum, d) => sum + d.nominal);

    return Scaffold(
      appBar: AppBar(
        title: Text('Deposito'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Saldo Anda: Rp ${widget.nasabah.saldo}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 12),
            TextField(
              controller: _nominalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Nominal Deposito',
                prefixText: 'Rp ',
                border: OutlineInputBorder(),
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
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _tambahDeposito,
              icon: Icon(Icons.save),
              label: Text("Ajukan Deposito"),
              style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
            ),
            SizedBox(height: 30),
            Text("Jumlah Deposito: ${widget.nasabah.daftarDeposito.length}", style: TextStyle(fontSize: 16)),
            Text("Total Deposito: Rp $totalDeposito", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
