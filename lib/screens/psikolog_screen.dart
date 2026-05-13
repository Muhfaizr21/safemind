import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../core/app_colors.dart';
import '../core/app_theme.dart';
import '../core/api_config.dart';
import '../widgets/gradient_app_bar.dart';
import '../widgets/gradient_button.dart';

class PsikologScreen extends StatefulWidget {
  const PsikologScreen({Key? key}) : super(key: key);

  @override
  _PsikologScreenState createState() => _PsikologScreenState();
}

class _PsikologScreenState extends State<PsikologScreen> {
  List _psikologList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPsychologists();
  }

  Future<void> _fetchPsychologists() async {
    try {
      final response = await http.get(Uri.parse(ApiConfig.psychologists));
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        setState(() {
          _psikologList = data['data'];
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _openWhatsApp(String phone) async {
    // Hilangkan tanda '+' jika ada
    String cleanPhone = phone.replaceAll('+', '');
    final url = 'https://wa.me/$cleanPhone?text=Halo,%20saya%20ingin%20konsultasi%20melalui%20SafeMind';
    
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const GradientAppBar(title: 'Hubungi Psikolog'),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: _fetchPsychologists,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderBanner(),
                  _buildSelectionHeader(),
                  const SizedBox(height: 12),
                  ..._psikologList.map((psikolog) {
                    final bool isAvailable = psikolog['is_available'] == 1;
                    return _PsikologCard(
                      psikolog: psikolog,
                      isAvailable: isAvailable,
                      onContact: () => _openWhatsApp(psikolog['phone']),
                    );
                  }).toList(),
                  _buildEmergencyNote(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildHeaderBanner() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradientVertical,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: AppColors.gradientStart.withOpacity(0.25), blurRadius: 16, offset: const Offset(0, 6)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56, height: 56,
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(16)),
            child: const Icon(Icons.support_agent_outlined, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Konsultasi Online', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(height: 4),
                Text('Hubungi psikolog profesional kami kapan saja & di mana saja', style: TextStyle(color: Colors.white, fontSize: 12, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Text('Pilih Psikolog', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(color: AppColors.gradientStart.withOpacity(0.12), borderRadius: BorderRadius.circular(20)),
            child: Text('${_psikologList.length} Tersedia', style: const TextStyle(color: AppColors.gradientStart, fontSize: 12, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyNote() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF3E0),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFFFCC80).withOpacity(0.5)),
        ),
        child: const Row(
          children: [
            Icon(Icons.info_outline, color: Color(0xFFF57C00), size: 22),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Jika Anda dalam keadaan darurat, segera hubungi 119 ext 8 (Hotline Kesehatan Jiwa)',
                style: TextStyle(color: Color(0xFFF57C00), fontSize: 12, height: 1.5),
              ),
            ),
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

  const _PsikologCard({Key? key, required this.psikolog, required this.isAvailable, required this.onContact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: AppColors.gradientStart.withOpacity(0.08), blurRadius: 16, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 64, height: 64,
                decoration: BoxDecoration(gradient: AppTheme.primaryGradientVertical, shape: BoxShape.circle),
                child: const Icon(Icons.person, color: Colors.white, size: 34),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(psikolog['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textPrimary)),
                    const SizedBox(height: 3),
                    Text(psikolog['specialization'], style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.work_outline, color: AppColors.gradientStart, size: 14),
                        const SizedBox(width: 4),
                        Text('${psikolog['experience']} Pengalaman', style: const TextStyle(color: AppColors.gradientStart, fontSize: 11, fontWeight: FontWeight.w500)),
                        const SizedBox(width: 12),
                        const Icon(Icons.star_rounded, color: Color(0xFFFFC107), size: 14),
                        const SizedBox(width: 2),
                        Text(psikolog['rating'].toString(), style: const TextStyle(color: AppColors.textPrimary, fontSize: 11, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                ),
              ),
              _buildStatusBadge(),
            ],
          ),
          const SizedBox(height: 14),
          GradientButton(
            label: 'Hubungi via WhatsApp',
            height: 44,
            borderRadius: 12,
            fontSize: 13,
            leadingIcon: const Icon(Icons.chat_outlined, color: Colors.white, size: 18),
            onPressed: isAvailable ? onContact : () {},
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isAvailable ? const Color(0xFFE8F5E9) : const Color(0xFFFCE4EC),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7, height: 7,
            decoration: BoxDecoration(color: isAvailable ? const Color(0xFF4CAF50) : const Color(0xFFF44336), shape: BoxShape.circle),
          ),
          const SizedBox(width: 4),
          Text(
            isAvailable ? 'Tersedia' : 'Sibuk',
            style: TextStyle(color: isAvailable ? const Color(0xFF2E7D32) : const Color(0xFFC62828), fontSize: 10, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}