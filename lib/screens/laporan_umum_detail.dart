import 'package:flutter/material.dart';
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

  // Fungsi untuk mendapatkan data laporan berdasarkan status
  List<Map<String, String>> _getLaporanItems() {
    switch (widget.status) {
      case 'Pending':
        return [
          {'image': 'assets/foto_laporan.png', 'label': 'Kursi kelas rusak'},
          {'image': 'assets/foto_laporan.png', 'label': 'AC tidak berfungsi'},
          {'image': 'assets/foto_laporan.png', 'label': 'Lampu mati'},
          {'image': 'assets/foto_laporan.png', 'label': 'Toilet rusak'},
          {'image': 'assets/foto_laporan.png', 'label': 'Papan tulis rusak'},
          {'image': 'assets/foto_laporan.png', 'label': 'Pintu macet'},
        ];
      case 'Rejected':
        return [
          {'image': 'assets/foto_laporan.png', 'label': 'Data tidak valid'},
          {'image': 'assets/foto_laporan.png', 'label': 'Informasi kurang'},
          {'image': 'assets/foto_laporan.png', 'label': 'Foto tidak jelas'},
          {'image': 'assets/foto_laporan.png', 'label': 'Lokasi salah'},
        ];
      case 'Approved':
      default:
        return [
          {'image': 'assets/foto_laporan.png', 'label': 'Saluran air bocor'},
          {'image': 'assets/foto_laporan.png', 'label': 'Meja kantin rusak'},
          {'image': 'assets/foto_laporan.png', 'label': 'Kaca pecah'},
          {'image': 'assets/foto_laporan.png', 'label': 'Pintu jebol'},
          {'image': 'assets/foto_laporan.png', 'label': 'Atap jebol'},
          {'image': 'assets/foto_laporan.png', 'label': 'Pintu rusak'},
          {'image': 'assets/foto_laporan.png', 'label': 'Keran rusak'},
          {'image': 'assets/foto_laporan.png', 'label': 'Meja jebol'},
        ];
    }
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
            );
          },
        ),
      ),
    );
  }

  Widget _buildLaporanItem({required String imagePath, required String label}) {
    // Generate deskripsi berdasarkan status
    String description = '';
    switch (widget.status) {
      case 'Pending':
        description = 'Laporan $label sedang dalam proses review dan akan segera ditindaklanjuti oleh tim terkait. Mohon menunggu update lebih lanjut.';
        break;
      case 'Rejected':
        description = 'Laporan $label ditolak karena tidak memenuhi kriteria atau informasi yang diberikan kurang lengkap. Silakan ajukan kembali dengan data yang lebih detail.';
        break;
      case 'Approved':
      default:
        description = 'Laporan $label telah selesai diperbaiki. Fasilitas kini sudah kembali berfungsi dengan baik dan dapat digunakan sebagaimana mestinya.';
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
              detailImages: [imagePath, imagePath],
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
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Jika gambar tidak ditemukan, tampilkan placeholder
                    return Container(
                      color: Colors.grey[200],
                      child: Icon(Icons.image, size: 50, color: Colors.grey[400]),
                    );
                  },
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
}
