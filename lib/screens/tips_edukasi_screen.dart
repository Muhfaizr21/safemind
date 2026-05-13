import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_theme.dart';
import 'artikel_detail_screen.dart';

class TipsEdukasiScreen extends StatelessWidget {
  TipsEdukasiScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> tipsList = [
    {
      'judul': 'Cara Mengatasi Trauma Psikologis',
      'ringkasan':
          'Mengatasi trauma membutuhkan waktu dan dukungan yang tepat. Pelajari langkah-langkah praktis untuk memulai pemulihan.',
      'kategori': 'Kesehatan Mental',
      'tanggal': '15 April 2026',
      'icon': Icons.self_improvement_outlined,
      'warna': const Color(0xFF8062DA),
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
      'judul': 'Tips Menjaga Kesehatan Mental Sehari-Hari',
      'ringkasan':
          'Kesehatan mental sama pentingnya dengan kesehatan fisik. Temukan cara sederhana untuk menjaga keseimbangan mental Anda.',
      'kategori': 'Gaya Hidup Sehat',
      'tanggal': '12 April 2026',
      'icon': Icons.spa_outlined,
      'warna': const Color(0xFF9575CD),
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
      'judul': 'Mengenali Tanda-Tanda Depresi pada Diri Sendiri',
      'ringkasan':
          'Depresi seringkali tidak terlihat dari luar. Pelajari tanda-tanda yang perlu diwaspadai agar dapat segera mendapat pertolongan.',
      'kategori': 'Edukasi Mental',
      'tanggal': '9 April 2026',
      'icon': Icons.psychology_outlined,
      'warna': const Color(0xFF7C3AED),
      'konten': '''Depresi adalah gangguan suasana hati yang serius namun dapat ditangani. Mengenali gejalanya sejak dini adalah langkah pertama menuju pemulihan yang efektif.

## Apa Itu Depresi

Depresi bukan sekadar merasa sedih sesaat. Ini adalah kondisi medis yang mempengaruhi cara berpikir, merasa, dan menjalani aktivitas sehari-hari. Depresi dapat terjadi pada siapa saja tanpa memandang usia, latar belakang, atau keadaan hidup.

## Tanda-Tanda yang Perlu Diwaspadai

- Perasaan sedih, hampa, atau putus asa yang berlangsung lebih dari dua minggu
- Kehilangan minat pada hal-hal yang sebelumnya menyenangkan
- Perubahan pola tidur yang signifikan, baik insomnia maupun tidur berlebihan
- Kelelahan dan kurangnya energi hampir setiap hari
- Kesulitan berkonsentrasi atau membuat keputusan
- Perasaan tidak berharga atau rasa bersalah yang berlebihan

## Langkah yang Harus Dilakukan

Jika Anda atau orang di sekitar Anda menunjukkan tanda-tanda tersebut, jangan menunggu. Bicaralah dengan orang yang Anda percaya dan cari bantuan profesional. Depresi dapat disembuhkan dengan penanganan yang tepat.

## Stigma Bukan Penghalang

Masih banyak orang yang enggan mencari bantuan karena takut dihakimi. Ingatlah bahwa mencari pertolongan adalah tanda kekuatan, bukan kelemahan.''',
    },
    {
      'judul': 'Cara Mengelola Kecemasan dalam Kehidupan Modern',
      'ringkasan':
          'Di era yang serba cepat ini, kecemasan menjadi semakin umum. Pelajari strategi praktis untuk mengelolanya secara efektif.',
      'kategori': 'Manajemen Kecemasan',
      'tanggal': '5 April 2026',
      'icon': Icons.air_outlined,
      'warna': const Color(0xFF8062DA),
      'konten': '''Kecemasan adalah respons alami tubuh terhadap situasi yang dianggap mengancam. Namun ketika berlebihan, kecemasan dapat mengganggu kualitas hidup secara signifikan.

## Memahami Kecemasan

Kecemasan yang wajar sebenarnya bermanfaat karena memotivasi kita untuk bersiap menghadapi tantangan. Masalah muncul ketika kecemasan hadir secara berlebihan, terus-menerus, dan tidak proporsional dengan situasi yang dihadapi.

## Teknik Mengelola Kecemasan

- Teknik grounding: fokus pada 5 hal yang dapat dilihat, 4 yang dapat disentuh, 3 yang dapat didengar
- Pernapasan diafragma untuk mengaktifkan sistem saraf parasimpatik
- Olahraga teratur sebagai pelepas hormon stres secara alami
- Batasi konsumsi kafein dan alkohol yang dapat memperburuk gejala
- Tuliskan kekhawatiran Anda dan pisahkan mana yang dapat dikontrol

## Mindfulness dalam Kehidupan Sehari-Hari

Mindfulness adalah kemampuan untuk hadir sepenuhnya di momen saat ini. Praktikkan dengan memperhatikan pernapasan Anda selama 5 menit setiap pagi untuk memulai hari dengan lebih tenang.

## Kapan Kecemasan Membutuhkan Bantuan Profesional

Jika kecemasan sudah mengganggu pekerjaan, hubungan, atau aktivitas sehari-hari, konsultasikan dengan profesional kesehatan mental. Terapi kognitif-perilaku (CBT) terbukti efektif untuk mengatasi gangguan kecemasan.''',
    },
    {
      'judul': 'Membangun Ketahanan Mental yang Kuat',
      'ringkasan':
          'Resiliensi atau ketahanan mental adalah kemampuan untuk bangkit dari kesulitan. Pelajari cara membangunnya secara bertahap.',
      'kategori': 'Pengembangan Diri',
      'tanggal': '1 April 2026',
      'icon': Icons.shield_outlined,
      'warna': const Color(0xFF9575CD),
      'konten': '''Ketahanan mental bukan berarti tidak pernah merasakan kesulitan. Sebaliknya, ini adalah kemampuan untuk menghadapi tantangan dengan kepala tegak dan bangkit lebih kuat dari sebelumnya.

## Apa Itu Resiliensi

Resiliensi adalah kapasitas psikologis yang dapat dikembangkan oleh siapa saja. Ini bukan sifat bawaan yang hanya dimiliki sebagian orang, melainkan serangkaian keterampilan yang dapat dipelajari dan diasah.

## Pilar Ketahanan Mental

- Memiliki jaringan dukungan sosial yang kuat dan saling mendukung
- Mengembangkan pandangan bahwa kesulitan adalah bagian dari kehidupan
- Menjaga kesehatan fisik sebagai fondasi kesehatan mental
- Menemukan makna dan tujuan dalam setiap pengalaman, termasuk yang sulit
- Kemampuan untuk mengatur emosi secara sehat dan adaptif

## Praktik Membangun Resiliensi

Mulailah dengan menetapkan tujuan kecil yang realistis dan rayakan setiap pencapaian. Refleksi positif harian tentang hal-hal yang berjalan baik dapat membantu mengubah pola pikir menjadi lebih optimis.

## Resiliensi dan Pertumbuhan Pasca-Trauma

Banyak orang yang mengalami trauma kemudian menemukan bahwa pengalaman tersebut justru membantu mereka tumbuh dan berkembang. Fenomena ini disebut post-traumatic growth, dan merupakan bukti nyata kekuatan manusia untuk beradaptasi.''',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // HEADER
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
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                          ),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new,
                            color: Colors.white, size: 18),
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tips & Edukasi',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Panduan kesehatan mental untuk Anda',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // DAFTAR TIPS
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
              itemCount: tipsList.length,
              itemBuilder: (context, index) {
                final item = tipsList[index];
                return _TipsCard(
                  judul: item['judul'] as String,
                  ringkasan: item['ringkasan'] as String,
                  kategori: item['kategori'] as String,
                  tanggal: item['tanggal'] as String,
                  icon: item['icon'] as IconData,
                  warna: item['warna'] as Color,
                  konten: item['konten'] as String,
                );
              },
            ),
          ),
        ],
      ),
    );
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
            BoxShadow(
              color: AppColors.gradientStart.withOpacity(0.08),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner atas berwarna
            Container(
              height: 6,
              decoration: BoxDecoration(
                color: warna,
                borderRadius: const BorderRadius.only(
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
                  // Kategori dan tanggal
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
                          style: TextStyle(
                            color: warna,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.3,
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
                  const SizedBox(height: 10),
                  // Icon dan judul
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [warna, warna.withOpacity(0.7)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
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
                            fontSize: 14,
                            color: AppColors.textPrimary,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Ringkasan
                  Text(
                    ringkasan,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12.5,
                      height: 1.6,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  // Tombol baca
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Baca Selengkapnya',
                            style: TextStyle(
                              color: warna,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(Icons.arrow_forward_ios,
                              size: 11, color: warna),
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
