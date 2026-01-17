import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  static const Color primaryBlue = Color(0xFF0F5E8C);

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          elevation: 0,
          selectedItemColor: primaryBlue,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/home.png',
                width: 24,
                height: 24,
                color: currentIndex == 0 ? primaryBlue : Colors.grey,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/laporan.png',
                width: 24,
                height: 24,
                color: currentIndex == 1 ? primaryBlue : Colors.grey,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/profile.png',
                width: 24,
                height: 24,
                color: currentIndex == 2 ? primaryBlue : Colors.grey,
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
