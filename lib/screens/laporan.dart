import 'dart:io';
import 'package:flutter/material.dart';

import '../widgets/custom_bottom_nav.dart';
import 'laporan_umum_detail.dart';
import 'ide_keluhan.dart';
import '../services/laporan_service.dart';

class LaporanData {
  final String title;
  final String subtitle;
  final String description;
  final String image;
  final String status;
  final List<String> detailImages;

  LaporanData({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.image,
    required this.status,
    required this.detailImages,
  });
}

class LaporanPage extends StatefulWidget {
  const LaporanPage({super.key});

  @override
  State<LaporanPage> createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage> {
  int _currentNavIndex = 1;
  int _currentTabIndex = 0;

  static const Color primaryBlue = Color(0xFF0F5E8C);

  final List<String> tabs = [
    'Laporan Umum',
    'Laporan Diterima',
    'Laporan Ditolak',
    'Ide dan Keluhan',
  ];

  late final LaporanService _laporanService;
  late final VoidCallback _serviceListener;

  final Map<String, List<LaporanData>> laporanByStatus = {
    'Laporan Umum': [
      LaporanData(
        title: 'Laporan Sedang Diproses',
        subtitle: 'Kursi Kelas Rusak',
        description:
            'Lorem busan dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
        image: 'assets/gedung.png',
        status: 'Pending',
        detailImages: ['assets/gedung.png', 'assets/gedung.png'],
      ),
      LaporanData(
        title: 'Laporan Sudah Diperbaiki',
        subtitle: 'Laporan Sudah Diperbaiki',
        description:
            'Fasilitas yang sebelumnya rusak dan bermasalah kini telah selesai diperbaiki dan kembali berfungsi dengan baik. Terima kasih telah melaporkan, tim maintenance telah menindaklanjuti dengan cepat.',
        image: 'assets/gedung.png',
        status: 'Approved',
        detailImages: ['assets/gedung.png', 'assets/gedung.png'],
      ),
    ],
    'Laporan Diterima': [
      LaporanData(
        title: 'Laporan Sudah Diperbaiki',
        subtitle: 'Atap Jebol',
        description:
            'Fasilitas atap yang sebelumnya mengalami kerusakan dan jebol kini telah diperbaiki. Struktur penutup atap telah diperkuat, disampaikan area di bawahnya kembali aman, terisolasi dari cuaca, serta dapat digunakan sebagaimana mestinya.',
        image: 'assets/gedung.png',
        status: 'Approved',
        detailImages: ['assets/gedung.png', 'assets/gedung.png'],
      ),
      LaporanData(
        title: 'Perbaikan Atap Ruang Lab',
        subtitle: 'Perbaikan Selesai',
        description:
            'Laporan perbaikan atap ruang laboratorium telah diterima dan disetujui. Proses perbaikan akan segera dimulai minggu depan.',
        image: 'assets/gedung.png',
        status: 'Approved',
        detailImages: ['assets/gedung.png', 'assets/gedung.png'],
      ),
    ],
    'Laporan Ditolak': [
      LaporanData(
        title: 'Laporan Tidak Sesuai Prosedur',
        subtitle: 'Data Tidak Valid',
        description:
            'Laporan ini ditolak karena tidak memenuhi standar prosedur pelaporan. Silakan lakukan perbaikan dan ajukan kembali dengan informasi yang lebih lengkap.',
        image: 'assets/gedung.png',
        status: 'Rejected',
        detailImages: ['assets/gedung.png', 'assets/gedung.png'],
      ),
      LaporanData(
        title: 'Data Tidak Lengkap',
        subtitle: 'Informasi Kurang',
        description:
            'Laporan ini ditolak karena data yang disertakan belum lengkap. Mohon lengkapi semua informasi yang diperlukan sebelum mengajukan ulang.',
        image: 'assets/gedung.png',
        status: 'Rejected',
        detailImages: ['assets/gedung.png', 'assets/gedung.png'],
      ),
    ],

    // Kalau kamu mau benar-benar hilang, hapus item "Keluhan Umum" di bawah ini.
    'Ide dan Keluhan': [
      LaporanData(
        title: 'Ide dan solusi',
        subtitle: 'Penambahan Area Istirahat',
        description:
            'Saran untuk menambahkan area istirahat yang lebih nyaman di lantai 2. Dengan penambahan ini, mahasiswa dan karyawan akan memiliki tempat yang lebih baik untuk bersantai antara jam-jam kerja.',
        image: 'assets/gedung.png',
        status: 'None',
        detailImages: ['assets/gedung.png', 'assets/gedung.png'],
      ),
      // HAPUS BLOK INI kalau kamu ingin card "Keluhan Umum" hilang:
      // LaporanData(
      //   title: 'Keluhan Umum',
      //   subtitle: 'Kualitas Makanan dan Harga',
      //   description:
      //       'Keluhan mengenai kualitas makanan di kafeteria yang menurun dan harga yang terus meningkat. Mohon untuk melakukan evaluasi terhadap standar kualitas makanan dan pertimbangkan untuk menstabilkan harga.',
      //   image: 'assets/gedung.png',
      //   status: 'None',
      //   detailImages: ['assets/gedung.png', 'assets/gedung.png'],
      // ),
    ],
  };

  @override
  void initState() {
    super.initState();
    _laporanService = LaporanService();

    _serviceListener = () {
      if (!mounted) return;
      setState(() {});
    };
    _laporanService.addListener(_serviceListener);
  }

  @override
  void dispose() {
    _laporanService.removeListener(_serviceListener);
    super.dispose();
  }

  bool _isIdeDanKeluhanTab(int tabIndex) {
    if (tabIndex < 0 || tabIndex >= tabs.length) return false;
    return tabs[tabIndex] == 'Ide dan Keluhan';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          setState(() {
            _currentNavIndex = index;
          });
          if (index == 0) {
            Navigator.pop(context);
          }
        },
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 16),
                child: Text(
                  'Status Laporan',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: primaryBlue,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      tabs.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: _tabButton(
                          title: tabs[index],
                          isActive: _currentTabIndex == index,
                          onTap: () {
                            setState(() {
                              _currentTabIndex = index;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              _buildLaporanContent(_currentTabIndex),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabButton({
    required String title,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color.fromARGB(255, 13, 127, 194) : Colors.transparent,
          border: Border(
            bottom: BorderSide(
              color: isActive ? primaryBlue : Colors.grey[300]!,
              width: isActive ? 2 : 1,
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? primaryBlue : Colors.grey,
            fontSize: 14,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildLaporanContent(int tabIndex) {
    final String activeTab = tabs[tabIndex];
    final List<LaporanData> laporanList = laporanByStatus[activeTab] ?? [];

    if (laporanList.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            children: [
              Icon(Icons.inbox, size: 64, color: Colors.grey[300]),
              const SizedBox(height: 16),
              Text(
                'Tidak ada laporan $activeTab',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: List.generate(
        laporanList.length,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: _laporanCard(
            title: laporanList[index].title,
            description: laporanList[index].description,
            imagePath: laporanList[index].image,
            status: laporanList[index].status,
          ),
        ),
      ),
    );
  }

  Widget _laporanCard({
    required String title,
    required String description,
    required String imagePath,
    required String status,
  }) {
    Color badgeColor;
    String statusText;
    bool showStatus = true;

    switch (status) {
      case 'Pending':
        badgeColor = Colors.orange;
        statusText = 'Sedang Diproses';
        break;
      case 'Approved':
        badgeColor = Colors.green;
        statusText = 'Diterima';
        break;
      case 'Rejected':
        badgeColor = Colors.red;
        statusText = 'Ditolak';
        break;
      case 'None':
        showStatus = false;
        badgeColor = Colors.grey;
        statusText = '';
        break;
      default:
        badgeColor = Colors.grey;
        statusText = 'Unknown';
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: _buildCardImage(imagePath),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryBlue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: showStatus ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
            children: [
              if (showStatus)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: badgeColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: badgeColor),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: badgeColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              SizedBox(
                height: 32,
                child: ElevatedButton(
                  onPressed: () {
                    final bool isIdeTab = _isIdeDanKeluhanTab(_currentTabIndex);
                    if (isIdeTab) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KeluhanIdeSolusiViewMore(
                            laporanService: _laporanService,
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LaporanUmumDetail(status: status),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  ),
                  child: const Text(
                    'View More',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardImage(String imagePath) {
    final bool isFilePath = imagePath.contains('/') && !imagePath.startsWith('assets');

    if (isFilePath) {
      final file = File(imagePath);
      if (file.existsSync()) {
        return Image.file(
          file,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _buildCardErrorWidget(),
        );
      }
      return _buildCardErrorWidget();
    }

    return Image.asset(
      imagePath,
      width: 100,
      height: 100,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => _buildCardErrorWidget(),
    );
  }

  Widget _buildCardErrorWidget() {
    return Container(
      width: 100,
      height: 100,
      color: Colors.grey[200],
      child: Icon(Icons.image, size: 40, color: Colors.grey[400]),
    );
  }
}
