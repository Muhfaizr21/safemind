import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../widgets/gradient_app_bar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppBar(title: 'Kebijakan Privasi'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('1. Pengumpulan Data', 
              'SafeMind mengumpulkan data berupa username, email, dan nomor telepon untuk keperluan identitas akun dan layanan bantuan.'),
            _buildSection('2. Keamanan Data', 
              'Kami menggunakan enkripsi standar industri untuk melindungi informasi pribadi Anda dari akses yang tidak sah.'),
            _buildSection('3. Kerahasiaan Laporan', 
              'Setiap laporan yang Anda kirimkan bersifat rahasia dan hanya dapat diakses oleh tim profesional yang berwenang.'),
            _buildSection('4. Penggunaan Layanan', 
              'Dengan menggunakan SafeMind, Anda setuju bahwa data Anda diproses untuk meningkatkan kualitas layanan kesehatan mental kami.'),
            const SizedBox(height: 40),
            const Center(
              child: Text(
                'Terakhir diperbarui: 13 Mei 2026',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.5),
          ),
        ],
      ),
    );
  }
}
