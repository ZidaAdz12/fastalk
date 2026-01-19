import 'package:flutter/material.dart';
import '../services/laporan_service.dart';
import 'ide_solusi_detail.dart';

class AjukanIdeSolusiPage extends StatefulWidget {
  const AjukanIdeSolusiPage({super.key});

  @override
  State<AjukanIdeSolusiPage> createState() => _AjukanIdeSolusiPageState();
}

class _AjukanIdeSolusiPageState extends State<AjukanIdeSolusiPage> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers untuk form fields
  final _ideSolusiController = TextEditingController();
  final _alasanKepentinganController = TextEditingController();
  final _areaPenerapanController = TextEditingController();
  final _pihakTerbantuController = TextEditingController();
  
  late LaporanService _laporanService;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _laporanService = LaporanService();
  }

  @override
  void dispose() {
    _ideSolusiController.dispose();
    _alasanKepentinganController.dispose();
    _areaPenerapanController.dispose();
    _pihakTerbantuController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      // Tambahkan ide/solusi ke service
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          _laporanService.tambahIdeSolusi(
            IdeSolusiData(
              ideSolusi: _ideSolusiController.text,
              alasanKepentingan: _alasanKepentinganController.text,
              areaPenerapan: _areaPenerapanController.text,
              pihakTerbantu: _pihakTerbantuController.text,
              tanggalIde: DateTime.now(),
            ),
          );

          setState(() {
            _isSubmitting = false;
          });
          
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Ide/Solusi berhasil dikirim')),
          );
          
          // Clear form
          _ideSolusiController.clear();
          _alasanKepentinganController.clear();
          _areaPenerapanController.clear();
          _pihakTerbantuController.clear();
          
          // Kembali ke halaman sebelumnya
          Navigator.pop(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Ajukan Ide/Solusi',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ide/Solusi
                const Text(
                  'Ide/Solusi',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _ideSolusiController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Ketik sesuatu...',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ide/Solusi tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Alasan Kepentingan
                const Text(
                  'Alasan Kepentingan',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _alasanKepentinganController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Ketik sesuatu...',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Alasan kepentingan tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Area Penerapan
                const Text(
                  'Area Penerapan',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _areaPenerapanController,
                  decoration: InputDecoration(
                    hintText: 'Ketik sesuatu...',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Area penerapan tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Pihak Terbantu
                const Text(
                  'Pihak Terbantu',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _pihakTerbantuController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Ketik sesuatu...',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Pihak terbantu tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isSubmitting ? null : _handleSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      disabledBackgroundColor: Colors.blue.withOpacity(0.5),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
