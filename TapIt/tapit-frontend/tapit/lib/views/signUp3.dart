import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tapit/widgets/Signup_Page2/gradient_eclipse_sign_up2.dart';
import 'package:tapit/widgets/Signup_Page3/sign_up_page_header.dart';
import 'package:tapit/widgets/Signup_Page3/signup_3_form.dart';

class SignUpScreen3 extends StatefulWidget {
  const SignUpScreen3({super.key});

  @override
  State<SignUpScreen3> createState() => _SignUpScreen3State();
}

class _SignUpScreen3State extends State<SignUpScreen3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GradientEclipse2(
              heigt: 80.h,
            ),
            SizedBox(height: 40.h),
            Container(
              padding: EdgeInsets.all(20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SignUpPageHeader3(),
                  SizedBox(height: 20.h),
                  const SignUp3Form(),
                  // const LoginFooterWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
