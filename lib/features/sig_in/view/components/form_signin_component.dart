import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../shared/widgets/text_form_field_widget.dart';
import '../../controllers/sig_in_controller.dart';

class FormSignInComponent extends StatelessWidget {
  const FormSignInComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: SigInController.to.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextFormFieldWidget(
            controller: SigInController.to.emailCtrl,
            keyboardType: TextInputType.emailAddress,
            initialValue: SigInController.to.emailValue.value,
            label: "Email Address",
            hint: "Input Email Address",
            isRequired: true,
            requiredText: "Email address cannot be empty",
          ),
          SizedBox(
            height: 20.h,
          ),
          Obx(
            () => TextFormFieldWidget(
              controller: SigInController.to.passwordCtrl,
              keyboardType: TextInputType.visiblePassword,
              initialValue: SigInController.to.passwordValue.value,
              label: "Password",
              hint: "Input Password",
              isRequired: true,
              isPassword: SigInController.to.isPassword.value,
              requiredText: "Password cannot be empty",
              suffixIcon: GestureDetector(
                onTap: () => SigInController.to.showPassword(),
                child: Align(
                  widthFactor: 1.0,
                  heightFactor: 1.0,
                  child: Icon(
                    SigInController.to.isPassword.value == true
                        ? Icons.visibility
                        : Icons.visibility_off,
                    size: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
