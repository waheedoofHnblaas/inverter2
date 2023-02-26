import 'package:flutter/material.dart';

class AppSliverAppBar extends StatelessWidget {
  const AppSliverAppBar({required this.title,this.action});

  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      actions: [action??Container()],
      backgroundColor: Colors.white,
      elevation: 0,
      pinned: true,
      foregroundColor: Colors.black,
      centerTitle: true,
      title: Text(title),
    );
  }
}
