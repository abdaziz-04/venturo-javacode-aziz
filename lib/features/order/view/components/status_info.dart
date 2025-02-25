import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

class StatusInfo extends StatelessWidget {
  const StatusInfo({
    super.key,
    required this.detailOrder,
  });

  final Map<String, dynamic> detailOrder;

  @override
  Widget build(BuildContext context) {
    final int status = detailOrder['status'] ?? 0;

    IconData iconData;
    Color iconColor;
    String statusText;

    switch (status) {
      case 0:
        iconData = Icons.access_time_rounded;
        iconColor = ColorStyle.warning;
        statusText = 'Dalam antrian';
        break;
      case 1:
        iconData = Icons.access_time_rounded;
        iconColor = ColorStyle.warning;
        statusText = 'Sedang disiapkan';
        break;
      case 2:
        iconData = Icons.handshake_outlined;
        iconColor = Colors.blue;
        statusText = 'Bisa diambil';
        break;
      case 3:
        iconData = Icons.check_circle;
        iconColor = Colors.green;
        statusText = 'Selesai';
        break;
      case 4:
      default:
        iconData = Icons.close;
        iconColor = Colors.red;
        statusText = 'Dibatalkan';
        break;
    }

    return Row(
      children: [
        Icon(
          iconData,
          size: 18.r,
          color: iconColor,
        ),
        SizedBox(width: 5.w),
        Text(
          statusText,
          style: TextStyle(
            color: iconColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
