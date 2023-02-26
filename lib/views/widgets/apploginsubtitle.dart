import 'package:flutter/material.dart';

class AppLoginSubTitle extends StatelessWidget {
  const AppLoginSubTitle({Key? key, required this.subtitle}) : super(key: key);

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 35),
      child: Text(
        subtitle,
        style:  TextStyle(fontSize: 21),
        textAlign: TextAlign.left,
      ),
    );
  }
}
