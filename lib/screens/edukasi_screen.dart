import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/app_colors.dart';
import '../core/app_theme.dart';
import 'artikel_detail_screen.dart';

class EdukasiScreen extends StatelessWidget {
  EdukasiScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> artikelList = [
    {
      'judul': 'Mengatasi Trauma',
      'deskripsi': 'Tips sederhana untuk mengurangi trauma psikologis dan memulai proses pemulihan yang sehat.',
      'kategori': 'Kesehatan Mental',
      'tanggal': '15 April 2026',
      'icon': Icons.self_improvement_outlined,
      'konten': '''Trauma psikologis adalah respons emosional yang terjadi akibat peristiwa yang sangat menekan atau mengancam. Mengatasinya membutuhkan pendekatan yang terstruktur dan penuh kesadaran.

## Memahami Trauma

Trauma bukan tanda kelemahan. Ini adalah reaksi alami otak terhadap pengalaman yang sangat sulit. Setiap orang memiliki cara berbeda dalam merespons trauma, dan tidak ada satu cara yang benar atau salah.

## Langkah-Langkah Pemulihan

- Akui perasaan Anda tanpa menghakimi diri sendiri
- Cari dukungan dari orang-orang terpercaya di sekitar Anda
- Tetap rutin dalam aktivitas harian untuk menciptakan rasa stabil
- Batasi paparan terhadap pemicu yang mengaktifkan kembali trauma
- Pertimbangkan untuk berkonsultasi dengan profesional kesehatan mental

## Teknik Menenangkan Diri

Saat gejala trauma muncul, cobalah teknik pernapasan dalam: tarik napas selama 4 hitungan, tahan selama 4 hitungan, dan hembuskan selama 6 hitungan. Ulangi hingga pikiran terasa lebih tenang.

## Kapan Harus Mencari Bantuan Profesional

Jika gejala trauma berlangsung lebih dari sebulan, mengganggu aktivitas sehari-hari, atau menyebabkan pikiran menyakiti diri sendiri, segera konsultasikan dengan psikolog atau psikiater. Bantuan profesional adalah langkah yang bijak, bukan kelemahan.''',
    },
    {
      'judul': 'Menjaga Kesehatan Mental',
      'deskripsi': 'Cara menjaga kesehatan mental sehari-hari dengan kebiasaan sederhana namun berdampak besar.',
      'kategori': 'Gaya Hidup Sehat',
      'tanggal': '12 April 2026',
      'icon': Icons.spa_outlined,
      'konten': '''Menjaga kesehatan mental tidak harus rumit. Kebiasaan-kebiasaan kecil yang dilakukan secara konsisten dapat memberikan dampak besar terhadap kesejahteraan pikiran Anda.

## Pentingnya Rutinitas Harian

Rutinitas memberikan rasa kendali dan prediktabilitas. Menetapkan jadwal tidur, makan, dan aktivitas yang teratur membantu otak berfungsi lebih optimal dan mengurangi kecemasan.

## Kebiasaan Sehat untuk Pikiran

- Tidur 7 hingga 9 jam setiap malam secara teratur
- Berolahraga minimal 30 menit per hari, bahkan jalan kaki sudah cukup
- Konsumsi makanan bergizi dan cukup minum air putih
- Luangkan waktu untuk hobi dan aktivitas yang menyenangkan
- Batasi penggunaan media sosial yang dapat memicu perbandingan diri

## Manajemen Stres yang Efektif

Identifikasi pemicu stres Anda dan cari cara yang sehat untuk menghadapinya. Meditasi, journaling, atau berbicara dengan orang yang Anda percaya dapat membantu melepaskan beban mental.

## Membangun Koneksi Sosial

Hubungan sosial yang sehat adalah salah satu perlindungan terkuat dari gangguan mental. Investasikan waktu untuk membangun dan memelihara hubungan yang positif dan bermakna.''',
    },
  ];

