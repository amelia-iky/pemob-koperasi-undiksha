import 'transaksi.dart';
import 'deposito.dart';
import 'pinjaman.dart';

class Nasabah {
  final String nama;
  double saldo;
  final List<Transaksi> histori; // Untuk histori umum
  final List<Transaksi> historiBayar; // Untuk histori pembayaran
  final List<Deposito> daftarDeposito; // Untuk daftar deposito aktif
  final List<PengajuanPinjaman> daftarPinjaman; // Untuk daftar pinjaman

  Nasabah({
    required this.nama,
    required this.saldo,
    List<Transaksi>? histori,
    List<Transaksi>? historiBayar,
    List<Deposito>? daftarDeposito,
    List<PengajuanPinjaman>? daftarPinjaman,
  }) : histori = histori ?? [],
       historiBayar = historiBayar ?? [],
       daftarDeposito = daftarDeposito ?? [],
       daftarPinjaman = daftarPinjaman ?? [];

  /// Menambahkan transaksi ke histori umum
  void tambahTransaksi(Transaksi transaksi) {
    histori.add(transaksi);
  }

  /// Menambahkan transaksi ke histori pembayaran
  void tambahPembayaran(Transaksi transaksi) {
    historiBayar.add(transaksi);
  }

  /// Menambahkan pengajuan pinjaman
  void tambahPengajuanPinjaman(PengajuanPinjaman pinjaman) {
    daftarPinjaman.add(pinjaman);
  }
}
