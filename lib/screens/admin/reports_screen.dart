import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../core/app_colors.dart';
import '../../core/api_config.dart';
import 'package:intl/intl.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  List _reports = [];
  List _filteredReports = [];
  bool _isLoading = true;
  String _searchQuery = '';
  String _selectedUrgency = 'Semua';

  @override
  void initState() {
    super.initState();
    _fetchReports();
  }

  Future<void> _fetchReports() async {
    try {
      final response = await http.get(Uri.parse(ApiConfig.reports));
      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['success'] == true) {
        setState(() {
          _reports = data['data'];
          _filteredReports = _reports;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _filterReports() {
    setState(() {
      _filteredReports = _reports.where((report) {
        bool matchesSearch = report['title'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
                            report['id'].toString().contains(_searchQuery);
        bool matchesUrgency = _selectedUrgency == 'Semua' || report['urgency'] == _selectedUrgency;
        return matchesSearch && matchesUrgency;
      }).toList();
    });
  }

  Future<void> _updateStatus(int id, String newStatus) async {
    try {
      final response = await http.put(
        Uri.parse('${ApiConfig.baseUrl}/admin/reports/$id/status'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'status': newStatus}),
      );
      if (response.statusCode == 200) {
        _fetchReports(); // Refresh data
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Status diperbarui menjadi $newStatus')));
      }
    } catch (e) {
      print('Error updating status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),
      appBar: AppBar(
        title: const Text('Inbox Laporan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0.5,
      ),
      body: Column(
        children: [
          _buildSearchAndFilters(),
          Expanded(
            child: _isLoading 
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: _fetchReports,
                  child: _filteredReports.isEmpty
                    ? const Center(child: Text('Tidak ada laporan ditemukan'))
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _filteredReports.length,
                        itemBuilder: (context, index) => _buildReportItem(_filteredReports[index]),
                      ),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            onChanged: (v) {
              _searchQuery = v;
              _filterReports();
            },
            decoration: InputDecoration(
              hintText: 'Cari ID atau judul laporan...',
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFDCE2F3))),
              filled: true,
              fillColor: const Color(0xFFF9F9FF),
            ),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ['Semua', 'Tinggi', 'Sedang', 'Rendah'].map((urgency) {
                bool isSelected = _selectedUrgency == urgency;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(urgency),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedUrgency = urgency;
                        _filterReports();
                      });
                    },
                    selectedColor: AppColors.gradientStart.withOpacity(0.2),
                    labelStyle: TextStyle(color: isSelected ? AppColors.gradientStart : Colors.grey, fontWeight: FontWeight.bold),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportItem(Map<String, dynamic> report) {
    Color urgencyColor = report['urgency'] == 'Tinggi' ? Colors.red : (report['urgency'] == 'Sedang' ? Colors.orange : Colors.green);
    Color statusColor = report['status'] == 'Terdaftar' ? AppColors.gradientStart : (report['status'] == 'Selesai' ? Colors.green : Colors.orange);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDCE2F3)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.warning_rounded, color: urgencyColor, size: 32),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _buildBadge(report['urgency'], urgencyColor.withOpacity(0.1), urgencyColor),
                        const SizedBox(width: 8),
                        _buildBadge(report['category'], const Color(0xFFF0F3FF), AppColors.textSecondary),
                        const SizedBox(width: 8),
                        Text('#INC-${report['id']}', style: const TextStyle(color: Colors.grey, fontSize: 11)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(report['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
              ),
              Text(_formatTime(report['created_at']), style: const TextStyle(color: Colors.grey, fontSize: 11)),
            ],
          ),
          const SizedBox(height: 12),
          Text(report['description'], style: const TextStyle(color: AppColors.textSecondary, fontSize: 13), maxLines: 2, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFF0F3FF)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 8, height: 8,
                    decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 8),
                  Text(report['status'] ?? 'Terdaftar', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  const SizedBox(width: 12),
                  const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(report['location'] ?? 'Jakarta', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
              PopupMenuButton<String>(
                onSelected: (v) => _updateStatus(report['id'], v),
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'Terdaftar', child: Text('Set Terdaftar')),
                  const PopupMenuItem(value: 'Dalam Review', child: Text('Set Dalam Review')),
                  const PopupMenuItem(value: 'Menunggu', child: Text('Set Menunggu')),
                  const PopupMenuItem(value: 'Selesai', child: Text('Set Selesai')),
                ],
                child: Row(
                  children: [
                    Text('Update Status', style: TextStyle(color: AppColors.gradientStart, fontWeight: FontWeight.bold, fontSize: 12)),
                    const Icon(Icons.arrow_drop_down, color: AppColors.gradientStart),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String label, Color bg, Color text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
      child: Text(label, style: TextStyle(color: text, fontWeight: FontWeight.bold, fontSize: 10)),
    );
  }

  String _formatTime(String? dateStr) {
    if (dateStr == null) return '';
    DateTime dt = DateTime.parse(dateStr);
    return DateFormat('HH:mm').format(dt);
  }
}
