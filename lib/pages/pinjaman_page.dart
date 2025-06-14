import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/nasabah_data.dart';
import '../models/pinjaman.dart';

class PinjamanPage extends StatefulWidget {
  @override
  State<PinjamanPage> createState() => _PinjamanPageState();
}

class _PinjamanPageState extends State<PinjamanPage> {
  final TextEditingController _nominalController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isSubmitting = false;
  String? _pesan;

  void _ajukanPinjaman() {
    if (!_formKey.currentState!.validate()) return;

    final double jumlah = double.parse(_nominalController.text);

    setState(() {
      _isSubmitting = true;
    });

    Future.delayed(Duration(seconds: 1), () {
      final pengajuan = PengajuanPinjaman(
        jumlah: jumlah,
        tanggal: DateTime.now(),
      );

      setState(() {
        nasabahDummy.tambahPengajuanPinjaman(pengajuan);
        _pesan =
            "Pengajuan pinjaman sebesar Rp ${NumberFormat("#,##0", "id_ID").format(jumlah)} berhasil diajukan dan sedang menunggu persetujuan.";
        _nominalController.clear();
        _isSubmitting = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final format = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return Scaffold(
      appBar: AppBar(title: Text("Ajukan Pinjaman")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Icon(Icons.request_quote, size: 80, color: Colors.indigo),
              SizedBox(height: 16),
              Text(
                "Saldo Anda Saat Ini",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                format.format(nasabahDummy.saldo),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigo),
              ),
              SizedBox(height: 24),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _nominalController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Nominal Pinjaman",
                            border: OutlineInputBorder(),
                            prefixText: "Rp ",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return "Masukkan nominal pinjaman";
                            final num? number = num.tryParse(value);
                            if (number == null || number <= 0)
                              return "Nominal tidak valid";
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isSubmitting ? null : _ajukanPinjaman,
                          child: _isSubmitting
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text("Ajukan Pinjaman"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                      if (_pesan != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            _pesan!,
                            style: TextStyle(color: Colors.green[700], fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Riwayat Pengajuan Pinjaman:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 8),
              ...nasabahDummy.daftarPinjaman.map(
                (p) => Card(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    leading: Icon(Icons.history, color: Colors.blue),
                    title: Text(
                      "${format.format(p.jumlah)} - ${DateFormat('dd MMM yyyy').format(p.tanggal)}",
                    ),
                    subtitle: Text(
                      p.status == StatusPinjaman.menunggu
                          ? "Menunggu persetujuan"
                          : p.status == StatusPinjaman.disetujui
                              ? "Disetujui"
                              : "Ditolak",
                      style: TextStyle(
                        color: p.status == StatusPinjaman.disetujui
                            ? Colors.green
                            : p.status == StatusPinjaman.ditolak
                                ? Colors.red
                                : Colors.orange,
                      ),
                    ),
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
