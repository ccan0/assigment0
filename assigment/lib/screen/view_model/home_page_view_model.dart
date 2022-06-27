import 'package:assigment/screen/model/comments_model.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../core/base/view_model/base_view_model.dart';

part 'home_page_view_model.g.dart';

class HomePageViewModel = _HomePageViewModelBase with _$HomePageViewModel;

abstract class _HomePageViewModelBase with Store, BaseViewModel {
  @override
  void init() {}

  @observable
  List<CommentsModel> searchComments = [];

  @observable
  List<CommentsModel> comments = [];

  @observable
  bool isEdit = false;

  @observable
  TextEditingController searchController = TextEditingController();

  @action
  void isEditFunc() {
    isEdit = !isEdit;
  }

  @action
  void searching() {
    comments.forEach((comment) {
      if (searchController.text == comment.name) {
        searchComments.add(comment);
      }
    });
  }

  @action
  void delete(CommentsModel comment) {
    comments.remove(comment);
  }

  @action
  void deleteOnSearch(CommentsModel comment) {
    comments.remove(comment);
    searchComments.remove(comment);
  }
}
