import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tapit/views/map_screen.dart';

import '../../constant.dart';

class SignUp3Form extends StatefulWidget {
  const SignUp3Form({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUp3Form> createState() => _SignUp3FormState();
}

class _SignUp3FormState extends State<SignUp3Form> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  Widget formBox(String hinttext, double height, double width, TextInputType textInputType, double? sbHeight,
      double? sbWidth, String text, EdgeInsetsGeometry padding) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: sbHeight,
          width: sbWidth,
        ),
        text != ""
            ? Text(
                text,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Theme.of(context).primaryColorDark),
              )
            : const SizedBox.shrink(),
        SizedBox(
          height: 5.h,
        ),
        SizedBox(
          height: height,
          width: width,
          child: TextFormField(
            // controller: signUpcontroller,s
            keyboardType: textInputType,
            autocorrect: false,
            decoration:
                InputDecoration(contentPadding: padding, hintText: hinttext, border: const OutlineInputBorder()),
            validator: (value) {
              if (value == null) {
                return 'Email  is required';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget Button(double width, Color color, String text, Color textColor, void Function() a) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: color, side: const BorderSide(width: 1.0)),
          onPressed: () {
            Get.to(const MapScreen());
          },
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: textColor),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      // autovalidateMode: _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            formBox(
              "Street/Society/City",
              80.h,
              double.infinity,
              TextInputType.streetAddress,
              0.h,
              0.w,
              "Address",
              EdgeInsets.all(10.h),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                formBox("District", 40.h, 150.w, TextInputType.streetAddress, 0.h, 0.h, "", const EdgeInsets.all(10)),
                formBox("State", 40.h, 150.w, TextInputType.streetAddress, 0.h, 0.h, "", const EdgeInsets.all(10)),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            formBox("", 40.h, double.infinity, TextInputType.phone, 0.h, 0.w, trelative1, EdgeInsets.all(10.h)),
            SizedBox(
              height: 20.h,
            ),
            formBox("", 40.h, double.infinity, TextInputType.phone, 0.h, 0.w, trelative2, EdgeInsets.all(10.h)),
            SizedBox(
              height: 20.h,
            ),
            Button(double.infinity, Theme.of(context).highlightColor, tsignIn, Theme.of(context).backgroundColor, () {
              Get.to(const MapScreen());
            }),
            Button(double.infinity, Theme.of(context).backgroundColor, goBack, Theme.of(context).primaryColorDark, () {
              Get.back();
            }),
          ],
        ),
      ),
    );
  }
}
