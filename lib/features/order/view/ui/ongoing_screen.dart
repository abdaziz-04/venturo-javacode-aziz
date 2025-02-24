import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:venturo_core/features/order/view/components/no_data.dart';

class OnGoingScreen extends StatelessWidget {
  OnGoingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NoData(
        info: 'Sudah Pesan? Lacak pesananmu di sini.',
      ),
    );
  }
}
