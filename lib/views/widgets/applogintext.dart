import 'package:flutter/material.dart';

class AppLoginTitel extends StatelessWidget {
  const AppLoginTitel({Key? key,required this.title}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
      ),
    );
  }
}
