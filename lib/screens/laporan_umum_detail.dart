import 'package:flutter/material.dart';
import 'dart:io';
import '../services/laporan_service.dart';
import 'detail_laporan.dart';

class LaporanUmumDetail extends StatefulWidget {
  final String? status;

  const LaporanUmumDetail({super.key, this.status});

  @override
  State<LaporanUmumDetail> createState() => _LaporanUmumDetailState();
}

class _LaporanUmumDetailState extends State<LaporanUmumDetail> {
  static const Color primaryBlue = Color(0xFF0F5E8C);

  late LaporanService _laporanService;

  @override
  void initState() {
    super.initState();
    _laporanService = LaporanService();
    print('DEBUG laporan_umum_detail: Status = ${widget.status}');
    print('DEBUG laporan_umum_detail: Total laporan dari service = ${_laporanService.laporanBaru.length}');
    
    // Listen untuk perubahan di LaporanService
    _laporanService.addListener(() {
      print('DEBUG laporan_umum_detail: LaporanService berubah! Total sekarang = ${_laporanService.laporanBaru.length}');
      setState(() {});
    });
  }

  @override
  void dispose() {
    _laporanService.removeListener(() {});
    super.dispose();
  }

  // Fungsi untuk mendapatkan data laporan berdasarkan status
  List<Map<String, dynamic>> _getLaporanItems() {
    List<Map<String, dynamic>> items = [];

    print('DEBUG _getLaporanItems: Status = ${widget.status}');
    print('DEBUG _getLaporanItems: Masuk ke kondisi Pending? ${widget.status == 'Pending'}');

    // Jika status Pending, tambahkan laporan yang baru disubmit dari service
    if (widget.status == 'Pending') {
      print('DEBUG _getLaporanItems: Looping laporan dari service, jumlah = ${_laporanService.laporanBaru.length}');
      // Tambahkan laporan dari LaporanService terlebih dahulu
      for (var laporan in _laporanService.laporanBaru) {
        print('DEBUG _getLaporanItems: Menambahkan laporan: ${laporan.jenisFasilitas}');
        items.add({
          'image': laporan.fotoPath ?? 'assets/foto_laporan.png',
          'label': laporan.jenisFasilitas,
          'isFromService': true,
          'laporanData': laporan,
        });
      }
      print('DEBUG _getLaporanItems: Setelah loop, items.length = ${items.length}');
    }

    // Tambahkan data default berdasarkan status
    switch (widget.status) {
      case 'Pending':
        items.addAll([
          {'image': 'assets/foto_laporan.png', 'label': 'Kursi kelas rusak', 'isFromService': false},
          {'image': 'assets/foto_laporan.png', 'label': 'AC tidak berfungsi', 'isFromService': false},
          {'image': 'assets/foto_laporan.png', 'label': 'Lampu mati', 'isFromService': false},
          {'image': 'assets/foto_laporan.png', 'label': 'Toilet rusak', 'isFromService': false},
          {'image': 'assets/foto_laporan.png', 'label': 'Papan tulis rusak', 'isFromService': false},
          {'image': 'assets/foto_laporan.png', 'label': 'Pintu macet', 'isFromService': false},
        ]);
        break;
      case 'Rejected':
        items.addAll([
          {'image': 'assets/foto_laporan.png', 'label': 'Data tidak valid', 'isFromService': false},
          {'image': 'assets/foto_laporan.png', 'label': 'Informasi kurang', 'isFromService': false},
          {'image': 'assets/foto_laporan.png', 'label': 'Foto tidak jelas', 'isFromService': false},
          {'image': 'assets/foto_laporan.png', 'label': 'Lokasi salah', 'isFromService': false},
        ]);
        break;
      case 'Approved':
      default:
        items.addAll([
          {'image': 'assets/foto_laporan.png', 'label': 'Saluran air bocor', 'isFromService': false},
          {'image': 'assets/foto_laporan.png', 'label': 'Meja kantin rusak', 'isFromService': false},
          {'image': 'assets/foto_laporan.png', 'label': 'Kaca pecah', 'isFromService': false},
          {'image': 'assets/foto_laporan.png', 'label': 'Pintu jebol', 'isFromService': false},
          {'image': 'assets/foto_laporan.png', 'label': 'Atap jebol', 'isFromService': false},
          {'image': 'assets/foto_laporan.png', 'label': 'Pintu rusak', 'isFromService': false},
          {'image': 'assets/foto_laporan.png', 'label': 'Keran rusak', 'isFromService': false},
          {'image': 'assets/foto_laporan.png', 'label': 'Meja jebol', 'isFromService': false},
        ]);
        break;
    }

    return items;
  }

