// buttons.dart
import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final VoidCallback? onEditPressed;
  final VoidCallback? onCancelPressed;
  final VoidCallback? onSavePressed;
  final VoidCallback? onLogoutPressed;

  const Buttons({
    Key? key,
    this.onEditPressed,
    this.onCancelPressed,
    this.onSavePressed,
    this.onLogoutPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    TextTheme textTheme = theme.textTheme;

    return Column(
      children: [
        if (onEditPressed != null)
          ElevatedButton(
            onPressed: onEditPressed,
            style: ElevatedButton.styleFrom(
              foregroundColor: colorScheme.onPrimary, 
              backgroundColor: colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: Text(
              'Randevuyu Düzenle',
              style: textTheme.labelLarge?.copyWith(color: colorScheme.onPrimary),
            ),
          ),
        const SizedBox(height: 8),
        if (onCancelPressed != null)
          ElevatedButton(
            onPressed: onCancelPressed,
            style: ElevatedButton.styleFrom(
              foregroundColor: colorScheme.onError, 
              backgroundColor: colorScheme.error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: Text(
              'Randevuyu İptal Et',
              style: textTheme.labelLarge?.copyWith(color: colorScheme.onError),
            ),
          ),
          //Kaydet butonu
        if (onSavePressed != null)
          ElevatedButton(
            onPressed: onSavePressed,
            style: ElevatedButton.styleFrom(
              foregroundColor: colorScheme.onSecondary, 
              backgroundColor: colorScheme.secondaryContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              elevation: 10,
              shadowColor: colorScheme.shadow,
            ),
            child: Text(
              'Bilgileri Kaydet',
              style: textTheme.titleMedium?.copyWith(color: colorScheme.onSecondary),
            ),
          ),
        const SizedBox(height: 16),
        //çıkış yap butonu
        if (onLogoutPressed != null)
          ElevatedButton(
            onPressed: onLogoutPressed,
            style: ElevatedButton.styleFrom(
              foregroundColor: colorScheme.onError, 
              backgroundColor: colorScheme.errorContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              elevation: 10,
              shadowColor: colorScheme.shadow,
            ),
            child: Text(
              'Çıkış Yap',
              style: textTheme.titleMedium?.copyWith(color: colorScheme.onError),
            ),
          ),
      ],
    );
  }
}

