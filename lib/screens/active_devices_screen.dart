import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../core/app_colors.dart';
import '../core/api_config.dart';
import '../widgets/gradient_app_bar.dart';

class ActiveDevicesScreen extends StatefulWidget {
  const ActiveDevicesScreen({Key? key}) : super(key: key);

  @override
  _ActiveDevicesScreenState createState() => _ActiveDevicesScreenState();
}

class _ActiveDevicesScreenState extends State<ActiveDevicesScreen> {
  List _sessions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSessions();
  }

  Future<void> _fetchSessions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final username = prefs.getString('username');
      
      if (username == null) return;

      final response = await http.get(Uri.parse('${ApiConfig.sessions}/$username'));
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        setState(() {
          _sessions = data['data'];
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: const GradientAppBar(title: 'Perangkat Aktif'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _sessions.isEmpty
              ? _buildEmptyState()
              : RefreshIndicator(
                  onRefresh: _fetchSessions,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: _sessions.length,
                    itemBuilder: (context, index) {
                      final session = _sessions[index];
                      // Sederhanakan nama perangkat
                      String deviceName = session['device_name'] ?? 'Unknown Device';
                      if (deviceName.contains('Chrome')) deviceName = 'Google Chrome (Web)';
                      if (deviceName.contains('Android')) deviceName = 'Android Device';
                      if (deviceName.contains('iPhone')) deviceName = 'iPhone (iOS)';

                      return _buildDeviceCard(
                        deviceName,
                        index == 0 ? 'Sedang Digunakan' : 'Terakhir aktif: ${session['last_active']}',
                        session['ip_address'] ?? '0.0.0.0',
                        index == 0,
                      );
                    },
                  ),
                ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(child: Text('Tidak ada riwayat sesi'));
  }

  Widget _buildDeviceCard(String name, String status, String ip, bool isCurrent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isCurrent ? AppColors.gradientStart.withOpacity(0.3) : AppColors.cardBorder),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: AppColors.gradientStart.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(name.contains('Web') ? Icons.computer : Icons.smartphone, color: AppColors.gradientStart, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textPrimary)),
                const SizedBox(height: 4),
                Text(status, style: TextStyle(color: isCurrent ? Colors.green : AppColors.textSecondary, fontSize: 12, fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal)),
                const SizedBox(height: 2),
                Text('IP: $ip', style: const TextStyle(color: Colors.grey, fontSize: 11)),
              ],
            ),
          ),
          if (!isCurrent)
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.redAccent, size: 20),
              onPressed: () {},
            ),
        ],
      ),
    );
  }
}
