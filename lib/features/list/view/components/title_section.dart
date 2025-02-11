import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/styles/color_style.dart';

class TitleSection extends StatelessWidget {
  const TitleSection({
    super.key,
    required this.title,
    this.image,
  });

  final String title;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
      child: Row(
        children: [
          if (image != null)
            Image(
              image: AssetImage(image!),
              width: 50.w,
            ),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorStyle.primary,
            ),
          ),
        ],
      ),
    );
  }
}
