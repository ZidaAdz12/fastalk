import 'package:flutter/material.dart';

class LaporanFasilitasData {
  final String jenisFasilitas;
  final String lokasi;
  final String masalahFasilitas;
  final String gangguanAktivitas;
  final String? fotoPath;
  final DateTime tanggalLaporan;

  LaporanFasilitasData({
    required this.jenisFasilitas,
    required this.lokasi,
    required this.masalahFasilitas,
    required this.gangguanAktivitas,
    this.fotoPath,
    required this.tanggalLaporan,
  });
}

class LaporanService extends ChangeNotifier {
  static final LaporanService _instance = LaporanService._internal();

  factory LaporanService() {
    return _instance;
  }

  LaporanService._internal();

  final List<LaporanFasilitasData> _laporanBaru = [];

  List<LaporanFasilitasData> get laporanBaru => _laporanBaru;

  void tambahLaporan(LaporanFasilitasData laporan) {
    _laporanBaru.insert(0, laporan); // Tambah di awal list
    notifyListeners();
  }

  void hapusLaporan(int index) {
    if (index >= 0 && index < _laporanBaru.length) {
      _laporanBaru.removeAt(index);
      notifyListeners();
    }
  }

  void clearLaporan() {
    _laporanBaru.clear();
    notifyListeners();
  }
}
