import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cached_network_svg_image/cached_network_svg_image.dart';

class MenuCard extends StatelessWidget {
  final Map<String, dynamic> menu;
  final bool isSelected;
  final void Function()? onTap;

  const MenuCard({
    Key? key,
    required this.menu,
    this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imgUrl = menu['foto'] ??
        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png';

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Ink(
        padding: EdgeInsets.all(7.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.transparent,
            width: 2.w,
          ),
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
                color: Colors.grey[100],
              ),
              child: CachedNetworkImage(
                imageUrl: imgUrl,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            // menu info
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menu['nama'] ?? 'No Name',
                    style: Get.textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    menu['harga'].toString(),
                    style: Get.textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  // tes
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
