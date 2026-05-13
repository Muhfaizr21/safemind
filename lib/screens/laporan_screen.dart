import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_theme.dart';
import '../widgets/laporan_form.dart';

class LaporanScreen extends StatelessWidget {
  const LaporanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // HEADER GRADIENT
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
                top: 52, left: 16, right: 16, bottom: 28),
            decoration: const BoxDecoration(
              gradient: AppTheme.primaryGradientVertical,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: double.infinity), // ensure full width
                const Text(
                  'Buat Laporan',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Ceritakan apa yang Anda alami dengan aman',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          // Form body
          Expanded(child: LaporanForm()),
        ],
      ),
    );
  }
}
