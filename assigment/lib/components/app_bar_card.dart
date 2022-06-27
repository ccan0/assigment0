import 'package:assigment/core/base/state/base_state.dart';
import 'package:flutter/material.dart';

import '../core/constants/color/color_constants.dart';

class AppBarcard extends StatefulWidget {
  final VoidCallback onTap;

  const AppBarcard({Key? key, required this.onTap}) : super(key: key);

  @override
  State<AppBarcard> createState() => _AppBarcardState();
}

class _AppBarcardState extends BaseState<AppBarcard> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              onTap: widget.onTap,
              child: SizedBox(
                child: Text(
                  'Duzenle',
                  style: TextStyle(color: ColorConstants.instance.primary),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
