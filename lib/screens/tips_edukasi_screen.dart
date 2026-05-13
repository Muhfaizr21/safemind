import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../core/app_colors.dart';
import '../core/app_theme.dart';
import '../core/api_config.dart';
import 'artikel_detail_screen.dart';

class TipsEdukasiScreen extends StatefulWidget {
  const TipsEdukasiScreen({Key? key}) : super(key: key);

  @override
  _TipsEdukasiScreenState createState() => _TipsEdukasiScreenState();
}

class _TipsEdukasiScreenState extends State<TipsEdukasiScreen> {
  List _articles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchArticles();
  }

  Future<void> _fetchArticles() async {
    try {
      final response = await http.get(Uri.parse(ApiConfig.articles));
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        setState(() {
          _articles = data['data'];
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
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 52, left: 20, right: 20, bottom: 28),
            decoration: const BoxDecoration(
              gradient: AppTheme.primaryGradientVertical,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                    ),
                    child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
                  ),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tips & Edukasi', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 2),
                      Text('Panduan kesehatan mental untuk Anda', style: TextStyle(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // DAFTAR TIPS
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: _fetchArticles,
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                      itemCount: _articles.length,
                      itemBuilder: (context, index) {
                        final item = _articles[index];
                        return _TipsCard(
                          judul: item['title'] ?? '',
                          ringkasan: item['content'].toString().substring(0, item['content'].toString().length > 100 ? 100 : item['content'].toString().length) + '...',
                          kategori: item['category'] ?? 'Umum',
                          tanggal: '13 Mei 2026', // Bisa diformat dari created_at jika perlu
                          icon: _getIconForCategory(item['category']),
                          warna: _getColorForCategory(item['category']),
                          konten: item['content'] ?? '',
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
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

  Color _getColorForCategory(String? category) {
    switch (category?.toLowerCase()) {
      case 'psikologi': return const Color(0xFF8062DA);
      case 'sosial': return const Color(0xFF9575CD);
      case 'kesehatan': return const Color(0xFF7C3AED);
      default: return AppColors.gradientStart;
    }
  }
}

class _TipsCard extends StatelessWidget {
  final String judul;
  final String ringkasan;
  final String kategori;
  final String tanggal;
  final IconData icon;
  final Color warna;
  final String konten;

  const _TipsCard({
    required this.judul,
    required this.ringkasan,
    required this.kategori,
    required this.tanggal,
    required this.icon,
    required this.warna,
    required this.konten,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ArtikelDetailScreen(
              judul: judul,
              konten: konten,
              kategori: kategori,
              tanggal: tanggal,
              icon: icon,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(color: AppColors.gradientStart.withOpacity(0.08), blurRadius: 14, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 6,
              decoration: BoxDecoration(
                color: warna,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: AppColors.accentLight, borderRadius: BorderRadius.circular(20)),
                        child: Text(kategori, style: TextStyle(color: warna, fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 0.3)),
                      ),
                      const Spacer(),
                      const Icon(Icons.calendar_today_outlined, size: 11, color: AppColors.textMuted),
                      const SizedBox(width: 4),
                      Text(tanggal, style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [warna, warna.withOpacity(0.7)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(icon, color: Colors.white, size: 22),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(judul, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textPrimary, height: 1.4)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(ringkasan, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12.5, height: 1.6), maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text('Baca Selengkapnya', style: TextStyle(color: warna, fontSize: 12, fontWeight: FontWeight.w700)),
                          const SizedBox(width: 4),
                          Icon(Icons.arrow_forward_ios, size: 11, color: warna),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
