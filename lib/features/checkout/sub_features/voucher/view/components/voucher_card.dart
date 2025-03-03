import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/checkout/sub_features/voucher/controllers/checkout_voucher_controller.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

class VoucherCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final void Function()? onTap;

  const VoucherCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 225.h,
        decoration: BoxDecoration(
          color: ColorStyle.imgBg,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10.w,
                ),
                Text(item['nama'], style: TextStyle(fontSize: 18.sp)),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      CheckoutVoucherController.to.addVoucher(item);
                    },
                    icon: Obx(() => Icon(
                          CheckoutVoucherController.to.selectedVoucher
                                  .contains(item)
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: ColorStyle.primary,
                        )))
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                item['info_voucher'],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
