import 'package:flutter/material.dart';
import '../services/laporan_service.dart';

class IdeSolusiDetail extends StatefulWidget {
  const IdeSolusiDetail({super.key});

  @override
  State<IdeSolusiDetail> createState() => _IdeSolusiDetailState();
}

class _IdeSolusiDetailState extends State<IdeSolusiDetail> {
  static const Color primaryBlue = Color(0xFF0F5E8C);

  late LaporanService _laporanService;

  @override
  void initState() {
    super.initState();
    _laporanService = LaporanService();
    
    // Listen untuk perubahan di LaporanService
    _laporanService.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _laporanService.removeListener(() {});
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
          'Detail Ide dan Solusi',
          style: TextStyle(
            color: primaryBlue,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: _laporanService.ideSolusi.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inbox,
                    size: 64,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Belum ada ide atau solusi',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemCount: _laporanService.ideSolusi.length,
              itemBuilder: (context, index) {
                final ide = _laporanService.ideSolusi[index];
                return _buildIdeCard(ide, index);
              },
            ),
    );
  }

  Widget _buildIdeCard(IdeSolusiData ide, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
          // Ide/Solusi
          Text(
            ide.ideSolusi,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: primaryBlue,
            ),
          ),
          const SizedBox(height: 12),

          // Alasan Kepentingan
          Text(
            'Alasan Kepentingan',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            ide.alasanKepentingan,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 12),

          // Area Penerapan
          Text(
            'Area Penerapan',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            ide.areaPenerapan,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 12),

          // Pihak Terbantu
          Text(
            'Pihak Terbantu',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            ide.pihakTerbantu,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 12),

          // Tanggal
          Text(
            'Tanggal',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _formatDate(ide.tanggalIde),
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),

          // Delete Button
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Hapus',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
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
