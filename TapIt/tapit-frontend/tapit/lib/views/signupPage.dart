import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tapit/widgets/Signup_Page/signup_header_widget.dart';

import '../widgets/Signup_Page/signup_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset("assets/Sign_in.png"),
            ),
            SizedBox(height: 40.h),
            Container(
              padding: EdgeInsets.all(20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SignUpHeader(),
                  SizedBox(height: 20.h),
                  const SignUpForm(),
                  // const SignUpFooterWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
