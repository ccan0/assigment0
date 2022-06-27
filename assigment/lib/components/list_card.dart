import 'package:assigment/core/base/state/base_state.dart';
import 'package:flutter/material.dart';

import '../core/constants/color/color_constants.dart';

class ListCard extends StatefulWidget {
  final String body;
  final String name;
  final bool isEdit;
  final VoidCallback cardDeleting;
  final String email;

  const ListCard(
      {Key? key,
      required this.body,
      required this.name,
      required this.isEdit,
      required this.cardDeleting,
      required this.email})
      : super(key: key);

  @override
  State<ListCard> createState() => _ListCardState();
}

class _ListCardState extends BaseState<ListCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: dynamicHeight(10), horizontal: dynamicWidth(10)),
      child: Container(
        width: dynamicWidth(350),
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
                      widget.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.isEdit ? true : false,
                    child: GestureDetector(
                      onTap: widget.cardDeleting,
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
                    widget.email,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.grey.shade700,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: dynamicWidth(350),
                child: Text(
                  widget.body,
                  style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
