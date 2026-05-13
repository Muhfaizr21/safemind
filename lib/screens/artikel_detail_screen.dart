import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_theme.dart';

class ArtikelDetailScreen extends StatelessWidget {
  final String judul;
  final String konten;
  final String kategori;
  final String tanggal;
  final IconData icon;

  const ArtikelDetailScreen({
    Key? key,
    required this.judul,
    required this.konten,
    required this.kategori,
    required this.tanggal,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Sliver App Bar dengan gradient modern
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.gradientStart,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: AppTheme.primaryGradientVertical,
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tombol kembali
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                              ),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                        const Spacer(),
                        // Kategori badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.4),
                            ),
                          ),
                          child: Text(
                            kategori,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Judul
                        Text(
                          judul,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            height: 1.35,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Konten artikel
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Meta info bar
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            gradient: AppTheme.primaryGradient,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(icon, color: Colors.white, size: 20),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Tim SafeMind',
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                tanggal,
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColors.accentLight,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Artikel',
                            style: TextStyle(
                              color: AppColors.gradientStart,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Divider(height: 1, color: AppColors.cardBorder),

                  // Isi konten
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _buildKontenWidgets(konten),
                    ),
                  ),

                  // Bagian bawah
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.gradientStart.withOpacity(0.3),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.favorite_border,
                            color: Colors.white, size: 22),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Ingat, kesehatan mental Anda adalah prioritas utama.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildKontenWidgets(String konten) {
    final paragraphs = konten.split('\n\n');
    List<Widget> widgets = [];
    for (int i = 0; i < paragraphs.length; i++) {
      final p = paragraphs[i].trim();
      if (p.isEmpty) continue;
      if (p.startsWith('##')) {
        widgets.add(Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 8),
          child: Text(
            p.replaceFirst('## ', ''),
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              height: 1.4,
            ),
          ),
        ));
      } else if (p.startsWith('- ')) {
        final items = p.split('\n');
        for (final item in items) {
          widgets.add(Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 7, right: 10),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.gradientStart,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    item.replaceFirst('- ', '').trim(),
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimary,
                      height: 1.65,
                    ),
                  ),
                ),
              ],
            ),
          ));
        }
      } else {
        widgets.add(Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Text(
            p,
            style: const TextStyle(
              fontSize: 14.5,
              color: AppColors.textPrimary,
              height: 1.75,
              letterSpacing: 0.1,
            ),
            textAlign: TextAlign.justify,
          ),
        ));
      }
    }
    return widgets;
  }
}
