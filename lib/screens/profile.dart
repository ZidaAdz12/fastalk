import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 2;

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
          if (index == 0) {
            Navigator.pop(context);
          }
        },
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// PROFILE TITLE WITH UNDERLINE
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    const Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: primaryBlue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 60,
                      height: 3,
                      color: primaryBlue,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// PROFILE PICTURE
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[400],
                ),
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 24),

              /// NAME WITH EDIT ICON
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Nabilah',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: primaryBlue,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.edit,
                      color: primaryBlue,
                      size: 20,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              /// EMAIL FIELD
              _infoField(
                icon: Icons.email,
                text: 'nabila.putri@gmail.com',
              ),

              const SizedBox(height: 16),

              /// PHONE FIELD
              _infoField(
                icon: Icons.phone,
                text: '08123456789',
              ),

              const SizedBox(height: 16),

              /// GENDER FIELD
              _infoField(
                icon: Icons.person,
                text: 'Perempuan',
              ),

              const SizedBox(height: 40),

              /// LOGOUT BUTTON
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryBlue,
                      shape: const StadiumBorder(),
                      elevation: 2,
                    ),
                    child: const Text(
                      'Keluar?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  /// INFO FIELD WIDGET
  Widget _infoField({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: primaryBlue, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, color: primaryBlue, size: 20),
            const SizedBox(width: 12),
            Text(
              text,
              style: const TextStyle(
                color: primaryBlue,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
