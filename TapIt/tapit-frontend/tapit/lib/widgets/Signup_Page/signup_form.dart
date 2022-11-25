import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tapit/views/signupPage2.dart';

import '../../constant.dart';
import '../../controller/SignUpController.dart';
import '../../theme.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final controller = Get.put(RegisterationController());
  final bool _autoValidate = false;
  // final _controller = Get.put(LoginController()); // inject controller

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      autovalidateMode: _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Theme.of(context).primaryColorDark),
            ),
            SizedBox(
              height: 5.h,
            ),
            SizedBox(
              height: 40.h,
              child: TextFormField(
                keyboardType: TextInputType.name,
                controller: controller.nameController,
                autocorrect: false,
                decoration: const InputDecoration(border: OutlineInputBorder(gapPadding: 0)),
                validator: (value) {
                  if (value == null) {
                    return 'Email  is required';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              phoneNumber,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Themes.light.primaryColorDark),
            ),
            SizedBox(
              height: 5.h,
            ),
            SizedBox(
              height: 40.h,
              child: TextFormField(
                keyboardType: TextInputType.phone,
                controller: controller.phoneNumberController,

                validator: ((value) {
                  if (value == null) {
                    return 'Password is required';
                  }
                  return null;
                }),
                //  controller: _userPasswordController,
                //This will obscure text dynamically
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              password,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Theme.of(context).primaryColorDark),
            ),
            SizedBox(height: 5.h),
            SizedBox(
              height: 40.h,
              child: TextFormField(
                // keyboardType: TextInputType.p,

                validator: ((value) {
                  if (value == null) {
                    return 'Password is required';
                  }
                  return null;
                }),
                //  controller: _userPasswordController,
                //This will obscure text dynamically
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  termsAndConditions,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.w100),
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                termsAndConditions2,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Theme.of(context).canvasColor, fontWeight: FontWeight.w900),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.green;
                  }
                  return Theme.of(context).highlightColor;
                })),
                onPressed: () {
                  Get.to(const SignUpScreen2());
                },
                child: Text(
                  contin,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Theme.of(context).backgroundColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
