import 'transaksi.dart';

class Nasabah {
  final String nama;
  double saldo;
  List<Transaksi> histori;
  List<Transaksi> historiBayar;

  Nasabah({
    required this.nama,
    required this.saldo,
    required this.histori,
    required this.historiBayar,
  });

  void tambahTransaksi(Transaksi transaksi) {
    histori.add(transaksi);
  }

  void tambahPembayaran(Transaksi transaksi) {
    historiBayar.add(transaksi);
  }
}
