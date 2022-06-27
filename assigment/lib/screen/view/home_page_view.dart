import 'package:assigment/core/constants/color/color_constants.dart';
import 'package:assigment/screen/model/comments_model.dart';
import 'package:assigment/screen/service/comments_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/base/state/base_state.dart';
import '../../core/base/view/base_view.dart';
import '../view_model/home_page_view_model.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends BaseState<HomePageView> {
  HomePageViewModel? viewmodel;
  List<CommentsModel> comments = [];

  @override
  Widget build(BuildContext context) {
    return BaseView<HomePageViewModel>(
      viewModel: HomePageViewModel(),
      onModelReady: (model) {
        model.init();
        viewmodel = model;
      },
      onPageBuilder: (BuildContext context, HomePageViewModel viewmodel) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: dynamicWidth(375),
                    height: dynamicHeight(150),
                    decoration: BoxDecoration(
                      color: ColorConstants.instance.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: dynamicWidth(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            'Comments',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                          GestureDetector(
                            child: SizedBox(
                              width: dynamicWidth(50),
                              height: dynamicHeight(30),
                              child: Text(
                                'Duzenle',
                                style: TextStyle(color: ColorConstants.instance.primary),
                              ),
                            ),
                            onTap: () => viewmodel.isEditFunc(),
                          )
                        ],
                      ),
                    ),
                  ),
                  buildComments(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  FutureBuilder<List<CommentsModel>> buildComments() {
    return FutureBuilder<List<CommentsModel>>(
      future: CommentsService().getComments(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          comments = snapshot.data!;

          return Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: dynamicHeight(15)),
                child: SizedBox(
                  width: dynamicWidth(350),
                  height: dynamicHeight(50),
                  child: CupertinoSearchTextField(
                    controller: viewmodel!.searchController,
                    onSubmitted: (String text) {
                      viewmodel!.searchComments.clear();
                      comments.forEach((comment) {
                        if (comment.name == viewmodel!.searchController.text) {
                          viewmodel!.searchComments.add(comment);
                        }
                      });
                    },
                  ),
                ),
              ),
              viewmodel!.searchController.text == ''
                  ? SizedBox(
                      height: dynamicHeight(812),
                      width: dynamicWidth(375),
                      child: RefreshIndicator(
                        onRefresh: () async {
                          List<CommentsModel> newComments = await CommentsService().getComments();
                          setState(() {
                            comments = newComments;
                          });
                        },
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: comments.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: dynamicHeight(10), horizontal: dynamicWidth(10)),
                              child: Container(
                                width: dynamicWidth(350),
                                height: dynamicHeight(200),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                  color: ColorConstants.instance.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          SizedBox(
                                            width: dynamicWidth(275),
                                            child: Text(
                                              comments[index].name!,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: viewmodel!.isEdit ? true : false,
                                            child: GestureDetector(
                                              onTap: () {
                                                comments.remove(comments[index]);
                                              },
                                              child: Icon(
                                                Icons.cancel,
                                                color: ColorConstants.instance.primary,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: dynamicHeight(5), bottom: dynamicHeight(17)),
                                        child: SizedBox(
                                          width: dynamicWidth(350),
                                          child: Text(
                                            comments[index].email!,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              color: ColorConstants.instance.secondary,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: dynamicWidth(350),
                                        child: Text(
                                          comments[index].body!,
                                          maxLines: 6,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : SizedBox(
                      height: dynamicHeight(812),
                      width: dynamicWidth(375),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: viewmodel!.searchComments.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: dynamicHeight(10), horizontal: dynamicWidth(10)),
                            child: Container(
                              width: dynamicWidth(350),
                              height: dynamicHeight(200),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                                color: ColorConstants.instance.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        SizedBox(
                                          width: dynamicWidth(275),
                                          child: Text(
                                            viewmodel!.searchComments[index].name,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: viewmodel!.isEdit ? true : false,
                                          child: GestureDetector(
                                            onTap: () {
                                              comments.remove(comments[index]);
                                              viewmodel!.searchComments.remove(viewmodel!.searchComments[index]);
                                            },
                                            child: Icon(
                                              Icons.cancel,
                                              color: ColorConstants.instance.primary,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: dynamicHeight(5), bottom: dynamicHeight(17)),
                                      child: SizedBox(
                                        width: dynamicWidth(350),
                                        child: Text(
                                          viewmodel!.searchComments[index].email,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            color: ColorConstants.instance.secondary,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: dynamicWidth(350),
                                      child: Text(
                                        viewmodel!.searchComments[index].body,
                                        maxLines: 6,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text(
            '${snapshot.error}',
            style: TextStyle(color: ColorConstants.instance.error, fontWeight: FontWeight.bold),
          );
        }
        return const Center(child: CupertinoActivityIndicator());
      },
    );
  }
}
