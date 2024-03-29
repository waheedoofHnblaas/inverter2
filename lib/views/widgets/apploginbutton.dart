import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSignUpAndLoginButton extends StatelessWidget {
  AppSignUpAndLoginButton(
      {required this.text, required this.onPressed, Key? key});

  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(

        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(18),
      ),

      width: context.width/1.4,
      margin: const EdgeInsets.symmetric(vertical: 11),
      child: MaterialButton(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 11),
        onPressed: onPressed,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontFamily: 'Cairo'),
        ),
      ),
    );
  }
}
