import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tapit/widgets/Signup_Page2/gradient_eclipse_sign_up2.dart';
import 'package:tapit/widgets/Signup_Page2/sign_up2_form.dart';
import 'package:tapit/widgets/Signup_Page2/signup_page2_header.dart';

class SignUpScreen2 extends StatefulWidget {
  const SignUpScreen2({super.key});

  @override
  State<SignUpScreen2> createState() => _SignUpScreen2();
}

class _SignUpScreen2 extends State<SignUpScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GradientEclipse2(
              heigt: 120.h,
            ),
            SizedBox(height: 40.h),
            Container(
              padding: EdgeInsets.all(20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SignUpScreen2Header(),
                  SizedBox(height: 20.h),
                  const SignUp2Form(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
