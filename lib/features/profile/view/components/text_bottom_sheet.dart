import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:venturo_core/shared/styles/color_style.dart';

class TextBottomSheet extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final Function()? onTap;
  final bool isPassword;

  const TextBottomSheet({
    Key? key,
    required this.controller,
    required this.title,
    required this.hintText,
    this.isPassword = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorStyle.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      height: 180,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Center(
              child: Container(
                width: 104,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                    child: TextField(
                  obscureText: isPassword,
                  controller: controller,
                  keyboardType:
                      isPassword ? TextInputType.number : TextInputType.text,
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: UnderlineInputBorder(),
                  ),
                )),
                IconButton(
                    onPressed: () {
                      onTap!();
                      Get.back();
                    },
                    icon: Icon(
                      Icons.check_circle,
                      color: ColorStyle.primary,
                      size: 40.sp,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
