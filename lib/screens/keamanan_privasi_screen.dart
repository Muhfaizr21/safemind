import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../core/app_colors.dart';
import '../core/api_config.dart';
import '../widgets/gradient_app_bar.dart';
import '../widgets/gradient_button.dart';

class KeamananPrivasiScreen extends StatefulWidget {
  const KeamananPrivasiScreen({Key? key}) : super(key: key);

  @override
  _KeamananPrivasiScreenState createState() => _KeamananPrivasiScreenState();
}

class _KeamananPrivasiScreenState extends State<KeamananPrivasiScreen> {
  bool _hideOnlineStatus = false;
  bool _biometricEnabled = true;

  void _showChangePasswordDialog() {
    final oldPassword = TextEditingController();
    final newPassword = TextEditingController();
    final confirmPassword = TextEditingController();
    bool isLoading = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Ubah Kata Sandi', style: TextStyle(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDialogField('Password Lama', oldPassword, true),
                const SizedBox(height: 12),
                _buildDialogField('Password Baru', newPassword, true),
                const SizedBox(height: 12),
                _buildDialogField('Konfirmasi Password Baru', confirmPassword, true),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
            if (isLoading)
              const CircularProgressIndicator()
            else
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.gradientStart, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                onPressed: () async {
                  if (newPassword.text != confirmPassword.text) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password baru tidak cocok')));
                    return;
                  }
                  
                  setDialogState(() => isLoading = true);
                  try {
                    final prefs = await SharedPreferences.getInstance();
                    final username = prefs.getString('username');
                    
                    final response = await http.post(
                      Uri.parse(ApiConfig.changePassword),
                      headers: {'Content-Type': 'application/json'},
                      body: jsonEncode({
                        'username': username,
                        'oldPassword': oldPassword.text,
                        'newPassword': newPassword.text,
                      }),
                    );

                    final data = jsonDecode(response.body);
                    if (response.statusCode == 200 && data['success'] == true) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password berhasil diubah'), backgroundColor: Colors.green));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data['message'] ?? 'Gagal mengubah password'), backgroundColor: Colors.red));
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Gagal terhubung ke server'), backgroundColor: Colors.red));
                  } finally {
                    setDialogState(() => isLoading = false);
                  }
                },
                child: const Text('Simpan', style: TextStyle(color: Colors.white)),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDialogField(String label, TextEditingController controller, bool isPassword) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppBar(title: 'Keamanan & Privasi'),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text('Pengaturan Keamanan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          const SizedBox(height: 12),
          _buildSettingsTile(Icons.lock_outline, 'Ubah Kata Sandi', onTap: _showChangePasswordDialog),
          _buildSettingsTile(Icons.fingerprint, 'Autentikasi Biometrik', 
            trailing: Switch(value: _biometricEnabled, onChanged: (v) => setState(() => _biometricEnabled = v), activeColor: AppColors.gradientStart)),
          _buildSettingsTile(Icons.devices, 'Perangkat Aktif', onTap: () {}),
          
          const SizedBox(height: 24),
          
          const Text('Pengaturan Privasi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          const SizedBox(height: 12),
          _buildSettingsTile(Icons.visibility_off_outlined, 'Sembunyikan Status Online', 
            trailing: Switch(value: _hideOnlineStatus, onChanged: (v) => setState(() => _hideOnlineStatus = v), activeColor: AppColors.gradientStart)),
          _buildSettingsTile(Icons.policy_outlined, 'Kebijakan Privasi', onTap: () {}),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(IconData icon, String title, {Widget? trailing, VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.cardBorder)),
      child: ListTile(
        leading: Icon(icon, color: AppColors.gradientStart),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
        trailing: trailing ?? const Icon(Icons.chevron_right, color: AppColors.textSecondary),
        onTap: onTap,
      ),
    );
  }
}
