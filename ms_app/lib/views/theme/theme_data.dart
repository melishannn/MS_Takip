import 'package:flutter/material.dart';

ThemeData buildThemeData() {
  // Metin stillerini tanımlama
  TextTheme textTheme = const TextTheme(
    displayLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.blue),
    displayMedium: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.blue),
    displaySmall: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
    headlineSmall: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
    titleLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
    titleSmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
    bodyMedium: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal),
    labelLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, letterSpacing: 1.25),
    bodySmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal),
    labelSmall: TextStyle(fontSize: 10.0, fontWeight: FontWeight.normal, letterSpacing: 1.5),
  );

  // Renk şemasını tanımlama
  ColorScheme colorScheme = const ColorScheme(
    primary: Color(0xff006a6a),
    primaryContainer: Color(0xff9cf1f0),
    secondary: Color(0xff006a69),
    secondaryContainer: Color(0xff9cf1ef),
    surface: Color(0xfff4fbfa),
    background: Color(0xfff4fbfa),
    error: Color(0xffba1a1a),
    onError: Color(0xffffffff),
    onPrimary: Color(0xffffffff),
    onSecondary: Color(0xffffffff),
    onSurface: Color(0xff161d1d),
    onBackground: Color(0xff161d1d),
    brightness: Brightness.light,
  );

  return ThemeData(
    textTheme: textTheme,
    primaryColor: const Color(0xff006a6a),
    colorScheme: colorScheme,
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xff006a6a), // Butonların varsayılan arka plan rengi
      textTheme: ButtonTextTheme.primary, // Buton metin temaları için stil
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: colorScheme.onPrimary, backgroundColor: colorScheme.primary, // Yükseltilmiş buton üzerindeki renk
      ),
    ),
  );
}
