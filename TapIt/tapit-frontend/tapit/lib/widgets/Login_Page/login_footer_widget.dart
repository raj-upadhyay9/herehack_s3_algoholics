import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tapit/views/signupPage.dart';

import '../../constant.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            Get.to(const SignUpScreen());
          },
          child: Text.rich(
            TextSpan(text: tDontHaveAnAccount, style: Theme.of(context).textTheme.bodyText1, children: [
              TextSpan(
                  text: tSignup,
                  style: TextStyle(color: Theme.of(context).canvasColor).copyWith(fontWeight: FontWeight.bold))
            ]),
          ),
        ),
      ],
    );
  }
}
