import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/constants/cores/assets/image_constants.dart';
import 'package:venturo_core/features/rating/constants/rating_assets_constant.dart';

import 'package:venturo_core/features/rating/sub_features/add_rate/controllers/rating_add_rate_controller.dart';
import 'package:venturo_core/features/rating/sub_features/add_rate/view/components/rate_chips.dart';
import 'package:venturo_core/shared/styles/color_style.dart';
import 'package:venturo_core/shared/widgets/custom_app_bar.dart';

class AddRateScreen extends StatelessWidget {
  AddRateScreen({Key? key}) : super(key: key);

  final assetsConstant = RatingAssetsConstant();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Penilaian', showActions: false),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstants.bgPattern2),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: ColorStyle.imgBg,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Berikan Penilaianmu!',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorStyle.black,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RatingBar.builder(
                                initialRating: 3,
                                minRating: 1,
                                itemSize: 30.sp,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  RatingAddRateController.to.rating.value =
                                      rating;
                                },
                              ),
                              Spacer(),
                              Obx(() => Text(
                                    RatingAddRateController.to.keterangan.value,
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      color: ColorStyle.grey.withOpacity(0.5),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorStyle.imgBg,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Apa yang bisa ditingkatkan?',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorStyle.black,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        RateChips(),
                        const Divider(),
                        SizedBox(height: 10.h),
                        Text(
                          'Tulis Review',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorStyle.black,
                          ),
                        ),
                        TextField(
                          maxLines: 3,
                          controller:
                              RatingAddRateController.to.reviewController,
                          decoration: InputDecoration(
                            hintText: 'Tulis ulasanmu disini...',
                            hintStyle: TextStyle(
                              color: ColorStyle.grey.withOpacity(0.5),
                            ),
                            filled: true,
                            fillColor: ColorStyle.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  RatingAddRateController.to.submit();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorStyle.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                child: Text(
                                  'Kirim Penilaian',
                                  style: TextStyle(
                                    color: ColorStyle.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Container(
                              height: 40.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: ColorStyle.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: ColorStyle.primary,
                                ),
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.add_a_photo),
                                color: ColorStyle.primary,
                                iconSize: 20.sp,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
