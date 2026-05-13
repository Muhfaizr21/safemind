import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../widgets/gradient_app_bar.dart';

class ProfilIdentitasScreen extends StatelessWidget {
  const ProfilIdentitasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppBar(title: 'Profil & Identitas'),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildInfoItem('Nama Pengguna', 'Erwan Kurniawan'),
          _buildInfoItem('ID Pengguna', 'SM-2026-9876'),
          _buildInfoItem('Email', 'erwan@example.com'),
          _buildInfoItem('Nomor Telepon', '+62 812 3456 7890'),
          _buildInfoItem('Tanggal Bergabung', '1 Januari 2026'),
          _buildInfoItem('Status Akun', 'Aktif Terverifikasi'),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
