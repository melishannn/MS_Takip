import "package:flutter/material.dart";
//figmadan gelen renkler projeye uygulanmadı
class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff006a6a),
      surfaceTint: Color(0xff006a6a),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff9cf1f0),
      onPrimaryContainer: Color(0xff002020),
      secondary: Color(0xff006a69),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff9cf1ef),
      onSecondaryContainer: Color(0xff002020),
      tertiary: Color(0xff4b607c),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffd3e4ff),
      onTertiaryContainer: Color(0xff041c35),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xfff4fbfa),
      onBackground: Color(0xff161d1d),
      surface: Color(0xfff4fbfa),
      onSurface: Color(0xff161d1d),
      surfaceVariant: Color(0xffdae5e4),
      onSurfaceVariant: Color(0xff3f4948),
      outline: Color(0xff6f7979),
      outlineVariant: Color(0xffbec9c8),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3231),
      inverseOnSurface: Color(0xffecf2f1),
      inversePrimary: Color(0xff80d5d4),
      primaryFixed: Color(0xff9cf1f0),
      onPrimaryFixed: Color(0xff002020),
      primaryFixedDim: Color(0xff80d5d4),
      onPrimaryFixedVariant: Color(0xff004f4f),
      secondaryFixed: Color(0xff9cf1ef),
      onSecondaryFixed: Color(0xff002020),
      secondaryFixedDim: Color(0xff80d5d3),
      onSecondaryFixedVariant: Color(0xff00504f),
      tertiaryFixed: Color(0xffd3e4ff),
      onTertiaryFixed: Color(0xff041c35),
      tertiaryFixedDim: Color(0xffb3c8e8),
      onTertiaryFixedVariant: Color(0xff334863),
      surfaceDim: Color(0xffd5dbda),
      surfaceBright: Color(0xfff4fbfa),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f4),
      surfaceContainer: Color(0xffe9efee),
      surfaceContainerHigh: Color(0xffe3e9e9),
      surfaceContainerHighest: Color(0xffdde4e3),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff004b4b),
      surfaceTint: Color(0xff006a6a),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff238181),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff004b4b),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff238180),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff2f445f),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff617693),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff4fbfa),
      onBackground: Color(0xff161d1d),
      surface: Color(0xfff4fbfa),
      onSurface: Color(0xff161d1d),
      surfaceVariant: Color(0xffdae5e4),
      onSurfaceVariant: Color(0xff3b4544),
      outline: Color(0xff576161),
      outlineVariant: Color(0xff737d7c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3231),
      inverseOnSurface: Color(0xffecf2f1),
      inversePrimary: Color(0xff80d5d4),
      primaryFixed: Color(0xff238181),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff006767),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff238180),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff006766),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff617693),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff495d79),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd5dbda),
      surfaceBright: Color(0xfff4fbfa),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f4),
      surfaceContainer: Color(0xffe9efee),
      surfaceContainerHigh: Color(0xffe3e9e9),
      surfaceContainerHighest: Color(0xffdde4e3),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff002727),
      surfaceTint: Color(0xff006a6a),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff004b4b),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff002727),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff004b4b),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff0c233c),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff2f445f),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff4fbfa),
      onBackground: Color(0xff161d1d),
      surface: Color(0xfff4fbfa),
      onSurface: Color(0xff000000),
      surfaceVariant: Color(0xffdae5e4),
      onSurfaceVariant: Color(0xff1c2625),
      outline: Color(0xff3b4544),
      outlineVariant: Color(0xff3b4544),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3231),
      inverseOnSurface: Color(0xffffffff),
      inversePrimary: Color(0xffa6fbfa),
      primaryFixed: Color(0xff004b4b),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003333),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff004b4b),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff003332),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff2f445f),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff182e47),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd5dbda),
      surfaceBright: Color(0xfff4fbfa),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f4),
      surfaceContainer: Color(0xffe9efee),
      surfaceContainerHigh: Color(0xffe3e9e9),
      surfaceContainerHighest: Color(0xffdde4e3),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xff80d5d4),
      surfaceTint: Color(0xff80d5d4),
      onPrimary: Color(0xff003737),
      primaryContainer: Color(0xff004f4f),
      onPrimaryContainer: Color(0xff9cf1f0),
      secondary: Color(0xff80d5d3),
      onSecondary: Color(0xff003736),
      secondaryContainer: Color(0xff00504f),
      onSecondaryContainer: Color(0xff9cf1ef),
      tertiary: Color(0xffb3c8e8),
      onTertiary: Color(0xff1c314b),
      tertiaryContainer: Color(0xff334863),
      onTertiaryContainer: Color(0xffd3e4ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff0e1514),
      onBackground: Color(0xffdde4e3),
      surface: Color(0xff0e1514),
      onSurface: Color(0xffdde4e3),
      surfaceVariant: Color(0xff3f4948),
      onSurfaceVariant: Color(0xffbec9c8),
      outline: Color(0xff889392),
      outlineVariant: Color(0xff3f4948),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde4e3),
      inverseOnSurface: Color(0xff2b3231),
      inversePrimary: Color(0xff006a6a),
      primaryFixed: Color(0xff9cf1f0),
      onPrimaryFixed: Color(0xff002020),
      primaryFixedDim: Color(0xff80d5d4),
      onPrimaryFixedVariant: Color(0xff004f4f),
      secondaryFixed: Color(0xff9cf1ef),
      onSecondaryFixed: Color(0xff002020),
      secondaryFixedDim: Color(0xff80d5d3),
      onSecondaryFixedVariant: Color(0xff00504f),
      tertiaryFixed: Color(0xffd3e4ff),
      onTertiaryFixed: Color(0xff041c35),
      tertiaryFixedDim: Color(0xffb3c8e8),
      onTertiaryFixedVariant: Color(0xff334863),
      surfaceDim: Color(0xff0e1514),
      surfaceBright: Color(0xff343a3a),
      surfaceContainerLowest: Color(0xff090f0f),
      surfaceContainerLow: Color(0xff161d1d),
      surfaceContainer: Color(0xff1a2121),
      surfaceContainerHigh: Color(0xff252b2b),
      surfaceContainerHighest: Color(0xff2f3636),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xff84d9d8),
      surfaceTint: Color(0xff80d5d4),
      onPrimary: Color(0xff001a1a),
      primaryContainer: Color(0xff479e9d),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xff84d9d7),
      onSecondary: Color(0xff001a1a),
      secondaryContainer: Color(0xff479e9d),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffb7cced),
      onTertiary: Color(0xff00172f),
      tertiaryContainer: Color(0xff7d92b1),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff0e1514),
      onBackground: Color(0xffdde4e3),
      surface: Color(0xff0e1514),
      onSurface: Color(0xfff6fcfb),
      surfaceVariant: Color(0xff3f4948),
      onSurfaceVariant: Color(0xffc2cdcc),
      outline: Color(0xff9ba5a4),
      outlineVariant: Color(0xff7b8585),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde4e3),
      inverseOnSurface: Color(0xff252b2b),
      inversePrimary: Color(0xff005151),
      primaryFixed: Color(0xff9cf1f0),
      onPrimaryFixed: Color(0xff001414),
      primaryFixedDim: Color(0xff80d5d4),
      onPrimaryFixedVariant: Color(0xff003d3d),
      secondaryFixed: Color(0xff9cf1ef),
      onSecondaryFixed: Color(0xff001414),
      secondaryFixedDim: Color(0xff80d5d3),
      onSecondaryFixedVariant: Color(0xff003d3d),
      tertiaryFixed: Color(0xffd3e4ff),
      onTertiaryFixed: Color(0xff001226),
      tertiaryFixedDim: Color(0xffb3c8e8),
      onTertiaryFixedVariant: Color(0xff223751),
      surfaceDim: Color(0xff0e1514),
      surfaceBright: Color(0xff343a3a),
      surfaceContainerLowest: Color(0xff090f0f),
      surfaceContainerLow: Color(0xff161d1d),
      surfaceContainer: Color(0xff1a2121),
      surfaceContainerHigh: Color(0xff252b2b),
      surfaceContainerHighest: Color(0xff2f3636),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffeafffe),
      surfaceTint: Color(0xff80d5d4),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff84d9d8),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffeafffe),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xff84d9d7),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffafaff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffb7cced),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff0e1514),
      onBackground: Color(0xffdde4e3),
      surface: Color(0xff0e1514),
      onSurface: Color(0xffffffff),
      surfaceVariant: Color(0xff3f4948),
      onSurfaceVariant: Color(0xfff3fdfc),
      outline: Color(0xffc2cdcc),
      outlineVariant: Color(0xffc2cdcc),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde4e3),
      inverseOnSurface: Color(0xff000000),
      inversePrimary: Color(0xff003030),
      primaryFixed: Color(0xffa0f5f5),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff84d9d8),
      onPrimaryFixedVariant: Color(0xff001a1a),
      secondaryFixed: Color(0xffa0f6f4),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xff84d9d7),
      onSecondaryFixedVariant: Color(0xff001a1a),
      tertiaryFixed: Color(0xffdae8ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffb7cced),
      onTertiaryFixedVariant: Color(0xff00172f),
      surfaceDim: Color(0xff0e1514),
      surfaceBright: Color(0xff343a3a),
      surfaceContainerLowest: Color(0xff090f0f),
      surfaceContainerLow: Color(0xff161d1d),
      surfaceContainer: Color(0xff1a2121),
      surfaceContainerHigh: Color(0xff252b2b),
      surfaceContainerHighest: Color(0xff2f3636),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );

  /// Custom Color
  static const customColor = ExtendedColor(
    seed: Color(0xff3f7ec7),
    value: Color(0xff3f7ec7),
    light: ColorFamily(
      color: Color(0xff3a608f),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffd3e3ff),
      onColorContainer: Color(0xff001c39),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff3a608f),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffd3e3ff),
      onColorContainer: Color(0xff001c39),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff3a608f),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffd3e3ff),
      onColorContainer: Color(0xff001c39),
    ),
    dark: ColorFamily(
      color: Color(0xffa4c9fe),
      onColor: Color(0xff00315d),
      colorContainer: Color(0xff204876),
      onColorContainer: Color(0xffd3e3ff),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffa4c9fe),
      onColor: Color(0xff00315d),
      colorContainer: Color(0xff204876),
      onColorContainer: Color(0xffd3e3ff),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffa4c9fe),
      onColor: Color(0xff00315d),
      colorContainer: Color(0xff204876),
      onColorContainer: Color(0xffd3e3ff),
    ),
  );


  List<ExtendedColor> get extendedColors => [
    customColor,
  ];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary, 
    required this.surfaceTint, 
    required this.onPrimary, 
    required this.primaryContainer, 
    required this.onPrimaryContainer, 
    required this.secondary, 
    required this.onSecondary, 
    required this.secondaryContainer, 
    required this.onSecondaryContainer, 
    required this.tertiary, 
    required this.onTertiary, 
    required this.tertiaryContainer, 
    required this.onTertiaryContainer, 
    required this.error, 
    required this.onError, 
    required this.errorContainer, 
    required this.onErrorContainer, 
    required this.background, 
    required this.onBackground, 
    required this.surface, 
    required this.onSurface, 
    required this.surfaceVariant, 
    required this.onSurfaceVariant, 
    required this.outline, 
    required this.outlineVariant, 
    required this.shadow, 
    required this.scrim, 
    required this.inverseSurface, 
    required this.inverseOnSurface, 
    required this.inversePrimary, 
    required this.primaryFixed, 
    required this.onPrimaryFixed, 
    required this.primaryFixedDim, 
    required this.onPrimaryFixedVariant, 
    required this.secondaryFixed, 
    required this.onSecondaryFixed, 
    required this.secondaryFixedDim, 
    required this.onSecondaryFixedVariant, 
    required this.tertiaryFixed, 
    required this.onTertiaryFixed, 
    required this.tertiaryFixedDim, 
    required this.onTertiaryFixedVariant, 
    required this.surfaceDim, 
    required this.surfaceBright, 
    required this.surfaceContainerLowest, 
    required this.surfaceContainerLow, 
    required this.surfaceContainer, 
    required this.surfaceContainerHigh, 
    required this.surfaceContainerHighest, 
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
