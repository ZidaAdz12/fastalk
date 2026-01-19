import 'package:flutter/material.dart';

import 'auth/auth_page.dart';
import 'auth/signin.dart';
import 'auth/signup.dart';
import 'auth/splashscreen.dart';
import 'screens/home.dart';
import 'screens/laporanfasilitas.dart';
import 'screens/keluhanumum.dart';
import 'screens/ajukan_ide_solusi.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FastalkApp());
}

class FastalkApp extends StatelessWidget {
  const FastalkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fastalk',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/auth': (context) => const AuthPage(),
        '/signin': (context) => const SignInPage(),
        '/signup': (context) => const SignUpPage(),
        '/home': (context) => const HomePage(),
        '/laporanfasilitas': (context) => const LaporanFasilitasPage(),
        '/keluhanumum': (context) => const KeluhanUmumPage(),
        '/ajukanidsolusi': (context) => const AjukanIdeSolusiPage(),
      },
    );
  }
}
