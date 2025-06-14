import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/nasabah_data.dart';
import '../models/transaksi.dart';

class PembayaranPage extends StatefulWidget {
  @override
  State<PembayaranPage> createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  final TextEditingController _nominalController = TextEditingController();
  final TextEditingController _tujuanController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? pesan;
  bool success = false;

  void _bayar() async {
    if (_formKey.currentState?.validate() != true) return;

    final jumlah = double.parse(_nominalController.text);
    final tujuan = _tujuanController.text.trim();

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Konfirmasi Pembayaran"),
        content: Text(
          "Bayar Rp ${NumberFormat('#,##0', 'id').format(jumlah)} untuk '$tujuan'?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text("Ya, Bayar"),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    if (jumlah > nasabahDummy.saldo) {
      setState(() {
        pesan = "Saldo tidak cukup.";
        success = false;
      });
      return;
    }

    setState(() {
      nasabahDummy.saldo -= jumlah;
      nasabahDummy.tambahTransaksi(
        Transaksi(deskripsi: tujuan, jumlah: -jumlah, tanggal: DateTime.now()),
      );
      pesan = "Pembayaran berhasil!";
      success = true;
      _nominalController.clear();
      _tujuanController.clear();
    });

    FocusScope.of(context).unfocus(); // Menutup keyboard
  }

  @override
  Widget build(BuildContext context) {
    final format = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return Scaffold(
      appBar: AppBar(title: Text("Pembayaran")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Saldo Anda:", style: TextStyle(fontSize: 16)),
              Text(
                format.format(nasabahDummy.saldo),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 76, 94, 175),
                ),
              ),
              SizedBox(height: 24),
              TextFormField(
                controller: _tujuanController,
                decoration: InputDecoration(
                  labelText: "Tujuan Pembayaran",
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Tujuan pembayaran wajib diisi";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _nominalController,
                decoration: InputDecoration(
                  labelText: "Nominal Pembayaran",
                  prefixIcon: Icon(Icons.payment),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  final nominal = double.tryParse(value ?? '');
                  if (nominal == null || nominal <= 0) {
                    return "Masukkan nominal yang valid";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: "Catatan (Opsional)",
                  hintText: "Misalnya: Bayar utang, hadiah, dll.",
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.note),
                ),
              ),
              SizedBox(height: 30),
              Text(
                "Catatan: Pembayaran akan diproses dalam waktu 1x24 jam.",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _bayar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo, // Tombol biru
                    foregroundColor: Colors.white, // Warna teks putih
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                  child: Text("Ajukan Pembayaran"), // Menghapus ikon
                ),
              ),
              if (pesan != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    pesan!,
                    style: TextStyle(
                      color: success ? Colors.green : Colors.red,
                      fontSize: 16,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
