import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/app_colors.dart';
import '../core/app_theme.dart';
import '../widgets/gradient_app_bar.dart';
import '../widgets/gradient_button.dart';

class PsikologScreen extends StatelessWidget {
  const PsikologScreen({Key? key}) : super(key: key);

  static const List<Map<String, dynamic>> _psikologList = [
    {
      'name': 'Dr. Sari Wulandari, M.Psi',
      'specialization': 'Psikologi Klinis & Trauma',
      'experience': '8 Tahun Pengalaman',
      'rating': '4.9',
      'phone': '628815109368',
      'icon': Icons.person,
      'status': 'Tersedia',
    },
    {
      'name': 'Dr. Budi Santoso, M.Psi',
      'specialization': 'Kesehatan Mental & Konseling',
      'experience': '6 Tahun Pengalaman',
      'rating': '4.8',
      'phone': '6289526474974',
      'icon': Icons.person,
      'status': 'Tersedia',
    },
    {
      'name': 'Dr. Anisa Putri, M.Psi',
      'specialization': 'Psikologi Keluarga & Anak',
      'experience': '10 Tahun Pengalaman',
      'rating': '5.0',
      'phone': '628987920034',
      'icon': Icons.person,
      'status': 'Tersedia',
    },
  ];

  void _openWhatsApp(String phone) async {
    final url = 'https://wa.me/628815109368';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const GradientAppBar(title: 'Hubungi Psikolog'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info banner
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradientVertical,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gradientStart.withOpacity(0.25),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.support_agent_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Konsultasi Online',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Hubungi psikolog profesional kami kapan saja & di mana saja',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Text(
                    'Pilih Psikolog',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.gradientStart.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${_psikologList.length} Tersedia',
                      style: const TextStyle(
                        color: AppColors.gradientStart,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            ...List.generate(_psikologList.length, (index) {
              final psikolog = _psikologList[index];
              final bool isAvailable = psikolog['status'] == 'Tersedia';
              return _PsikologCard(
                psikolog: psikolog,
                isAvailable: isAvailable,
                onContact: () => _openWhatsApp(psikolog['phone']),
              );
            }),

            const SizedBox(height: 24),

            // Emergency note
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: const Color(0xFFFFCC80).withOpacity(0.5)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info_outline,
                        color: Color(0xFFF57C00), size: 22),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Jika Anda dalam keadaan darurat, segera hubungi 119 ext 8 (Hotline Kesehatan Jiwa)',
                        style: TextStyle(
                          color: Color(0xFFF57C00),
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class _PsikologCard extends StatelessWidget {
  final Map<String, dynamic> psikolog;
  final bool isAvailable;
  final VoidCallback onContact;

  const _PsikologCard({
    Key? key,
    required this.psikolog,
    required this.isAvailable,
    required this.onContact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.gradientStart.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Avatar
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradientVertical,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 34),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      psikolog['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      psikolog['specialization'],
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.work_outline,
                            color: AppColors.gradientStart, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          psikolog['experience'],
                          style: const TextStyle(
                            color: AppColors.gradientStart,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(Icons.star_rounded,
                            color: Color(0xFFFFC107), size: 14),
                        const SizedBox(width: 2),
                        Text(
                          psikolog['rating'],
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Status badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isAvailable
                      ? const Color(0xFFE8F5E9)
                      : const Color(0xFFFCE4EC),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: isAvailable
                            ? const Color(0xFF4CAF50)
                            : const Color(0xFFF44336),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      psikolog['status'],
                      style: TextStyle(
                        color: isAvailable
                            ? const Color(0xFF2E7D32)
                            : const Color(0xFFC62828),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          GradientButton(
            label: 'Hubungi via WhatsApp',
            height: 44,
            borderRadius: 12,
            fontSize: 13,
            leadingIcon: const Icon(
              Icons.chat_outlined,
              color: Colors.white,
              size: 18,
            ),
            onPressed: isAvailable ? onContact : () {},
          ),
        ],
      ),
    );
  }
}