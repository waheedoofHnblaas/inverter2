import 'package:flutter/material.dart';

class AppBatteryTypeButton extends StatelessWidget {
  const AppBatteryTypeButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
  });

  final String text;
  final Color color;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(18),
        ),
        child: MaterialButton(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(fontFamily: 'Cairo'),
          ),
        ),
      ),
    );
  }
}
