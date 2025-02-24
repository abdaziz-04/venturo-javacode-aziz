import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class PinDialog extends StatefulWidget {
  final String pin;

  const PinDialog({
    Key? key,
    required this.pin,
  }) : super(key: key);

  @override
  State<PinDialog> createState() => _PinDialogState();
}

class _PinDialogState extends State<PinDialog> {
  final RxBool obscure = RxBool(true);
  final RxnString errorText = RxnString();
  final TextEditingController controller = TextEditingController();

  int tries = 0;

  Future<void> processPin(String? pin) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (pin == widget.pin) {
      // Jika PIN benar, tutup dialog dan kirim 'true'
      Get.back<bool>(result: true);
    } else {
      // Jika PIN salah
      tries++;

      if (tries >= 3) {
        // Jika lebih dari 3 kali, tutup dialog dan kirim 'false'
        Get.back<bool>(result: false);
      } else {
        // Tampilkan sisa percobaan
        controller.clear();
        errorText.value = 'PIN wrong! n chances left.'.trParams({
          'n': (3 - tries).toString(),
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 34.w,
      height: 50.h,
      textStyle: Get.textTheme.titleLarge,
      margin: EdgeInsets.symmetric(horizontal: 3.w),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(10.r),
      ),
    );

    return Dialog(
      // Warna latar belakang dialog
      backgroundColor: Colors.white,
      // Bentuk dialog membulat
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 6.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Judul
            Text(
              'Verify order',
              style: Get.textTheme.labelLarge,
            ),

            // Subjudul
            Text(
              'Enter PIN code',
              style: Get.textTheme.bodySmall!.copyWith(color: Colors.black),
            ),

            24.verticalSpacingRadius,

            // Input PIN
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => Expanded(
                    child: Pinput(
                      controller: controller,
                      showCursor: false,
                      length: 6,
                      autofocus: true,
                      separator: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        child: ColoredBox(
                          color: Colors.black,
                          child: SizedBox(width: 9.w, height: 2.h),
                        ),
                      ),
                      separatorPositions: const [2, 4],
                      closeKeyboardWhenCompleted: false,
                      defaultPinTheme: defaultPinTheme,
                      obscureText: obscure.value,
                      onSubmitted: processPin,
                      onCompleted: processPin,
                    ),
                  ),
                ),

                10.horizontalSpace,

                // Tombol untuk toggle show/hide PIN
                Obx(
                  () => InkWell(
                    radius: 24.r,
                    onTap: () => obscure.value = !obscure.value,
                    child: Icon(
                      obscure.value ? Icons.visibility : Icons.visibility_off,
                      color: Theme.of(context).primaryColor,
                      size: 20.r,
                    ),
                  ),
                ),
              ],
            ),

            // Pesan error
            Obx(
              () => errorText.value != null
                  ? Padding(
                      padding:
                          EdgeInsets.only(left: 15.r, right: 15.r, top: 10.r),
                      child: Text(
                        errorText.value!,
                        style: Get.textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
