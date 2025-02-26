import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:venturo_core/constants/cores/assets/image_constants.dart';
import 'package:venturo_core/features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_core/features/checkout/sub_features/edit_menu/controllers/checkout_edit_menu_controller.dart';
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
              color: ColorStyle.dark.withOpacity(0.2),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menu['nama'],
                    style: TextStyle(
                      fontSize: 22.sp,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    'Rp. ${menu['harga'].toString()}',
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: ColorStyle.primary,
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset(ImageConstants.icNotes),
                      SizedBox(width: 5.w),
                      Text(
                        'Catatan',
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
                IconButton(
                  onPressed: () {
                    print('Kurangi jumlah ${menu}');
                    CheckoutEditMenuController.to.qtyDecrement();
                    print(
                        'Jumlah item: ${CheckoutEditMenuController.to.qty.value}');
                  },
                  icon: Icon(
                    Icons.remove_circle_outline,
                    color: ColorStyle.primary,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                Text(
                  menu['quantity'].toString(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    print('Kurangi jumlah ${menu}');
                    CheckoutEditMenuController.to.qtyIncrement();
                    print(
                        'Jumlah item: ${CheckoutEditMenuController.to.qty.value}');
                  },
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: ColorStyle.primary,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
