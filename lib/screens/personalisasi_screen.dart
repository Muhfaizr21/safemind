import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../widgets/gradient_app_bar.dart';
import '../main.dart';

class PersonalisasiScreen extends StatelessWidget {
  const PersonalisasiScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppBar(title: 'Personalisasi'),
      body: ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (context, currentMode, child) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const Text(
                'Tampilan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: Column(
                  children: [
                    RadioListTile<ThemeMode>(
                      title: const Text('Tema Terang'),
                      value: ThemeMode.light,
                      groupValue: currentMode,
                      activeColor: AppColors.gradientStart,
                      onChanged: (ThemeMode? value) {
                        if (value != null) themeNotifier.value = value;
                      },
                    ),
                    const Divider(height: 1),
                    RadioListTile<ThemeMode>(
                      title: const Text('Tema Gelap'),
                      value: ThemeMode.dark,
                      groupValue: currentMode,
                      activeColor: AppColors.gradientStart,
                      onChanged: (ThemeMode? value) {
                        if (value != null) themeNotifier.value = value;
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
