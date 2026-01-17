import 'package:flutter/material.dart';
import 'profile.dart';
import 'laporan.dart';
import 'laporanfasilitas.dart';
import 'keluhanumum.dart';
import 'ajukan_ide_solusi.dart';
import '../widgets/custom_bottom_nav.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  static const Color primaryBlue = Color(0xFF0F5E8C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// BOTTOM NAVIGATION
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LaporanPage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          }
        },
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// SAPAAN
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Text(
                  'Halo bogor gantenk..',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              /// BANNER IMAGE
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    'assets/gedung.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              /// BUTTON 1
              _menuButton(title: 'Laporan Fasilitas'),

              /// BUTTON 2
              _menuButton(title: 'Keluhan Umum'),

              /// BUTTON 3
              _menuButton(title: 'Ajukan Ide/Solusi'),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  /// MENU BUTTON STYLE
  Widget _menuButton({required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: () {
            if (title == 'Laporan Fasilitas') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LaporanFasilitasPage(),
                ),
              );
            } else if (title == 'Keluhan Umum') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const KeluhanUmumPage(),
                ),
              );
            } else if (title == 'Ajukan Ide/Solusi') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AjukanIdeSolusiPage(),
                ),
              );
            }
            // TODO: Tambahkan navigasi untuk menu lainnya jika diperlukan
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryBlue,
            shape: const StadiumBorder(),
            elevation: 2,
          ),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
