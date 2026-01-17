import 'package:flutter/material.dart';
import 'dart:io';
import '../services/laporan_service.dart';

class LaporanUmumDetail extends StatefulWidget {
  const LaporanUmumDetail({super.key});

  @override
  State<LaporanUmumDetail> createState() => _LaporanUmumDetailState();
}

class _LaporanUmumDetailState extends State<LaporanUmumDetail> {
  static const Color primaryBlue = Color(0xFF0F5E8C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryBlue),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Laporan Umum',
          style: TextStyle(
            color: primaryBlue,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Daftar Laporan yang Diajukan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 16),

              // Tabel Laporan
              _buildLaporanTable(),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLaporanTable() {
    final laporanService = LaporanService();

    return StreamBuilder(
      stream: null, // Menggunakan notifier dari LaporanService
      builder: (context, snapshot) {
        // Ambil data dari service
        final laporanList = laporanService.laporanBaru;

        if (laporanList.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Center(
              child: Text(
                'Belum ada laporan yang diajukan',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ),
          );
        }

        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 16,
              horizontalMargin: 16,
              columns: [
                DataColumn(
                  label: Text(
                    'No',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryBlue,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Jenis Fasilitas',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryBlue,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Lokasi',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryBlue,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Masalah',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryBlue,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Tanggal',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryBlue,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Aksi',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryBlue,
                    ),
                  ),
                ),
              ],
              rows: List.generate(
                laporanList.length,
                (index) {
                  final laporan = laporanList[index];
                  return DataRow(
                    cells: [
                      DataCell(Text((index + 1).toString())),
                      DataCell(
                        SizedBox(
                          width: 120,
                          child: Text(
                            laporan.jenisFasilitas,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: 100,
                          child: Text(
                            laporan.lokasi,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: 120,
                          child: Text(
                            laporan.masalahFasilitas,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          laporan.tanggalLaporan
                              .toString()
                              .split(' ')[0],
                        ),
                      ),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.visibility,
                                color: primaryBlue,
                                size: 20,
                              ),
                              onPressed: () {
                                _showDetailDialog(context, laporan);
                              },
                              tooltip: 'Lihat Detail',
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 20,
                              ),
                              onPressed: () {
                                _showDeleteConfirmation(context, index);
                              },
                              tooltip: 'Hapus',
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _showDetailDialog(BuildContext context, LaporanFasilitasData laporan) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Detail Laporan'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _detailItem('Jenis Fasilitas:', laporan.jenisFasilitas),
              _detailItem('Lokasi:', laporan.lokasi),
              _detailItem('Masalah Fasilitas:', laporan.masalahFasilitas),
              _detailItem(
                  'Gangguan Aktivitas:', laporan.gangguanAktivitas),
              _detailItem(
                'Tanggal Laporan:',
                laporan.tanggalLaporan.toString().split(' ')[0],
              ),
              if (laporan.fotoPath != null) ...[
                const SizedBox(height: 12),
                const Text(
                  'Foto:',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(laporan.fotoPath!),
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Laporan'),
        content: const Text(
            'Apakah Anda yakin ingin menghapus laporan ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              final laporanService = LaporanService();
              laporanService.hapusLaporan(index);
              Navigator.pop(context);
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Laporan berhasil dihapus')),
              );
            },
            child: const Text(
              'Hapus',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
