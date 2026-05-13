import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_theme.dart';
import 'artikel_detail_screen.dart';
import 'tips_edukasi_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  // Data artikel untuk horizontal scroll
  static final List<Map<String, dynamic>> _artikelData = [
    {
      'title': 'Cara Mengatasi Trauma Psikologis',
      'ringkasan':
          'Mengatasi trauma membutuhkan waktu dan dukungan yang tepat. Pelajari langkah-langkah praktis.',
      'kategori': 'Kesehatan Mental',
      'tanggal': '15 April 2026',
      'icon': Icons.self_improvement_outlined,
      'gradientStart': const Color(0xFF8062DA),
      'gradientEnd': const Color(0xFFA87FD8),
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

Jika gejala trauma berlangsung lebih dari sebulan, mengganggu aktivitas sehari-hari, atau menyebabkan pikiran menyakiti diri sendiri, segera konsultasikan dengan psikolog atau psikiater.''',
    },
    {
      'title': 'Tips Menjaga Kesehatan Mental',
      'ringkasan':
          'Kesehatan mental sama pentingnya dengan kesehatan fisik. Temukan cara sederhana untuk menjaga keseimbangan.',
      'kategori': 'Gaya Hidup Sehat',
      'tanggal': '12 April 2026',
      'icon': Icons.spa_outlined,
      'gradientStart': const Color(0xFF9575CD),
      'gradientEnd': const Color(0xFFCE93D8),
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
    {
      'title': 'Mengenali Tanda-Tanda Depresi',
      'ringkasan':
          'Depresi seringkali tidak terlihat dari luar. Pelajari tanda-tandanya agar dapat segera mendapat pertolongan.',
      'kategori': 'Edukasi Mental',
      'tanggal': '9 April 2026',
      'icon': Icons.psychology_outlined,
      'gradientStart': const Color(0xFF7C3AED),
      'gradientEnd': const Color(0xFF9575CD),
      'konten': '''Depresi adalah gangguan suasana hati yang serius namun dapat ditangani. Mengenali gejalanya sejak dini adalah langkah pertama menuju pemulihan yang efektif.

## Apa Itu Depresi

Depresi bukan sekadar merasa sedih sesaat. Ini adalah kondisi medis yang mempengaruhi cara berpikir, merasa, dan menjalani aktivitas sehari-hari.

## Tanda-Tanda yang Perlu Diwaspadai

- Perasaan sedih, hampa, atau putus asa yang berlangsung lebih dari dua minggu
- Kehilangan minat pada hal-hal yang sebelumnya menyenangkan
- Perubahan pola tidur yang signifikan
- Kelelahan dan kurangnya energi hampir setiap hari
- Kesulitan berkonsentrasi atau membuat keputusan
- Perasaan tidak berharga atau rasa bersalah yang berlebihan

## Langkah yang Harus Dilakukan

Jika Anda atau orang di sekitar Anda menunjukkan tanda-tanda tersebut, jangan menunggu. Bicaralah dengan orang yang Anda percaya dan cari bantuan profesional. Depresi dapat disembuhkan dengan penanganan yang tepat.''',
    },
    {
      'title': 'Membangun Resiliensi Mental',
      'ringkasan':
          'Resiliensi adalah kemampuan untuk bangkit dari kesulitan. Pelajari cara membangunnya secara bertahap dan konsisten.',
      'kategori': 'Pengembangan Diri',
      'tanggal': '1 April 2026',
      'icon': Icons.shield_outlined,
      'gradientStart': const Color(0xFF6A5ACD),
      'gradientEnd': const Color(0xFF9575CD),
      'konten': '''Ketahanan mental bukan berarti tidak pernah merasakan kesulitan. Sebaliknya, ini adalah kemampuan untuk menghadapi tantangan dengan kepala tegak dan bangkit lebih kuat dari sebelumnya.

## Apa Itu Resiliensi

Resiliensi adalah kapasitas psikologis yang dapat dikembangkan oleh siapa saja. Ini bukan sifat bawaan, melainkan serangkaian keterampilan yang dapat dipelajari dan diasah.

## Pilar Ketahanan Mental

- Memiliki jaringan dukungan sosial yang kuat dan saling mendukung
- Mengembangkan pandangan bahwa kesulitan adalah bagian dari kehidupan
- Menjaga kesehatan fisik sebagai fondasi kesehatan mental
- Menemukan makna dan tujuan dalam setiap pengalaman
- Kemampuan untuk mengatur emosi secara sehat dan adaptif

## Praktik Membangun Resiliensi

Mulailah dengan menetapkan tujuan kecil yang realistis dan rayakan setiap pencapaian. Refleksi positif harian tentang hal-hal yang berjalan baik dapat membantu mengubah pola pikir menjadi lebih optimis.''',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER GRADIENT
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                  top: 52, left: 20, right: 20, bottom: 28),
              decoration: const BoxDecoration(
                gradient: AppTheme.primaryGradientVertical,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Selamat Datang',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Pengguna SafeMind',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.notifications_outlined,
                            color: Colors.white, size: 24),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // MENU GRID
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _menuItem(
                    context,
                    Icons.report_problem_outlined,
                    'Laporkan\nKasus',
                    () => Navigator.pushNamed(context, '/laporan'),
                  ),
                  const SizedBox(width: 10),
                  _menuItem(
                    context,
                    Icons.headset_mic_outlined,
                    'Konsultasi\nPsikolog',
                    () => Navigator.pushNamed(context, '/psikolog'),
                  ),
                  const SizedBox(width: 10),
                  _menuItem(
                    context,
                    Icons.lightbulb_outline_rounded,
                    'Tips &\nEdukasi',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TipsEdukasiScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  _menuItem(
                    context,
                    Icons.emergency_outlined,
                    'Layanan\nDarurat',
                    () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // STATUS LAPORAN
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Status Laporan Anda',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.gradientStart.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        gradient: AppTheme.primaryGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.receipt_long_outlined,
                          color: Colors.white, size: 22),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Laporan #1234 Sedang Diproses',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Kami sedang meninjau laporan Anda',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF3E0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Proses',
                        style: TextStyle(
                          color: Color(0xFFF57C00),
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ARTIKEL & TIPS - Header dengan label
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Artikel & Tips',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    'Geser untuk lebih',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // ARTIKEL HORIZONTAL SCROLL
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 16, right: 8),
                itemCount: _artikelData.length,
                itemBuilder: (context, index) {
                  final item = _artikelData[index];
                  return _ArtikelCardHorizontal(
                    title: item['title'] as String,
                    ringkasan: item['ringkasan'] as String,
                    kategori: item['kategori'] as String,
                    tanggal: item['tanggal'] as String,
                    icon: item['icon'] as IconData,
                    gradientStart: item['gradientStart'] as Color,
                    gradientEnd: item['gradientEnd'] as Color,
                    konten: item['konten'] as String,
                  );
                },
              ),
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.gradientStart.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.white, size: 22),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
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

  const _ArtikelCardHorizontal({
    required this.title,
    required this.ringkasan,
    required this.kategori,
    required this.tanggal,
    required this.icon,
    required this.gradientStart,
    required this.gradientEnd,
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
              judul: title,
              konten: konten,
              kategori: kategori,
              tanggal: tanggal,
              icon: icon,
            ),
          ),
        );
      },
      child: Container(
        width: 220,
        margin: const EdgeInsets.only(right: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: gradientStart.withOpacity(0.14),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner gradient atas
            Container(
              height: 90,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [gradientStart, gradientEnd],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Stack(
                children: [
                  // Pola lingkaran dekoratif
                  Positioned(
                    right: -20,
                    top: -20,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    bottom: -10,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  // Icon utama
                  Positioned(
                    left: 14,
                    bottom: 14,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(icon, color: Colors.white, size: 22),
                    ),
                  ),
                  // Badge kategori
                  Positioned(
                    right: 12,
                    top: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.35),
                        ),
                      ),
                      child: const Text(
                        'Artikel',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Konten bawah
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: AppColors.textPrimary,
                        height: 1.35,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      ringkasan,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                        height: 1.5,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(Icons.access_time_outlined,
                            size: 11, color: AppColors.textMuted),
                        const SizedBox(width: 3),
                        Text(
                          tanggal,
                          style: const TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 10,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'Baca',
                          style: TextStyle(
                            color: gradientStart,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 2),
                        Icon(Icons.arrow_forward_ios,
                            size: 9, color: gradientStart),
                      ],
                    ),
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
