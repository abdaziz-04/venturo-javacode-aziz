import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/configs/routes/route.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

class RatingCard extends StatelessWidget {
  final Map<String, dynamic> rateItem;
  RatingCard({super.key, required this.rateItem});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 10.w),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: ColorStyle.imgBg,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  width: 300.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month_outlined,
                            color: ColorStyle.primary,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            rateItem['category'],
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: ColorStyle.primary,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          RatingBarIndicator(
                            itemBuilder: (context, index) {
                              return Icon(
                                Icons.star,
                                color: Colors.amber,
                              );
                            },
                            itemSize: 20.sp,
                            rating: rateItem['rating'],
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        rateItem['review'],
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: ColorStyle.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () => Get.toNamed(Routes.reviewReplyRoute),
                  icon: Icon(
                    Icons.reply,
                    color: Colors.green,
                    size: 30.sp,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
