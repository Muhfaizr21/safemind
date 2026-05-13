import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../core/app_colors.dart';
import '../core/app_theme.dart';

class LaporanForm extends StatefulWidget {
  @override
  _LaporanFormState createState() => _LaporanFormState();
}

class _LaporanFormState extends State<LaporanForm> {
  final _formKey = GlobalKey<FormState>();

  String? jenisLaporan;
  final TextEditingController lokasi = TextEditingController();
  final TextEditingController deskripsi = TextEditingController();
  DateTime? selectedDate;
  bool anonim = false;
  bool isLoading = false;
  String? fileName;

  final List<String> jenisList = [
    "Kekerasan Fisik",
    "Kekerasan Psikologis/Psikis",
    "Kekerasan Seksual",
    "Perundungan (Bullying)",
    "Penelantaran & Eksploitasi",
    "Isu Kesehatan Mental (Self Report)",
  ];

  Future<void> pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
                primary: AppColors.gradientStart),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.pickFiles();
    if (result != null) {
      setState(() {
        fileName = result.files.single.name;
      });
    }
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() => isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Laporan berhasil dikirim"),
              backgroundColor: AppColors.gradientStart,
            ),
          );
        }
      });
    }
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
      filled: true,
      fillColor: Colors.white,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:
            const BorderSide(color: AppColors.cardBorder, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:
            const BorderSide(color: AppColors.gradientStart, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
    );
  }

  Widget _sectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.only(top: 20, bottom: 32),
          children: [
            // JENIS LAPORAN
            _sectionLabel('Jenis Laporan'),
            DropdownButtonFormField<String>(
              decoration: _inputDecoration('').copyWith(hintText: null),
              value: jenisLaporan,
              items: jenisList.map((item) {
                return DropdownMenuItem(
                    value: item,
                    child: Text(item,
                        style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textPrimary)));
              }).toList(),
              onChanged: (value) =>
                  setState(() => jenisLaporan = value),
              validator: (value) =>
                  value == null ? "Pilih jenis laporan" : null,
              icon: const Icon(Icons.keyboard_arrow_down,
                  color: AppColors.gradientStart),
              dropdownColor: Colors.white,
              style: const TextStyle(
                  color: AppColors.textPrimary, fontSize: 14),
            ),

            const SizedBox(height: 16),

            // LOKASI
            _sectionLabel('Lokasi Kejadian'),
            TextFormField(
              controller: lokasi,
              decoration:
                  _inputDecoration('Masukan Lokasi Kejadian...'),
              validator: (value) =>
                  value!.isEmpty ? "Isi lokasi" : null,
            ),

            const SizedBox(height: 16),

            // TANGGAL
            _sectionLabel('Tanggal Kejadian'),
            GestureDetector(
              onTap: () => pickDate(context),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: AppColors.cardBorder, width: 1.5),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined,
                        color: AppColors.gradientStart, size: 18),
                    const SizedBox(width: 10),
                    Text(
                      selectedDate == null
                          ? 'Pilih Tanggal'
                          : '${selectedDate!.day} ${_monthName(selectedDate!.month)} ${selectedDate!.year}',
                      style: TextStyle(
                        color: selectedDate == null
                            ? Colors.grey[400]
                            : AppColors.textPrimary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // DESKRIPSI
            _sectionLabel('Deskripsi Kejadian'),
            TextFormField(
              controller: deskripsi,
              maxLines: 4,
              decoration: _inputDecoration(
                  'Ceritakan kejadian yang dialami...'),
              validator: (value) =>
                  value!.isEmpty ? "Isi deskripsi" : null,
            ),

            const SizedBox(height: 16),

            // UPLOAD BUKTI
            _sectionLabel('Upload Bukti (Opsional)'),
            GestureDetector(
              onTap: pickFile,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border:
                      Border.all(color: AppColors.cardBorder, width: 1.5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: AppTheme.primaryGradient,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add_photo_alternate_outlined,
                          color: Colors.white, size: 22),
                    ),
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        fileName ?? 'Tambah Foto / Dokumen',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: fileName != null ? AppColors.gradientStart : AppColors.textSecondary,
                          fontWeight: fileName != null ? FontWeight.bold : FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ANONIM TOGGLE
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: AppColors.cardBorder, width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.shield_outlined,
                          color: AppColors.gradientStart, size: 20),
                      SizedBox(width: 10),
                      Text(
                        'Laporkan Secara Anonim',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  Switch(
                    value: anonim,
                    activeColor: AppColors.gradientStart,
                    onChanged: (value) =>
                        setState(() => anonim = value),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // SUBMIT BUTTON — gradient
            SizedBox(
              width: double.infinity,
              height: 54,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: isLoading
                      ? const LinearGradient(
                          colors: [Colors.grey, Colors.grey])
                      : AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: isLoading
                      ? []
                      : [
                          BoxShadow(
                            color: AppColors.gradientStart
                                .withOpacity(0.35),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  onPressed: isLoading ? null : submitForm,
                  child: isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2.5),
                        )
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.send_outlined,
                                color: Colors.white, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Kirim Laporan',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      '',
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return months[month];
  }

  @override
  void dispose() {
    lokasi.dispose();
    deskripsi.dispose();
    super.dispose();
  }
}
