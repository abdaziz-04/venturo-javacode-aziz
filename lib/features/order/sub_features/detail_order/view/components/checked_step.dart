import 'package:flutter/material.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

class CheckedStep extends StatelessWidget {
  const CheckedStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorStyle.primary,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 2),
                blurRadius: 8,
                spreadRadius: -2,
                color: ColorStyle.black)
          ]),
      child: Icon(
        Icons.check,
        color: ColorStyle.white,
        size: 25,
      ),
    );
  }
}
