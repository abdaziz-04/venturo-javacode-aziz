import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

import '../../../list/constants/list_assets_constant.dart';
import '../components/app_bar.dart';

class DetailMenuScreen extends StatelessWidget {
  DetailMenuScreen({Key? key}) : super(key: key);

  final assetsConstant = ListAssetsConstant();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          AppBarD(),
          SizedBox(height: 20),
          Image.network(
            'https://www.attin.co.id/image-product/img330-1698365563.jpg',
            height: 181,
          ),
          SizedBox(height: 10),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 25.w,
                vertical: 20.h,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30.r),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(111, 24, 24, 24),
                    blurRadius: 15,
                    spreadRadius: -1,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Chicken Katsu',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: ColorStyle.primary,
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            width: 250.w,
                            child: Text(
                              'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.remove_circle_outline,
                              color: ColorStyle.primary,
                            ),
                          ),
                          Text('1', style: TextStyle(fontSize: 18)),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.add_circle_outline,
                              color: ColorStyle.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
