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
    primary: Colors.blueAccent, // Birincil renk varyantı
    secondary: Colors.cyanAccent, // İkincil renk varyantı
    surface: Colors.white, // Yüzey rengi
    background: Colors.white, // Arka plan rengi
    error: Colors.redAccent, // Hata rengi
    onPrimary: Colors.white, // Birincil rengin üzerine gelen metin/ikonlar için renk
    onSecondary: Colors.black, // İkincil rengin üzerine gelen metin/ikonlar için renk
    onSurface: Colors.black, // Yüzeyin üzerine gelen metin/ikonlar için renk
    onBackground: Colors.black, // Arka planın üzerine gelen metin/ikonlar için renk
    onError: Colors.white, // Hata renginin üzerine gelen metin/ikonlar için renk
    brightness: Brightness.light, // Tema parlaklığı
  );

  return ThemeData(
    textTheme: textTheme,
    primaryColor: Colors.blueAccent,
    colorScheme: colorScheme,
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.blueAccent, // Butonların varsayılan arka plan rengi
      textTheme: ButtonTextTheme.primary, // Buton metin temaları için stil
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: colorScheme.onPrimary, backgroundColor: colorScheme.primary, // Yükseltilmiş buton üzerindeki renk
      ),
    ),
  );
}
