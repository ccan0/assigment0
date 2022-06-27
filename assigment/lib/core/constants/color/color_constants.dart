import 'package:flutter/material.dart';

class ColorConstants {
  //Gerekmediği sürece sınıfın oluşturulamamasını sağlıyoruz
  static ColorConstants? _instance;
  static ColorConstants get instance {
    _instance ??= ColorConstants._init();

    return _instance!;
  }

  ColorConstants._init();

  Color secondary = const Color(0xFFE5E5E5);
  Color primary = const Color(0xFF1087F4);
  Color white = const Color(0xFFFFFFFF);
  Color error = const Color.fromARGB(255, 199, 0, 0);
}
