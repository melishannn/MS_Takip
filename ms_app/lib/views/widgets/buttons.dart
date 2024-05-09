// buttons.dart
import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final VoidCallback onEditPressed;
  final VoidCallback onCancelPressed;

  const Buttons({
    Key? key,
    required this.onEditPressed,
    required this.onCancelPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    TextTheme textTheme = theme.textTheme;

    return Column(
      children: [
        ElevatedButton(
          onPressed: onEditPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: colorScheme.onPrimary, backgroundColor: colorScheme.primary, // Temadan birincil üzerine rengi kullan
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Yuvarlak köşeler
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
          child: Text(
            'Randevuyu Düzenle',
            style: textTheme.labelLarge?.copyWith(color: colorScheme.onPrimary), // Temadan button stilini kullan
          ),
        ),
        const SizedBox(height: 8), // Butonlar arası boşluk
        ElevatedButton(
          onPressed: onCancelPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: colorScheme.onError, backgroundColor: colorScheme.error, // Hata/iptal üzerine rengi kullan
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Yuvarlak köşeler
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
          child: Text(
            'Randevuyu İptal Et',
            style: textTheme.labelLarge?.copyWith(color: colorScheme.onError), // Temadan button stilini kullan
          ),
        ),
      ],
    );
  }
}
