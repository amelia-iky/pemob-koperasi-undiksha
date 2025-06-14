enum StatusPinjaman { menunggu, disetujui, ditolak }

class PengajuanPinjaman {
  final double jumlah;
  final DateTime tanggal;
  StatusPinjaman status;

  PengajuanPinjaman({
    required this.jumlah,
    required this.tanggal,
    this.status = StatusPinjaman.menunggu,
  });
}
