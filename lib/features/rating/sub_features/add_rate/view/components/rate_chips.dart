import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/rating/sub_features/add_rate/controllers/rating_add_rate_controller.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

class RateChips extends StatelessWidget {
  RateChips({Key? key}) : super(key: key);

  final RatingAddRateController controller = Get.put(RatingAddRateController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(
        () => Wrap(
          spacing: 8,
          runSpacing: 8,
          children: controller.categories.map((category) {
            final isSelected = controller.selectedCategory.value == category;

            return GestureDetector(
              onTap: () => controller.selectCategory(category),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? ColorStyle.primary : Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  color: isSelected
                      ? ColorStyle.primary.withOpacity(0.1)
                      : ColorStyle.light,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      category,
                      style: TextStyle(
                        color: isSelected ? ColorStyle.primary : Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (isSelected) ...[
                      SizedBox(width: 6.w),
                      Icon(
                        Icons.check,
                        size: 12.sp,
                        color: ColorStyle.primary,
                      ),
                    ],
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
