import 'transaksi.dart';
import 'deposito.dart';

class Nasabah {
  final String nama;
  double saldo;
  List<Transaksi> histori;
  List<Transaksi> historiBayar;
  List<Deposito> daftarDeposito;

  Nasabah({
    required this.nama,
    required this.saldo,
    required this.histori,
    required this.historiBayar,
    List<Deposito>? daftarDeposito, // Optional: jika tidak diisi, default ke []
  }) : daftarDeposito = daftarDeposito ?? [];

  /// Menambahkan transaksi ke histori umum
  void tambahTransaksi(Transaksi transaksi) {
    histori.add(transaksi);
  }

  /// Menambahkan transaksi ke histori pembayaran
  void tambahPembayaran(Transaksi transaksi) {
    historiBayar.add(transaksi);
  }
}
