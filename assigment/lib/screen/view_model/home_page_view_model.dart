import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../core/base/view_model/base_view_model.dart';

part 'home_page_view_model.g.dart';

class HomePageViewModel = _HomePageViewModelBase with _$HomePageViewModel;

abstract class _HomePageViewModelBase with Store, BaseViewModel {
  @override
  void init() {}

  @observable
  bool isEdit = false;

  @observable
  TextEditingController searchController = TextEditingController();

  @observable
  List<dynamic> searchComments = [];

  @action
  void isEditFunc() {
    isEdit = !isEdit;
  }
}
