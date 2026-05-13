import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_theme.dart';
import '../widgets/app_logo.dart';
import '../widgets/gradient_button.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background decorative blob top right
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColors.gradientEnd.withOpacity(0.3),
                    AppColors.gradientStart.withOpacity(0.1),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 80,
            left: -40,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.gradientStart.withOpacity(0.08),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 36),

                // Logo + App Name
                const Center(child: AppLogo(size: 52, fontSize: 30)),

                const SizedBox(height: 20),

                // Title
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    'Lapor Kekerasan &\nKesehatan Mental Anda',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      height: 1.4,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Bersama Kita Peduli, Bersama Kita Pulih',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 28),

                // Illustration
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.asset(
                        'assets/images/ilustrasi.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: [
                      GradientButton(
                        label: 'Laporkan Sekarang',
                        onPressed: () {
                          Navigator.pushNamed(context, '/laporan');
                        },
                      ),

                      const SizedBox(height: 16),

                      Row(
                        children: [
                          const Expanded(
                              child: Divider(color: AppColors.cardBorder)),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: ShaderMask(
                                shaderCallback: (bounds) =>
                                    AppTheme.primaryGradient
                                        .createShader(bounds),
                                child: const Text(
                                  'Masuk / Daftar',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Expanded(
                              child: Divider(color: AppColors.cardBorder)),
                        ],
                      ),
                    ],
                  ),
                ),

                // Bottom gradient rectangle - estetik, di bawah tombol
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 6,
                  margin: const EdgeInsets.symmetric(horizontal: 60),
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