  final List<Map<String, dynamic>> videoList = [
    {
      'judul': 'Cara Mengatasi Anxiety',
      'url': 'https://youtu.be/BwivvpCyVAA?si=PSeqHUfmZaNyQGzX',
      'durasi': '8 menit',
    },
    {
      'judul': 'Mengenal Kesehatan Mental',
      'url': 'https://www.youtube.com/watch?v=LdBGbmY5Ips',
      'durasi': '10 menit',
    },
    {
      'judul': 'Cara Mengatasi Depresi',
      'url': 'https://www.youtube.com/watch?v=5MuImqhT8oM',
      'durasi': '12 menit',
    },
  ];

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
          // HEADER GRADIENT - tanpa tombol back
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: double.infinity),
                const Text(
                  'Edukasi & Dukungan',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Kami menjaga kerahasiaan data Anda',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          // BODY
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [

                // JUDUL SEKSI ARTIKEL
                const Text(
                  'Artikel Pilihan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),

                // ARTIKEL LIST
                ...artikelList.map((artikel) {
                  return _ArtikelCard(
                    judul: artikel['judul'] as String,
                    deskripsi: artikel['deskripsi'] as String,
                    kategori: artikel['kategori'] as String,
                    tanggal: artikel['tanggal'] as String,
                    icon: artikel['icon'] as IconData,
                    konten: artikel['konten'] as String,
                  );
                }).toList(),

                const SizedBox(height: 20),

                // VIDEO EDUKASI
                const Text(
                  'Video Edukasi',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 10),

                ...videoList.map((video) {
                  return _VideoCard(
                    judul: video['judul'] as String,
                    durasi: video['durasi'] as String,
                    onTap: () => _launchVideo(video['url'] as String),
                  );
                }).toList(),

                const SizedBox(height: 20),

                // BANTUAN CEPAT
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.gradientStart.withOpacity(0.25),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Butuh Bantuan Segera?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Tim psikolog profesional kami siap membantu Anda',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        '+62 885 111 056',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        width: double.infinity,
                        height: 46,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.gradientStart,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 0,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/psikolog');
                          },
                          child: const Text(
                            'Hubungi Sekarang',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget kartu artikel
class _ArtikelCard extends StatelessWidget {
  final String judul;
  final String deskripsi;
  final String kategori;
  final String tanggal;
  final IconData icon;
  final String konten;

  const _ArtikelCard({
    required this.judul,
    required this.deskripsi,
    required this.kategori,
    required this.tanggal,
    required this.icon,
    required this.konten,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.gradientStart.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Accent bar atas
          Container(
            height: 5,
            decoration: const BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Meta: kategori + tanggal
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.accentLight,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        kategori,
                        style: const TextStyle(
                          color: AppColors.gradientStart,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.calendar_today_outlined,
                        size: 11, color: AppColors.textMuted),
                    const SizedBox(width: 4),
                    Text(
                      tanggal,
                      style: const TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Icon dan judul
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        gradient: AppTheme.primaryGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(icon, color: Colors.white, size: 22),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        judul,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppColors.textPrimary,
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  deskripsi,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                    height: 1.55,
                  ),
                ),
                const SizedBox(height: 14),
                // Tombol baca selengkapnya
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.gradientStart,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
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
                    child: const Text(
                      'Baca Selengkapnya',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
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

// Widget kartu video
class _VideoCard extends StatelessWidget {
  final String judul;
  final String durasi;
  final VoidCallback onTap;

  const _VideoCard({
    required this.judul,
    required this.durasi,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.cardBorder, width: 1),
          boxShadow: [
            BoxShadow(
              color: AppColors.gradientStart.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Thumbnail video
            Container(
              width: 72,
              height: 56,
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.25),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const Icon(Icons.play_arrow_rounded,
                      color: Colors.white, size: 26),
                ],
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    judul,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13.5,
                      color: AppColors.textPrimary,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.access_time_outlined,
                          size: 12, color: AppColors.textMuted),
                      const SizedBox(width: 3),
                      Text(
                        durasi,
                        style: const TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.play_circle_outline,
                          size: 12, color: AppColors.gradientStart),
                      const SizedBox(width: 3),
                      const Text(
                        'Lihat Video',
                        style: TextStyle(
                          color: AppColors.gradientStart,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded,
                color: AppColors.textMuted, size: 22),
          ],
        ),
      ),
    );
  }
}
