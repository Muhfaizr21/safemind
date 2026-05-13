import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../widgets/gradient_app_bar.dart';

class KeamananPrivasiScreen extends StatelessWidget {
  const KeamananPrivasiScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppBar(title: 'Keamanan & Privasi'),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Pengaturan Keamanan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          _buildSettingsTile(Icons.lock_outline, 'Ubah Kata Sandi'),
          _buildSettingsTile(Icons.fingerprint, 'Autentikasi Biometrik', trailing: Switch(value: true, onChanged: (v){}, activeColor: AppColors.gradientStart)),
          _buildSettingsTile(Icons.devices, 'Perangkat Aktif'),
          
          const SizedBox(height: 24),
          
          const Text(
            'Pengaturan Privasi',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          _buildSettingsTile(Icons.visibility_off_outlined, 'Sembunyikan Status Online', trailing: Switch(value: false, onChanged: (v){}, activeColor: AppColors.gradientStart)),
          _buildSettingsTile(Icons.policy_outlined, 'Kebijakan Privasi'),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(IconData icon, String title, {Widget? trailing}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.gradientStart),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        trailing: trailing ?? const Icon(Icons.chevron_right, color: AppColors.textSecondary),
        onTap: trailing == null ? () {} : null,
      ),
    );
  }
}
