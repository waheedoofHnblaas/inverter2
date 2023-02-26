


import 'package:flutter/material.dart';


class AppLoginSignUp extends StatelessWidget {
  const AppLoginSignUp({Key? key, required this.textone, required this.texttwo, this.onPressed}) : super(key: key);

  final String textone;
  final String texttwo;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          textone,
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            texttwo,
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
