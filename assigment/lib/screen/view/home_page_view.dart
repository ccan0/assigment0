import 'package:assigment/components/app_bar_card.dart';
import 'package:assigment/components/list_card.dart';
import 'package:assigment/components/search_card.dart';
import 'package:assigment/screen/model/comments_model.dart';
import 'package:assigment/screen/service/comments_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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

  @override
  void initState() {
    CommentsService().getComments().then((value) {
      setState(() {
        viewmodel!.comments = value;
      });
    });

    super.initState();
  }

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
                  AppBarcard(onTap: () {
                    setState(() {
                      viewmodel.isEditFunc();
                    });
                  }),
                  Column(
                    children: <Widget>[
                      SearchCard(
                        controller: viewmodel.searchController,
                        onSubmitted: (String text) {
                          setState(() {
                            viewmodel.searching();
                          });
                        },
                      ),
                      viewmodel.comments.isEmpty
                          ? const CupertinoActivityIndicator()
                          : viewmodel.searchController.text == ''
                              ? SizedBox(
                                  height: dynamicHeight(812),
                                  width: dynamicWidth(375),
                                  child: Observer(builder: (_) {
                                    return RefreshIndicator(
                                      onRefresh: () async {
                                        List<CommentsModel> newComments = await CommentsService().getComments();
                                        viewmodel.comments = newComments;
                                      },
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: viewmodel.comments.length,
                                        itemBuilder: (BuildContext ctxt, int index) {
                                          return ListCard(
                                            body: viewmodel.comments[index].body!,
                                            name: viewmodel.comments[index].name!,
                                            isEdit: viewmodel.isEdit,
                                            cardDeleting: () {
                                              setState(() {
                                                viewmodel.delete(viewmodel.comments[index]);
                                              });
                                            },
                                            email: viewmodel.comments[index].email!,
                                          );
                                        },
                                      ),
                                    );
                                  }),
                                )
                              : SizedBox(
                                  height: dynamicHeight(812),
                                  width: dynamicWidth(375),
                                  child: Observer(builder: (_) {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: viewmodel.searchComments.length,
                                      itemBuilder: (BuildContext ctxt, int index) {
                                        return ListCard(
                                          body: viewmodel.searchComments[index].body!,
                                          name: viewmodel.searchComments[index].name!,
                                          isEdit: viewmodel.isEdit,
                                          cardDeleting: () {
                                            setState(() {
                                              viewmodel.deleteOnSearch(viewmodel.searchComments[index]);
                                            });
                                          },
                                          email: viewmodel.searchComments[index].email!,
                                        );
                                      },
                                    );
                                  }),
                                )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
