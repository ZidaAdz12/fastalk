import 'package:flutter/material.dart';
import 'dart:io';

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

  // Helper method to check if foto exists and is accessible
  bool hasFoto() {
    if (fotoPath == null) return false;
    return File(fotoPath!).existsSync();
  }

  // Helper method to get File object for foto
  File? getFotoFile() {
    if (fotoPath == null) return null;
    final file = File(fotoPath!);
    if (file.existsSync()) {
      return file;
    }
    return null;
  }
}

class KeluhanUmumData {
  final String isiKeluhan;
  final String bagianTerkait;
  final String lokasi;
  final DateTime tanggalKeluhan;

  KeluhanUmumData({
    required this.isiKeluhan,
    required this.bagianTerkait,
    required this.lokasi,
    required this.tanggalKeluhan,
  });
}

class IdeSolusiData {
  final String ideSolusi;
  final String alasanKepentingan;
  final String areaPenerapan;
  final String pihakTerbantu;
  final DateTime tanggalIde;

  IdeSolusiData({
    required this.ideSolusi,
    required this.alasanKepentingan,
    required this.areaPenerapan,
    required this.pihakTerbantu,
    required this.tanggalIde,
  });
}

class LaporanService extends ChangeNotifier {
  static final LaporanService _instance = LaporanService._internal();

  factory LaporanService() {
    return _instance;
  }

  LaporanService._internal();

  final List<LaporanFasilitasData> _laporanBaru = [];
  final List<KeluhanUmumData> _keluhanUmum = [];
  final List<IdeSolusiData> _ideSolusi = [];

  List<LaporanFasilitasData> get laporanBaru => _laporanBaru;
  List<KeluhanUmumData> get keluhanUmum => _keluhanUmum;
  List<IdeSolusiData> get ideSolusi => _ideSolusi;

  // Laporan methods
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

  // Keluhan Umum methods
  void tambahKeluhan(KeluhanUmumData keluhan) {
    _keluhanUmum.insert(0, keluhan);
    notifyListeners();
  }

  void hapusKeluhan(int index) {
    if (index >= 0 && index < _keluhanUmum.length) {
      _keluhanUmum.removeAt(index);
      notifyListeners();
    }
  }

  void clearKeluhan() {
    _keluhanUmum.clear();
    notifyListeners();
  }

  // Ide Solusi methods
  void tambahIdeSolusi(IdeSolusiData ide) {
    _ideSolusi.insert(0, ide);
    notifyListeners();
  }

  void hapusIdeSolusi(int index) {
    if (index >= 0 && index < _ideSolusi.length) {
      _ideSolusi.removeAt(index);
      notifyListeners();
    }
  }

  void clearIdeSolusi() {
    _ideSolusi.clear();
    notifyListeners();
  }
}
