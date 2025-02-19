import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/constants/cores/assets/image_constants.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

class CheckoutMenuCard extends StatelessWidget {
  final Map<String, dynamic> menu;
  final bool isSelected;
  final void Function()? onTap;

  const CheckoutMenuCard({
    Key? key,
    required this.menu,
    this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Ink(
        padding: EdgeInsets.all(7.r),
        decoration: BoxDecoration(
          color: ColorStyle.light,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.transparent,
            width: 2.w,
          ),
          boxShadow: [
            BoxShadow(
              color: ColorStyle.dark.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // menu image
            Container(
              height: 90.h,
              width: 90.w,
              margin: EdgeInsets.only(right: 12.r),
              padding: EdgeInsets.all(5.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: ColorStyle.imgBg,
              ),
              child: CachedNetworkImage(
                imageUrl: menu['foto'] ??
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
                useOldImageOnUrlChange: true,
                fit: BoxFit.contain,
              ),
            ),
            // menu info
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menu['nama'],
                    style: TextStyle(
                      fontSize: 23.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    menu['harga'].toString(),
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: ColorStyle.primary,
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset(ImageConstants.icNotes),
                      SizedBox(width: 5.w),
                      Text(
                        'Tambahkan Catatan',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: ColorStyle.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // menu quantity
            Row(
              children: [
                Image.asset(ImageConstants.icDecrease),
                SizedBox(width: 7.w),
                Text(
                  '1',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 7.w),
                Image.asset(ImageConstants.icIncrease),
              ],
            )
          ],
        ),
      ),
    );
  }
}
