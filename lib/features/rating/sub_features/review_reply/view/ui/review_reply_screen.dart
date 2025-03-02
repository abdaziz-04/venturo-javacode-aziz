import 'package:flutter/material.dart';
import 'package:venturo_core/constants/cores/assets/image_constants.dart';
import 'package:venturo_core/features/rating/constants/rating_assets_constant.dart';
import 'package:venturo_core/shared/widgets/custom_app_bar.dart';

class ReviewReplyScreen extends StatelessWidget {
  ReviewReplyScreen({Key? key}) : super(key: key);

  final assetsConstant = RatingAssetsConstant();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Balasan Review', showActions: false),
      body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(children: [
            Container(
              width: double.infinity,
              height: 500,
              decoration: BoxDecoration(
                color: Colors.purple,
                image: DecorationImage(
                  image: AssetImage(ImageConstants.bgPattern2),
                  fit: BoxFit.fitHeight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            )
          ])),
    );
  }
}
