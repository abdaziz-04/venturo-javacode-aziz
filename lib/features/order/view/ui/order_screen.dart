import 'package:flutter/material.dart';
import 'package:venturo_core/features/order/view/components/checked_step.dart';
import 'package:venturo_core/features/order/view/components/date_picker.dart';
import 'package:venturo_core/features/order/view/components/detail_order_card.dart';

import '../../constants/order_assets_constant.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({Key? key}) : super(key: key);

  final assetsConstant = OrderAssetsConstant();
  final DateTimeRange selectedDate = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(const Duration(days: 7)),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        CheckedStep(),
        DatePicker(
          onChanged: (newDate) {},
          selectedDate: selectedDate,
        ),
        DetailOrderCard({}),
      ],
    ));
  }
}
