import 'package:assigment/core/base/state/base_state.dart';
import 'package:flutter/cupertino.dart';

class SearchCard extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onSubmitted;

  const SearchCard({Key? key, required this.controller, required this.onSubmitted}) : super(key: key);

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends BaseState<SearchCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: dynamicHeight(15)),
      child: SizedBox(
        width: dynamicWidth(350),
        height: dynamicHeight(50),
        child: CupertinoSearchTextField(
          controller: widget.controller,
          onSubmitted: widget.onSubmitted,
        ),
      ),
    );
  }
}
