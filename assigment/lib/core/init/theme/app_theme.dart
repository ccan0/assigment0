import 'package:flutter/material.dart';
import '../../constants/color/color_constants.dart';
import 'color_scheme_them.dart';

class AppTheme {
  //Gerekmediği sürece sınıfın oluşturulamamasını sağlıyoruz
  static AppTheme? _instance;
  static AppTheme get instance {
    _instance ??= AppTheme._init();

    return _instance!;
  }

  AppTheme._init();

  ThemeData get theme => ThemeData.light().copyWith(
        colorScheme: ColorSchemeTheme.instance.colorScheme,
        scaffoldBackgroundColor: ColorConstants.instance.white,
      );
}
