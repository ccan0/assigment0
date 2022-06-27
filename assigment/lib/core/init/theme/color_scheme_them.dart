import 'package:flutter/material.dart';
import '../../constants/color/color_constants.dart';

class ColorSchemeTheme {
  //Gerekmediği sürece sınıfın oluşturulamamasını sağlıyoruz
  static ColorSchemeTheme? _instance;
  static ColorSchemeTheme get instance {
    _instance ??= ColorSchemeTheme._init();

    return _instance!;
  }

  ColorSchemeTheme._init();

  ColorScheme colorScheme = ColorScheme(
      primary: ColorConstants.instance.primary,
      secondary: ThemeData.light().colorScheme.secondary,
      surface: ThemeData.light().colorScheme.surface,
      background: ColorConstants.instance.white,
      error: ColorConstants.instance.error,
      onPrimary: ThemeData.light().colorScheme.onPrimary,
      onSecondary: ThemeData.light().colorScheme.onSecondary,
      onSurface: ThemeData.light().colorScheme.onSurface,
      onBackground: ColorConstants.instance.white,
      onError: ThemeData.light().colorScheme.onError,
      brightness: Brightness.light);
}
