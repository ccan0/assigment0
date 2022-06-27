import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

class BaseView<T extends Store> extends StatefulWidget {
  final T viewModel;
  final Function(T model)? onModelReady;
  final VoidCallback? onDispose;
  final Widget Function(BuildContext context, T value) onPageBuilder;

  const BaseView(
      {Key? key, required this.viewModel, required this.onModelReady, this.onDispose, required this.onPageBuilder})
      : super(key: key);

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends Store> extends State<BaseView<T>> {
  late T model;

  //Sayfa açılınca yapılacak şeyler için
  @override
  void initState() {
    model = widget.viewModel;
    super.initState();
    widget.onModelReady!(model);
  }

  //Sayfadan çıkarken yapılacak şeyler için
  @override
  void dispose() {
    super.dispose();
    if (widget.onDispose != null) widget.onDispose!();
  }

  //Her sayfada kullandığımız widgetlar ve sayfayı kurmamızı yarayan fonksiyonu ekliyoruz
  @override
  Widget build(BuildContext context) {
    return widget.onPageBuilder(context, model);
  }
}
