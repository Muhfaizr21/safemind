import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/app_colors.dart';
import 'screens/splash_screen.dart';
import 'screens/landing_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'widgets/bottom_navbar.dart';
import 'screens/chatbot_screen.dart';
import 'screens/laporan_screen.dart';
import 'screens/psikolog_screen.dart';
import 'screens/tips_edukasi_screen.dart';
import 'screens/edit_profil_screen.dart';
import 'screens/profil_identitas_screen.dart';
import 'screens/riwayat_laporan_screen.dart';
import 'screens/keamanan_privasi_screen.dart';
import 'screens/personalisasi_screen.dart';
import 'screens/bantuan_dukungan_screen.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SafeMind App',
          themeMode: currentMode,
          theme: ThemeData(
            primaryColor: AppColors.gradientStart,
            scaffoldBackgroundColor: AppColors.background,
            colorScheme: const ColorScheme.light(
              primary: AppColors.gradientStart,
              secondary: AppColors.gradientEnd,
            ),
            fontFamily: 'Roboto',
            appBarTheme: const AppBarTheme(
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle.light,
            ),
          ),
          darkTheme: ThemeData.dark().copyWith(
            primaryColor: AppColors.gradientStart,
            scaffoldBackgroundColor: const Color(0xFF121212),
            colorScheme: const ColorScheme.dark(
              primary: AppColors.gradientStart,
              secondary: AppColors.gradientEnd,
            ),
            appBarTheme: const AppBarTheme(
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle.light,
              backgroundColor: Color(0xFF1E1E1E),
            ),
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => SplashScreen(),
            '/landing': (context) => const LandingScreen(),
            '/login': (context) => const LoginScreen(),
            '/register': (context) => const RegisterScreen(),
            '/home': (context) => const BottomNavbar(),
            '/laporan': (context) => const LaporanScreen(),
            '/chatbot': (context) => const ChatbotScreen(),
            '/psikolog': (context) => const PsikologScreen(),
            '/tips-edukasi': (context) => TipsEdukasiScreen(),
            '/edit-profil': (context) => const EditProfilScreen(),
            '/profil-identitas': (context) => const ProfilIdentitasScreen(),
            '/riwayat-laporan': (context) => const RiwayatLaporanScreen(),
            '/keamanan-privasi': (context) => const KeamananPrivasiScreen(),
            '/personalisasi': (context) => const PersonalisasiScreen(),
            '/bantuan-dukungan': (context) => const BantuanDukunganScreen(),
          },
        );
      },
    );
  }
}

