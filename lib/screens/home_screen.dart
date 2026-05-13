import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../core/app_colors.dart';
import '../core/app_theme.dart';
import '../core/api_config.dart';
import 'artikel_detail_screen.dart';
import 'tips_edukasi_screen.dart';
import 'notifications_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _displayName = 'Pengguna SafeMind';
  Map<String, dynamic>? _latestReport;
  List _articles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final username = prefs.getString('username') ?? '';
      final name = prefs.getString('display_name') ?? 'Pengguna SafeMind';

      // Fetch Reports & Articles
      final reportRes = await http.get(Uri.parse('${ApiConfig.reports}/$username'));
      final articleRes = await http.get(Uri.parse(ApiConfig.articles));

      if (mounted) {
        setState(() {
          _displayName = name;
          
          final reportData = jsonDecode(reportRes.body);
          if (reportRes.statusCode == 200 && reportData['success'] == true && (reportData['data'] as List).isNotEmpty) {
            _latestReport = reportData['data'][0];
          }

          final articleData = jsonDecode(articleRes.body);
          if (articleRes.statusCode == 200 && articleData['success'] == true) {
            _articles = articleData['data'];
          }
          
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        onRefresh: _loadDashboardData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildMenuGrid(context),
              const SizedBox(height: 24),
              _buildReportStatus(),
              const SizedBox(height: 24),
              _buildArticlesSection(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 52, left: 20, right: 20, bottom: 28),
      decoration: const BoxDecoration(
        gradient: AppTheme.primaryGradientVertical,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Selamat Datang', style: TextStyle(color: Colors.white70, fontSize: 13)),
              const SizedBox(height: 2),
              Text(_displayName, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          _buildNotificationBadge(context),
        ],
      ),
    );
  }

  Widget _buildNotificationBadge(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen())),
      child: Container(
        width: 46, height: 46,
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
        child: const Icon(Icons.notifications_outlined, color: Colors.white, size: 24),
      ),
    );
  }

  Widget _buildMenuGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _menuItem(context, Icons.report_problem_outlined, 'Laporkan\nKasus', () => Navigator.pushNamed(context, '/laporan')),
          const SizedBox(width: 10),
          _menuItem(context, Icons.headset_mic_outlined, 'Konsultasi\nPsikolog', () => Navigator.pushNamed(context, '/psikolog')),
          const SizedBox(width: 10),
          _menuItem(context, Icons.lightbulb_outline_rounded, 'Tips &\nEdukasi', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TipsEdukasiScreen()))),
          const SizedBox(width: 10),
          _menuItem(context, Icons.emergency_outlined, 'Layanan\nDarurat', () {}),
        ],
      ),
    );
  }

  Widget _buildReportStatus() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Status Laporan Anda', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: AppColors.gradientStart.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, 4))],
            ),
            child: _latestReport == null 
              ? const Center(child: Text('Belum ada laporan terbaru', style: TextStyle(color: AppColors.textMuted, fontSize: 12)))
              : Row(
                  children: [
                    Container(
                      width: 44, height: 44,
                      decoration: BoxDecoration(gradient: AppTheme.primaryGradient, borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.receipt_long_outlined, color: Colors.white, size: 22),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Laporan #${_latestReport!['id']} ${_latestReport!['category']}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary, fontSize: 13)),
                          const SizedBox(height: 3),
                          const Text('Kami sedang meninjau laporan Anda', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                        ],
                      ),
                    ),
                    _buildStatusBadge('Proses'),
                  ],
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: const Color(0xFFFFF3E0), borderRadius: BorderRadius.circular(20)),
      child: Text(status, style: const TextStyle(color: Color(0xFFF57C00), fontSize: 10, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildArticlesSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Artikel & Tips', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
              Text('Geser untuk lebih', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            ],
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 220,
          child: _articles.isEmpty 
            ? const Center(child: Text('Memuat artikel...'))
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 16, right: 8),
                itemCount: _articles.length,
                itemBuilder: (context, index) {
                  final item = _articles[index];
                  return _ArtikelCardHorizontal(
                    title: item['title'] ?? '',
                    ringkasan: item['content'].toString().substring(0, item['content'].toString().length > 60 ? 60 : item['content'].toString().length) + '...',
                    kategori: item['category'] ?? 'Edukasi',
                    tanggal: 'Baru saja',
                    icon: _getIconForCategory(item['category']),
                    gradientStart: _getGradientForCategory(item['category'])[0],
                    gradientEnd: _getGradientForCategory(item['category'])[1],
                    konten: item['content'] ?? '',
                  );
                },
              ),
        ),
      ],
    );
  }

  IconData _getIconForCategory(String? category) {
    switch (category?.toLowerCase()) {
      case 'psikologi': return Icons.psychology_outlined;
      case 'sosial': return Icons.group_outlined;
      case 'kesehatan': return Icons.spa_outlined;
      default: return Icons.article_outlined;
    }
  }

  List<Color> _getGradientForCategory(String? category) {
    switch (category?.toLowerCase()) {
      case 'psikologi': return [const Color(0xFF8062DA), const Color(0xFFA87FD8)];
      case 'sosial': return [const Color(0xFF7C3AED), const Color(0xFF9575CD)];
      case 'kesehatan': return [const Color(0xFF9575CD), const Color(0xFFCE93D8)];
      default: return [const Color(0xFF6A5ACD), const Color(0xFF9575CD)];
    }
  }

  Widget _menuItem(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: AppColors.gradientStart.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 44, height: 44, decoration: BoxDecoration(gradient: AppTheme.primaryGradient, borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: Colors.white, size: 22)),
              const SizedBox(height: 8),
              Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10, color: AppColors.textPrimary, fontWeight: FontWeight.w600, height: 1.3)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ArtikelCardHorizontal extends StatelessWidget {
  final String title;
  final String ringkasan;
  final String kategori;
  final String tanggal;
  final IconData icon;
  final Color gradientStart;
  final Color gradientEnd;
  final String konten;

  const _ArtikelCardHorizontal({required this.title, required this.ringkasan, required this.kategori, required this.tanggal, required this.icon, required this.gradientStart, required this.gradientEnd, required this.konten});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => ArtikelDetailScreen(judul: title, konten: konten, kategori: kategori, tanggal: tanggal, icon: icon)));
      },
      child: Container(
        width: 220, margin: const EdgeInsets.only(right: 14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: gradientStart.withOpacity(0.14), blurRadius: 16, offset: const Offset(0, 6))]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 90,
              decoration: BoxDecoration(gradient: LinearGradient(colors: [gradientStart, gradientEnd], begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
              child: Stack(children: [
                Positioned(right: -20, top: -20, child: Container(width: 100, height: 100, decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), shape: BoxShape.circle))),
                Positioned(left: 14, bottom: 14, child: Container(width: 40, height: 40, decoration: BoxDecoration(color: Colors.white.withOpacity(0.25), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: Colors.white, size: 22))),
                Positioned(right: 12, top: 12, child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: Colors.white.withOpacity(0.25), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.white.withOpacity(0.35))), child: const Text('Artikel', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 0.3)))),
              ]),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.textPrimary, height: 1.35), maxLines: 2, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 6),
                    Text(ringkasan, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11, height: 1.5), maxLines: 2, overflow: TextOverflow.ellipsis),
                    const Spacer(),
                    Row(children: [
                      const Icon(Icons.access_time_outlined, size: 11, color: AppColors.textMuted),
                      const SizedBox(width: 3),
                      Text(tanggal, style: const TextStyle(color: AppColors.textMuted, fontSize: 10)),
                      const Spacer(),
                      Text('Baca', style: TextStyle(color: gradientStart, fontSize: 11, fontWeight: FontWeight.w700)),
                      const SizedBox(width: 2),
                      Icon(Icons.arrow_forward_ios, size: 9, color: gradientStart),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
