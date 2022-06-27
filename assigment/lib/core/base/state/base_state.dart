import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  //Tema verilerini alıyoruz
  ThemeData get themeData => Theme.of(context);

  //Dinamik ölçüleri oluşturuyoruz

  double dynamicHeight(double value) => (value / 812) * MediaQuery.of(context).size.height;
  double dynamicWidth(double value) => (value / 375) * MediaQuery.of(context).size.width;
}
