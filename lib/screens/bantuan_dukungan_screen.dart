import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../widgets/gradient_app_bar.dart';
import '../widgets/gradient_button.dart';

class BantuanDukunganScreen extends StatelessWidget {
  const BantuanDukunganScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppBar(title: 'Bantuan & Dukungan'),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Panduan Penggunaan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          _buildExpansionTile('Cara membuat laporan baru?', 'Anda dapat membuat laporan dengan menekan tombol "Laporkan Sekarang" di halaman Beranda, lalu mengisi form yang disediakan dengan lengkap dan akurat.'),
          _buildExpansionTile('Bagaimana menghubungi psikolog?', 'Buka menu Psikolog, lalu pilih psikolog yang berstatus "Tersedia". Klik tombol "Hubungi via WhatsApp" untuk memulai sesi konsultasi.'),
          
          const SizedBox(height: 24),
          
          const Text(
            'Kirim Umpan Balik',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Tuliskan saran atau kendala yang Anda alami...',
              filled: true,
              fillColor: Theme.of(context).scaffoldBackgroundColor == AppColors.background ? Colors.white : Theme.of(context).cardColor,
              contentPadding: const EdgeInsets.all(16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.cardBorder),
              ),
            ),
          ),
          const SizedBox(height: 16),
          GradientButton(
            label: 'Kirim Umpan Balik',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Terima kasih atas masukan Anda')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExpansionTile(String title, String content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: ExpansionTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              content,
              style: const TextStyle(color: AppColors.textSecondary, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
