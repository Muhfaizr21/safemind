import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_theme.dart';
import '../screens/home_screen.dart';
import '../screens/laporan_screen.dart';
import '../screens/edukasi_screen.dart';
import '../screens/akun_screen.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);
 
  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    LaporanScreen(),
    EdukasiScreen(),
    AkunScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: _pages[_currentIndex],

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.gradientStart.withOpacity(0.15),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            // Gradient indicator line at top
            Container(
              height: 3,
              decoration: const BoxDecoration(
                gradient: AppTheme.primaryGradient,
              ),
            ),
            BottomNavigationBar(
              currentIndex: _currentIndex,
              selectedItemColor: AppColors.gradientStart,
              unselectedItemColor: AppColors.textMuted,
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 11),
              unselectedLabelStyle: const TextStyle(fontSize: 11),
              elevation: 0,
              onTap: (index) {
                setState(() => _currentIndex = index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home_rounded),
                  label: 'Beranda',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.description_outlined),
                  activeIcon: Icon(Icons.description_rounded),
                  label: 'Laporan',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.school_outlined),
                  activeIcon: Icon(Icons.school_rounded),
                  label: 'Edukasi',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline_rounded),
                  activeIcon: Icon(Icons.person_rounded),
                  label: 'Akun',
                ),
              ],
            ),
          ],
        ),
      ),

      // Floating Chatbot button with gradient
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.gradientStart.withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () {
            Navigator.pushNamed(context, '/chatbot');
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.smart_toy_outlined, color: Colors.white, size: 22),
              Text(
                'Chat',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
