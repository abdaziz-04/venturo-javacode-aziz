import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import 'webview_dialog.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy & Policy".tr),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse('https://venturo.id'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(
            const DialogWebview(),
          );
        },
        child: const Icon(Icons.open_in_new),
      ),
    );
  }
}
