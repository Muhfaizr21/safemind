import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/app_colors.dart';
import '../../core/app_theme.dart';
import '../../core/api_config.dart';
import 'reports_screen.dart';
import 'users_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  _AdminDashboardScreenState createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _selectedIndex = 0;
  
  // Daftar halaman yang akan ditampilkan
  final List<Widget> _pages = [
    const DashboardHomeContent(),
    const ReportsScreen(),
    const UsersScreen(),
    const Center(child: Text('Halaman Profil Admin (Segera)')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 85,
      padding: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
        color: Color(0xFFDCE2F3),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        border: Border(top: BorderSide(color: Color(0xFFC3C5D7), width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, Icons.home, 'Beranda'),
          _buildNavItem(1, Icons.warning_amber_outlined, 'Laporan'),
          _buildNavItem(2, Icons.person_search_outlined, 'Pengguna'),
          _buildNavItem(3, Icons.account_circle_outlined, 'Profil'),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    bool isActive = _selectedIndex == index;
    return InkWell(
      onTap: () => setState(() => _selectedIndex = index),
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF96F6C8) : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isActive ? const Color(0xFF00734F) : AppColors.textSecondary, size: 24),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: isActive ? const Color(0xFF00734F) : AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

// Konten Utama Dashboard (Home)
class DashboardHomeContent extends StatefulWidget {
  const DashboardHomeContent({Key? key}) : super(key: key);

  @override
  _DashboardHomeContentState createState() => _DashboardHomeContentState();
}

class _DashboardHomeContentState extends State<DashboardHomeContent> {
  Map<String, dynamic> _stats = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchStats();
  }

  Future<void> _fetchStats() async {
    try {
      final response = await http.get(Uri.parse(ApiConfig.adminStats));
      if (response.statusCode == 200) {
        setState(() {
          _stats = jsonDecode(response.body)['data'];
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching stats: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          pinned: true,
          expandedHeight: 80,
          backgroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('SafeMind Admin', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18)),
                IconButton(icon: const Icon(Icons.notifications_outlined, color: AppColors.textPrimary), onPressed: () {}),
              ],
            ),
          ),
          elevation: 0.5,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWelcomeHeader(),
                const SizedBox(height: 25),
                _buildStatCards(),
                const SizedBox(height: 30),
                const Text('Grafik Pertumbuhan Pengguna', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                _buildGrowthChart(),
                const SizedBox(height: 30),
                _buildCategoryProgress(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Selamat Datang, Admin!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
        const SizedBox(height: 4),
        Text('Pantau kondisi sistem secara real-time di sini.', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
      ],
    );
  }

  Widget _buildStatCards() {
    return Column(
      children: [
        _buildMetricCard('TOTAL LAPORAN', _stats['totalReports']?.toString() ?? '0', '+12%', Colors.red),
        const SizedBox(height: 15),
        _buildMetricCard('USER ONLINE', _stats['totalUsers']?.toString() ?? '0', 'Stabil', Colors.blue),
        const SizedBox(height: 15),
        _buildMetricCard('PSIKOLOG AKTIF', _stats['totalPsychologists']?.toString() ?? '0', '45 Total', Colors.green),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, String sub, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFDCE2F3)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(Icons.analytics_outlined, color: color),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.2)),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
            child: Text(sub, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildGrowthChart() {
    List<dynamic> growthData = _stats['userGrowth'] ?? [];
    return Container(
      height: 200,
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFDCE2F3)),
      ),
      child: growthData.isEmpty 
          ? const Center(child: Text('Data tidak tersedia'))
          : CustomPaint(
              painter: GrowthPainter(growthData.map((e) => (e['count'] as num).toDouble()).toList()),
            ),
    );
  }

  Widget _buildCategoryProgress() {
    List<dynamic> categories = _stats['categories'] ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Kategori Laporan Terbanyak', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        ...categories.map((cat) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(cat['category'] ?? 'Lainnya', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                  Text('${cat['count']} Laporan', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: (cat['count'] as num) / 20, // Simulasi max 20
                  backgroundColor: const Color(0xFFF0F3FF),
                  color: AppColors.gradientStart,
                  minHeight: 8,
                ),
              ),
            ],
          ),
        )).toList(),
      ],
    );
  }
}

// Painter untuk Grafik
class GrowthPainter extends CustomPainter {
  final List<double> data;
  GrowthPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;
    
    final paint = Paint()
      ..color = AppColors.gradientStart
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final path = Path();
    double stepX = size.width / (data.length - 1);
    double maxVal = data.reduce((a, b) => a > b ? a : b);
    if (maxVal == 0) maxVal = 1;

    path.moveTo(0, size.height - (data[0] / maxVal * size.height));

    for (int i = 1; i < data.length; i++) {
      path.lineTo(i * stepX, size.height - (data[i] / maxVal * size.height));
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