  // Fungsi untuk mendapatkan title berdasarkan status
  String _getTitle() {
    switch (widget.status) {
      case 'Pending':
        return 'Laporan Sedang Diproses';
      case 'Rejected':
        return 'Laporan Ditolak';
      case 'Approved':
      default:
        return 'Laporan Sudah Diperbaiki';
    }
  }

  @override
  Widget build(BuildContext context) {
    final laporanItems = _getLaporanItems();
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryBlue),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          _getTitle(),
          style: const TextStyle(
            color: primaryBlue,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.85,
          ),
          itemCount: laporanItems.length,
          itemBuilder: (context, index) {
            return _buildLaporanItem(
              imagePath: laporanItems[index]['image']!,
              label: laporanItems[index]['label']!,
              isFromService: laporanItems[index]['isFromService'] ?? false,
              laporanData: laporanItems[index]['laporanData'],
            );
          },
        ),
      ),
    );
  }

  Widget _buildLaporanItem({
    required String imagePath,
    required String label,
    bool isFromService = false,
    dynamic laporanData,
  }) {
    // Generate deskripsi berdasarkan status
    String description = '';
    
    if (isFromService && laporanData != null) {
      // Jika dari service, gunakan data detail dari laporan yang disubmit
      description =
          'Masalah: ${laporanData.masalahFasilitas}\n\nLokasi: ${laporanData.lokasi}\n\nGangguan: ${laporanData.gangguanAktivitas}';
    } else {
      // Jika default data
      switch (widget.status) {
        case 'Pending':
          description =
              'Laporan $label sedang dalam proses review dan akan segera ditindaklanjuti oleh tim terkait. Mohon menunggu update lebih lanjut.';
          break;
        case 'Rejected':
          description =
              'Laporan $label ditolak karena tidak memenuhi kriteria atau informasi yang diberikan kurang lengkap. Silakan ajukan kembali dengan data yang lebih detail.';
          break;
        case 'Approved':
        default:
          description =
              'Laporan $label telah selesai diperbaiki. Fasilitas kini sudah kembali berfungsi dengan baik dan dapat digunakan sebagaimana mestinya.';
      }
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailLaporanPage(
              title: _getTitle(),
              subtitle: label,
              description: description,
              image: imagePath,
              status: widget.status ?? 'Approved',
              detailImages: [imagePath],
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// IMAGE
            Expanded(
              child: Container(
                color: Colors.grey[100],
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: _buildImageWidget(imagePath),
                ),
              ),
            ),

            /// LABEL
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                border: Border(
                  top: BorderSide(color: Colors.grey[300]!, width: 1),
                ),
              ),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: primaryBlue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build image widget that can handle both asset and file images
  Widget _buildImageWidget(String imagePath) {
    print('DEBUG _buildImageWidget: Mencoba load gambar: $imagePath');
    
    // Check if it's a file path (contains a file separator and doesn't start with 'assets')
    bool isFilePath = imagePath.contains('/') && !imagePath.startsWith('assets');
    
    print('DEBUG _buildImageWidget: isFilePath = $isFilePath');
    
    if (isFilePath) {
      final file = File(imagePath);
      print('DEBUG _buildImageWidget: File exists? ${file.existsSync()}');
      
      if (file.existsSync()) {
        return Image.file(
          file,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            print('DEBUG _buildImageWidget: ERROR loading file image: $error');
            return _buildErrorWidget();
          },
        );
      } else {
        print('DEBUG _buildImageWidget: File tidak ditemukan: $imagePath');
        return _buildErrorWidget();
      }
    } else {
      // Asset image
      print('DEBUG _buildImageWidget: Loading asset image: $imagePath');
      return Image.asset(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print('DEBUG _buildImageWidget: ERROR loading asset image: $error');
          return _buildErrorWidget();
        },
      );
    }
  }

  // Helper method to build error widget
  Widget _buildErrorWidget() {
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: Icon(Icons.image, size: 50, color: Colors.grey[400]),
      ),
    );
  }
}
