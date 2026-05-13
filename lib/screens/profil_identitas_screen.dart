import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/app_colors.dart';
import '../widgets/gradient_app_bar.dart';

class ProfilIdentitasScreen extends StatefulWidget {
  const ProfilIdentitasScreen({Key? key}) : super(key: key);

  @override
  _ProfilIdentitasScreenState createState() => _ProfilIdentitasScreenState();
}

class _ProfilIdentitasScreenState extends State<ProfilIdentitasScreen> {
  String _username = '...';
  String _email = '...';
  String _phone = '...';
  String _createdAt = '...';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'Guest';
      _email = prefs.getString('email') ?? 'erwan@example.com';
      _phone = prefs.getString('phone') ?? '+62 812 XXXX XXXX';
      
      // Ambil dan format tanggal
      String rawDate = prefs.getString('created_at') ?? '2026-05-13';
      try {
        DateTime dt = DateTime.parse(rawDate);
        _createdAt = "${dt.day} ${_monthName(dt.month)} ${dt.year}";
      } catch (e) {
        _createdAt = rawDate;
      }
    });
  }

  String _monthName(int month) {
    const months = ['', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];
    return months[month];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppBar(title: 'Profil & Identitas'),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildInfoItem('Nama Pengguna', _username),
          _buildInfoItem('ID Pengguna', 'SM-2026-${_username.hashCode.toString().substring(0, 4)}'),
          _buildInfoItem('Email', _email),
          _buildInfoItem('Nomor Telepon', _phone),
          _buildInfoItem('Tanggal Bergabung', _createdAt),
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
