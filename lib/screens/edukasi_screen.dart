import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../core/app_colors.dart';
import '../core/app_theme.dart';
import '../core/api_config.dart';
import 'artikel_detail_screen.dart';

class EdukasiScreen extends StatefulWidget {
  const EdukasiScreen({Key? key}) : super(key: key);

  @override
  _EdukasiScreenState createState() => _EdukasiScreenState();
}

class _EdukasiScreenState extends State<EdukasiScreen> {
  List _articles = [];
  List _videos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final articleRes = await http.get(Uri.parse(ApiConfig.articles));
      final videoRes = await http.get(Uri.parse(ApiConfig.videos));
      
      final articleData = jsonDecode(articleRes.body);
      final videoData = jsonDecode(videoRes.body);

      if (articleRes.statusCode == 200 && articleData['success'] == true) {
        _articles = articleData['data'];
      }
      
      if (videoRes.statusCode == 200 && videoData['success'] == true) {
        _videos = videoData['data'];
      }

      setState(() => _isLoading = false);
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _fetchArticles() async => _fetchData(); // Alias for RefreshIndicator

  Future<void> _launchVideo(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0FF),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 52, left: 20, right: 20, bottom: 28),
            decoration: const BoxDecoration(
              gradient: AppTheme.primaryGradientVertical,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Edukasi & Dukungan', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('Kami menjaga kerahasiaan data Anda', textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _fetchArticles,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const Text('Artikel Pilihan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                  const SizedBox(height: 12),
                  
                  if (_isLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (_articles.isEmpty)
                    const Center(child: Text('Belum ada artikel'))
                  else
                    ..._articles.map((item) {
                      return _ArtikelCard(
                        judul: item['title'] ?? '',
                        deskripsi: item['content'].toString().substring(0, item['content'].toString().length > 80 ? 80 : item['content'].toString().length) + '...',
                        kategori: item['category'] ?? 'Umum',
                        tanggal: '13 Mei 2026',
                        icon: _getIconForCategory(item['category']),
                        konten: item['content'] ?? '',
                      );
                    }).toList(),

                  const SizedBox(height: 20),
                  const Text('Video Edukasi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                  const SizedBox(height: 10),
                  
                  if (_isLoading)
                    const SizedBox()
                  else if (_videos.isEmpty)
                    const Center(child: Text('Belum ada video'))
                  else
                    ..._videos.map((video) {
                      return _VideoCard(
                        judul: video['title'] ?? '', 
                        durasi: video['duration'] ?? '', 
                        onTap: () => _launchVideo(video['url'] ?? '')
                      );
                    }).toList(),

                  const SizedBox(height: 20),
                  _buildHelpCard(),
                  const SizedBox(height: 32),
                ],
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

  Widget _buildHelpCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: AppColors.gradientStart.withOpacity(0.25), blurRadius: 16, offset: const Offset(0, 6))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Butuh Bantuan Segera?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
          const SizedBox(height: 4),
          const Text('Tim psikolog profesional kami siap membantu Anda', style: TextStyle(fontSize: 12, color: Colors.white70, height: 1.5)),
          const SizedBox(height: 6),
          const Text('+62 885 111 056', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 0.5)),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppColors.gradientStart, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), elevation: 0),
              onPressed: () => Navigator.pushNamed(context, '/psikolog'),
              child: const Text('Hubungi Sekarang', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ),
          ),
        ],
      ),
    );
  }
}

class _ArtikelCard extends StatelessWidget {
  final String judul;
  final String deskripsi;
  final String kategori;
  final String tanggal;
  final IconData icon;
  final String konten;

  const _ArtikelCard({required this.judul, required this.deskripsi, required this.kategori, required this.tanggal, required this.icon, required this.konten});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), boxShadow: [BoxShadow(color: AppColors.gradientStart.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, 4))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 5, decoration: const BoxDecoration(gradient: AppTheme.primaryGradient, borderRadius: BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18)))),
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
                      child: Text(kategori, style: const TextStyle(color: AppColors.gradientStart, fontSize: 10, fontWeight: FontWeight.w700)),
                    ),
                    const Spacer(),
                    const Icon(Icons.calendar_today_outlined, size: 11, color: AppColors.textMuted),
                    const SizedBox(width: 4),
                    Text(tanggal, style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(gradient: AppTheme.primaryGradient, borderRadius: BorderRadius.circular(12)),
                      child: Icon(icon, color: Colors.white, size: 22),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(judul, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textPrimary, height: 1.35)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(deskripsi, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.55)),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.gradientStart, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 0),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => ArtikelDetailScreen(judul: judul, konten: konten, kategori: kategori, tanggal: tanggal, icon: icon)));
                    },
                    child: const Text('Baca Selengkapnya', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _VideoCard extends StatelessWidget {
  final String judul;
  final String durasi;
  final VoidCallback onTap;
  const _VideoCard({required this.judul, required this.durasi, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.cardBorder, width: 1), boxShadow: [BoxShadow(color: AppColors.gradientStart.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 3))]),
        child: Row(
          children: [
            Container(
              width: 72,
              height: 56,
              decoration: BoxDecoration(gradient: AppTheme.primaryGradient, borderRadius: BorderRadius.circular(12)),
              child: Stack(alignment: Alignment.center, children: [
                Container(width: 34, height: 34, decoration: BoxDecoration(color: Colors.white.withOpacity(0.25), shape: BoxShape.circle)),
                const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 26),
              ]),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(judul, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5, color: AppColors.textPrimary, height: 1.35)),
                  const SizedBox(height: 4),
                  Row(children: [
                    const Icon(Icons.access_time_outlined, size: 12, color: AppColors.textMuted),
                    const SizedBox(width: 3),
                    Text(durasi, style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
                    const SizedBox(width: 10),
                    const Icon(Icons.play_circle_outline, size: 12, color: AppColors.gradientStart),
                    const SizedBox(width: 3),
                    const Text('Lihat Video', style: TextStyle(color: AppColors.gradientStart, fontSize: 11, fontWeight: FontWeight.w600)),
                  ]),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted, size: 22),
          ],
        ),
      ),
    );
  }
}
