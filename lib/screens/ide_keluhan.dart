import 'dart:io';
import 'package:flutter/material.dart';

import '../services/laporan_service.dart';
import '../widgets/custom_bottom_nav.dart';
import 'laporan_umum_detail.dart';

class IdeKeluhanData {
  final String title;
  final String subtitle;
  final String description;
  final String image;
  final String status;
  final List<String> detailImages;

  IdeKeluhanData({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.image,
    required this.status,
    required this.detailImages,
  });
}

class IdeKeluhanPage extends StatefulWidget {
  const IdeKeluhanPage({super.key});

  @override
  State<IdeKeluhanPage> createState() => _IdeKeluhanPageState();
}

class _IdeKeluhanPageState extends State<IdeKeluhanPage> {
  int _currentNavIndex = 1;
  int _currentTabIndex = 0;

  static const Color primaryBlue = Color(0xFF0F5E8C);

  final List<String> tabs = [
    'Ide Dan Keluhan Umum',
    'Ide Dan Keluhan Diterima',
    'Ide Dan Keluhan Ditolak',
  ];

  late final LaporanService _laporanService;

  late final VoidCallback _serviceListener;

  final Map<String, List<IdeKeluhanData>> ideKeluhanByStatus = {
    'Ide Dan Keluhan Umum': [
      IdeKeluhanData(
        title: 'Usulan Perbaikan Ruang Kelas',
        subtitle: 'Kursi Kelas Rusak',
        description:
            'Lorem busan dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
        image: 'assets/foto_laporan.png',
        status: 'Pending',
        detailImages: ['assets/foto_laporan.png', 'assets/gedung.png'],
      ),
      IdeKeluhanData(
        title: 'Keluhan Fasilitas Kantin',
        subtitle: 'Keluhan Fasilitas',
        description:
            'Fasilitas kantin yang sebelumnya kurang memadai kini telah ditingkatkan. Berbagai perbaikan telah dilakukan untuk meningkatkan kenyamanan siswa dan karyawan. Terima kasih telah memberikan masukan yang sangat berharga.',
        image: 'assets/gedung.png',
        status: 'Approved',
        detailImages: ['assets/gedung.png', 'assets/foto_laporan.png'],
      ),
    ],
    'Ide Dan Keluhan Diterima': [
      IdeKeluhanData(
        title: 'Ide Penambahan Perpustakaan',
        subtitle: 'Usulan Diterima',
        description:
            'Ide penambahan koleksi buku di perpustakaan telah diterima dengan antusias. Manajemen akan melakukan evaluasi dan mulai mengimplementasikan saran Anda dalam waktu dekat untuk meningkatkan fasilitas pembelajaran.',
        image: 'assets/laporan.png',
        status: 'Approved',
        detailImages: ['assets/laporan.png', 'assets/gedung.png'],
      ),
      IdeKeluhanData(
        title: 'Perbaikan Sistem Wifi',
        subtitle: 'Ide Diterima',
        description:
            'Usulan perbaikan sistem wifi di berbagai area telah diterima. Tim teknis akan segera melakukan upgrade dan optimalisasi jaringan untuk memberikan koneksi yang lebih baik.',
        image: 'assets/foto_laporan.png',
        status: 'Approved',
        detailImages: ['assets/foto_laporan.png', 'assets/laporan.png'],
      ),
    ],
    'Ide Dan Keluhan Ditolak': [
      IdeKeluhanData(
        title: 'Usulan Tidak Sesuai Prosedur',
        subtitle: 'Data Tidak Valid',
        description:
            'Usulan ini ditolak karena tidak memenuhi standar prosedur yang berlaku. Silakan lakukan perbaikan dan ajukan kembali dengan informasi yang lebih lengkap dan sesuai dengan ketentuan.',
        image: 'assets/gedung.png',
        status: 'Rejected',
        detailImages: ['assets/gedung.png', 'assets/foto_laporan.png'],
      ),
      IdeKeluhanData(
        title: 'Data Tidak Lengkap',
        subtitle: 'Informasi Kurang',
        description:
            'Usulan ini ditolak karena data yang disertakan belum lengkap. Mohon lengkapi semua informasi yang diperlukan sebelum mengajukan ulang dengan lebih detail.',
        image: 'assets/laporan.png',
        status: 'Rejected',
        detailImages: ['assets/laporan.png', 'assets/gedung.png'],
      ),
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
                  'Ide Dan Keluhan',
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

              _buildIdeKeluhanContent(_currentTabIndex),

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
          color: isActive
              ? const Color.fromARGB(255, 13, 127, 194)
              : Colors.transparent,
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

  Widget _buildIdeKeluhanContent(int tabIndex) {
    final String activeTab = tabs[tabIndex];

    List<IdeKeluhanData> ideKeluhanList = [];

    if (activeTab == 'Ide Dan Keluhan Umum') {
      for (int i = 0; i < _laporanService.keluhanUmum.length && i < 2; i++) {
        final keluhan = _laporanService.keluhanUmum[i];
        ideKeluhanList.add(
          IdeKeluhanData(
            title: keluhan.isiKeluhan,
            subtitle: keluhan.bagianTerkait,
            description: 'Lokasi: ${keluhan.lokasi}',
            image: 'assets/foto_laporan.png',
            status: 'Pending',
            detailImages: const ['assets/foto_laporan.png'],
          ),
        );
      }

      for (int i = 0; i < _laporanService.ideSolusi.length && i < 2; i++) {
        final ide = _laporanService.ideSolusi[i];
        final alasan = ide.alasanKepentingan;
        ideKeluhanList.add(
          IdeKeluhanData(
            title: ide.ideSolusi,
            subtitle: ide.areaPenerapan,
            description: alasan.length > 50 ? '${alasan.substring(0, 50)}...' : alasan,
            image: 'assets/foto_laporan.png',
            status: 'Pending',
            detailImages: const ['assets/foto_laporan.png'],
          ),
        );
      }

      ideKeluhanList.addAll(ideKeluhanByStatus[activeTab] ?? []);
    } else {
      ideKeluhanList = ideKeluhanByStatus[activeTab] ?? [];
    }

    if (ideKeluhanList.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            children: [
              Icon(Icons.inbox, size: 64, color: Colors.grey[300]),
              const SizedBox(height: 16),
              Text(
                'Tidak ada ide dan keluhan $activeTab',
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
        ideKeluhanList.length,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: _ideKeluhanCard(
            title: ideKeluhanList[index].title,
            description: ideKeluhanList[index].description,
            imagePath: ideKeluhanList[index].image,
            status: ideKeluhanList[index].status,
            subtitle: ideKeluhanList[index].subtitle,
            detailImages: ideKeluhanList[index].detailImages,
          ),
        ),
      ),
    );
  }

  Widget _ideKeluhanCard({
    required String title,
    required String description,
    required String imagePath,
    required String status,
    String? subtitle,
    List<String>? detailImages,
  }) {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                    if (_currentTabIndex == 0) {
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
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

class KeluhanIdeSolusiViewMore extends StatelessWidget {
  final LaporanService laporanService;
  const KeluhanIdeSolusiViewMore({super.key, required this.laporanService});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: _KeluhanIdeSolusiViewMoreContent(laporanService: laporanService),
    );
  }
}

class _KeluhanIdeSolusiViewMoreContent extends StatefulWidget {
  final LaporanService laporanService;
  const _KeluhanIdeSolusiViewMoreContent({required this.laporanService});

  @override
  State<_KeluhanIdeSolusiViewMoreContent> createState() =>
      _KeluhanIdeSolusiViewMoreContentState();
}

class _KeluhanIdeSolusiViewMoreContentState
    extends State<_KeluhanIdeSolusiViewMoreContent> {
  static const Color primaryBlue = Color(0xFF0F5E8C);

  late final LaporanService _laporanService;
  late final VoidCallback _serviceListener;

  @override
  void initState() {
    super.initState();
    _laporanService = widget.laporanService;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryBlue),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Ide dan Keluhan Umum',
          style: TextStyle(
            color: primaryBlue,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        bottom: const TabBar(
          labelColor: primaryBlue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: primaryBlue,
          tabs: [
            Tab(text: 'Keluhan'),
            Tab(text: 'Ide & Solusi'),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: TabBarView(
        children: [
          _laporanService.keluhanUmum.isEmpty
              ? _emptyCenter('Belum ada keluhan')
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  itemCount: _laporanService.keluhanUmum.length,
                  itemBuilder: (context, index) {
                    final keluhan = _laporanService.keluhanUmum[index];
                    return _buildKeluhanCard(context, keluhan, index);
                  },
                ),
          _laporanService.ideSolusi.isEmpty
              ? _emptyCenter('Belum ada ide atau solusi')
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  itemCount: _laporanService.ideSolusi.length,
                  itemBuilder: (context, index) {
                    final ide = _laporanService.ideSolusi[index];
                    return _buildIdeCard(context, ide, index);
                  },
                ),
        ],
      ),
    );
  }

  Widget _emptyCenter(String text) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeluhanCard(BuildContext context, KeluhanUmumData keluhan, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!, width: 1),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, spreadRadius: 1),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            keluhan.isiKeluhan,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: primaryBlue),
          ),
          const SizedBox(height: 12),
          Text('Bagian Terkait', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey[600])),
          const SizedBox(height: 4),
          Text(keluhan.bagianTerkait, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          const SizedBox(height: 12),
          Text('Lokasi', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey[600])),
          const SizedBox(height: 4),
          Text(keluhan.lokasi, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          const SizedBox(height: 12),
          Text('Tanggal', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey[600])),
          const SizedBox(height: 4),
          Text(_formatDate(keluhan.tanggalKeluhan), style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                _laporanService.hapusKeluhan(index);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Keluhan dihapus')),
                );
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text(
                'Hapus',
                style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIdeCard(BuildContext context, IdeSolusiData ide, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!, width: 1),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, spreadRadius: 1),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(ide.ideSolusi, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: primaryBlue)),
          const SizedBox(height: 12),
          Text('Alasan Kepentingan', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey[600])),
          const SizedBox(height: 4),
          Text(ide.alasanKepentingan, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          const SizedBox(height: 12),
          Text('Area Penerapan', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey[600])),
          const SizedBox(height: 4),
          Text(ide.areaPenerapan, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          const SizedBox(height: 12),
          Text('Pihak Terbantu', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey[600])),
          const SizedBox(height: 4),
          Text(ide.pihakTerbantu, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          const SizedBox(height: 12),
          Text('Tanggal', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey[600])),
          const SizedBox(height: 4),
          Text(_formatDate(ide.tanggalIde), style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                _laporanService.hapusIdeSolusi(index);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Ide/Solusi dihapus')),
                );
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text(
                'Hapus',
                style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
