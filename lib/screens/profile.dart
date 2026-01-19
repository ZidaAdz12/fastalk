// lib/screens/profile.dart
import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const Color primaryBlue = Color(0xFF0F5E8C);

  int _currentIndex = 2;

  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _genderController;

  late final FocusNode _usernameFocus;
  late final FocusNode _emailFocus;
  late final FocusNode _phoneFocus;
  late final FocusNode _genderFocus;

  @override
  void initState() {
    super.initState();

    _usernameController = TextEditingController(text: 'Bogor Gantenk');
    _emailController = TextEditingController(text: 'zidanzavian7405@gmail.com');
    _phoneController = TextEditingController(text: '08 kapan kapan kita ke dupan');
    _genderController = TextEditingController(text: 'Tebak');

    _usernameFocus = FocusNode();
    _emailFocus = FocusNode();
    _phoneFocus = FocusNode();
    _genderFocus = FocusNode();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _genderController.dispose();

    _usernameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _genderFocus.dispose();

    super.dispose();
  }

  String get _username {
    final v = _usernameController.text.trim();
    return v.isEmpty ? 'User' : v;
  }

  void _safeLogout() {
    try {
      Navigator.pushNamedAndRemoveUntil(context, '/auth', (route) => false);
    } catch (_) {
      Navigator.pushNamedAndRemoveUntil(context, '/signin', (route) => false);
    }
  }

  Future<void> _confirmLogout() async {
    final bool? ok = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Keluar'),
          content: const Text('Yakin ingin keluar?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );

    if (ok == true && mounted) {
      _safeLogout();
    }
  }

  void _focus(FocusNode node) {
    FocusScope.of(context).requestFocus(node);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          if (index == 0) {
            Navigator.pop(context);
          }
        },
      ),

      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // TITLE
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
                      Container(width: 60, height: 3, color: primaryBlue),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // AVATAR
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[400],
                  ),
                  child: const Icon(Icons.person, size: 60, color: Colors.white),
                ),

                const SizedBox(height: 18),

                // USERNAME EDIT (langsung ketik)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _usernameController,
                          focusNode: _usernameFocus,
                          textAlign: TextAlign.center,
                          maxLength: 30,
                          decoration: const InputDecoration(
                            counterText: '',
                            border: InputBorder.none,
                            hintText: 'Username',
                          ),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: primaryBlue,
                          ),
                          onChanged: (_) => setState(() {}),
                          textInputAction: TextInputAction.next,
                          onSubmitted: (_) => _focus(_emailFocus),
                        ),
                      ),
                      IconButton(
                        onPressed: () => _focus(_usernameFocus),
                        icon: const Icon(Icons.edit, color: primaryBlue, size: 20),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // EMAIL
                _editableInfoField(
                  icon: Icons.email,
                  controller: _emailController,
                  focusNode: _emailFocus,
                  hint: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) => _focus(_phoneFocus),
                ),

                const SizedBox(height: 16),

                // PHONE
                _editableInfoField(
                  icon: Icons.phone,
                  controller: _phoneController,
                  focusNode: _phoneFocus,
                  hint: 'Nomor HP',
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) => _focus(_genderFocus),
                ),

                const SizedBox(height: 16),

                // GENDER
                _editableInfoField(
                  icon: Icons.person,
                  controller: _genderController,
                  focusNode: _genderFocus,
                  hint: 'Gender',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => FocusScope.of(context).unfocus(),
                ),

                const SizedBox(height: 32),

                // LOGOUT
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _confirmLogout,
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

                const SizedBox(height: 12),

                // Optional: tampilkan preview username yang dipakai
                Text(
                  'Login sebagai: $_username',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _editableInfoField({
    required IconData icon,
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hint,
    required TextInputType keyboardType,
    required TextInputAction textInputAction,
    required ValueChanged<String> onSubmitted,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: primaryBlue, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, color: primaryBlue, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                keyboardType: keyboardType,
                textInputAction: textInputAction,
                decoration: InputDecoration(
                  hintText: hint,
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: primaryBlue.withOpacity(0.6)),
                ),
                style: const TextStyle(
                  color: primaryBlue,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                onSubmitted: onSubmitted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
