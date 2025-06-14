import 'package:flutter/material.dart';
import '../data/nasabah_data.dart';
import 'package:intl/intl.dart';

class MutasiPage extends StatelessWidget {
  final formatCurrency = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp ',
    decimalDigits: 0,
  );
  final formatDate = DateFormat('dd MMM yyyy, HH:mm', 'id');

  MutasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final histori = nasabahDummy.histori.reversed.toList();
    final depositoList = nasabahDummy.daftarDeposito;
    final totalDeposito = depositoList.fold(0, (sum, d) => sum + d.nominal);

    return Scaffold(
      appBar: AppBar(title: Text("Mutasi Transaksi"), centerTitle: true),
      body: Column(
        children: [
          // Bagian info deposito
          Container(
            width: double.infinity,
            color: Colors.blue.shade50,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Informasi Deposito",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.list_alt, size: 20),
                    SizedBox(width: 8),
                    Text(
                      "Jumlah Deposito: ${depositoList.length}",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.savings, size: 20),
                    SizedBox(width: 8),
                    Text(
                      "Total Deposito: ${formatCurrency.format(totalDeposito)}",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Bagian histori transaksi
          Expanded(
            child:
                histori.isEmpty
                    ? Center(
                      child: Text(
                        "Tidak ada transaksi.",
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                    : ListView.builder(
                      padding: EdgeInsets.all(12),
                      itemCount: histori.length,
                      itemBuilder: (context, index) {
                        final transaksi = histori[index];
                        final isMinus = transaksi.jumlah < 0;
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            title: Text(
                              transaksi.deskripsi,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              formatDate.format(transaksi.tanggal),
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            trailing: Text(
                              formatCurrency.format(transaksi.jumlah),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isMinus ? Colors.red : Colors.green,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
