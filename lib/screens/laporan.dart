import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav.dart';
import 'detail_laporan.dart';
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

  final List<String> tabs = ['Laporan Umum', 'Laporan Diterima', 'Laporan Ditolak'];

  late LaporanService _laporanService;

  // Data laporan berdasarkan status
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
        title: 'Laporan Fasilitas Rusak',
        subtitle: 'AC Tidak Berfungsi',
        description:
            'Kursi di ruang kelas B2 rusak dan memerlukan perbaikan. Masalah ini mengganggu pembelajaran siswa dan membutuhkan tindakan segera dari pihak terkait.',
        image: 'assets/gedung.png',
        status: 'Pending',
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
  };

  @override
  void initState() {
    super.initState();
    _laporanService = LaporanService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// BOTTOM NAVIGATION
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
              /// TITLE
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

              /// TAB NAVIGATION
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

              /// LAPORAN CARDS
              _buildLaporanContent(_currentTabIndex),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  /// TAB BUTTON WIDGET
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

  /// LAPORAN CONTENT
  Widget _buildLaporanContent(int tabIndex) {
    // Dapatkan nama tab yang aktif
    String activeTab = tabs[tabIndex];
    
    // Dapatkan list laporan berdasarkan tab yang aktif
    List<LaporanData> laporanList = laporanByStatus[activeTab] ?? [];

    // Untuk tab "Laporan Umum", tambahkan data laporan baru dari service
    if (tabIndex == 0) {
      // Konversi data dari LaporanFasilitasData ke LaporanData
      for (var laporan in _laporanService.laporanBaru) {
        laporanList.insert(
          0,
          LaporanData(
            title: 'Laporan Fasilitas Baru',
            subtitle: laporan.jenisFasilitas,
            description:
                'Masalah: ${laporan.masalahFasilitas}\n\nLokasi: ${laporan.lokasi}\n\nGangguan: ${laporan.gangguanAktivitas}',
            image: 'assets/gedung.png',
            status: 'Pending',
            detailImages: ['assets/gedung.png'],
          ),
        );
      }
    }

    if (laporanList.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            children: [
              Icon(
                Icons.inbox,
                size: 64,
                color: Colors.grey[300],
              ),
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
            subtitle: laporanList[index].subtitle,
            detailImages: laporanList[index].detailImages,
          ),
        ),
      ),
    );
  }

  /// LAPORAN CARD WIDGET
  Widget _laporanCard({
    required String title,
    required String description,
    required String imagePath,
    required String status,
    String? subtitle,
    List<String>? detailImages,
  }) {
    // Tentukan warna badge berdasarkan status
    Color badgeColor;
    String statusText;
    
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
              /// IMAGE
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imagePath,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(width: 16),

              /// CONTENT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TITLE
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryBlue,
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// DESCRIPTION
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

          /// STATUS BADGE & BUTTON
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// STATUS BADGE
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
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

              /// VIEW MORE BUTTON
              SizedBox(
                height: 32,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailLaporanPage(
                          title: title,
                          subtitle: subtitle ?? 'Detail Laporan',
                          description: description,
                          image: imagePath,
                          status: status,
                          detailImages: detailImages ?? [imagePath],
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 4,
                    ),
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
}
