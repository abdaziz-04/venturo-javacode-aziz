import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:venturo_core/constants/cores/assets/image_constants.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

class OrderMenuCard extends StatelessWidget {
  final Map<String, dynamic> menu;
  final bool isSelected;

  const OrderMenuCard({
    Key? key,
    required this.menu,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: EdgeInsets.all(7.r),
      decoration: BoxDecoration(
        color: ColorStyle.light,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color:
              isSelected ? Theme.of(context).primaryColor : Colors.transparent,
          width: 2.w,
        ),
        boxShadow: [
          BoxShadow(
            color: ColorStyle.dark.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
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
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  menu['nama'],
                  style: TextStyle(
                    fontSize: 25.sp,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  'Rp. ${menu['harga'].toString()}',
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: ColorStyle.primary,
                  ),
                ),
                Row(
                  children: [
                    Image.asset(ImageConstants.icNotes),
                    SizedBox(width: 5.w),
                    Text(
                      menu['catatan'] ?? 'Tidak ada catatan',
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
          // s
          SizedBox(
            height: 90.h,
            child: VerticalDivider(
              color: ColorStyle.imgBg,
              thickness: 1.w,
              width: 1.w,
              indent: 5.h,
              endIndent: 5.h,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Text(
              menu['jumlah'].toString(),
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorStyle.primary),
            ),
          ),
        ],
      ),
    );
  }
}
