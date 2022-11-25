import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tapit/views/signUp3.dart';

import '../../constant.dart';
import '../../controller/LoginController.dart';

class SignUp2Form extends StatefulWidget {
  const SignUp2Form({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUp2Form> createState() => _SignUp2FormState();
}

class _SignUp2FormState extends State<SignUp2Form> {
  final bool _autoValidate = false;
  final _controller = Get.put(LoginController()); // inject controller

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool _passwordVisible = false;
  @override
  void initState() {
    _passwordVisible = false;
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Male", child: Text("Male")),
      const DropdownMenuItem(value: "Female", child: Text("Female")),
      const DropdownMenuItem(value: "Others", child: Text("Others")),
    ];
    return menuItems;
  }

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tage,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Theme.of(context).primaryColorDark),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    SizedBox(
                      height: 40.h,
                      width: 150.w,
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
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
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tbloodGroup,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Theme.of(context).primaryColorDark),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    SizedBox(
                      height: 40.h,
                      width: 150.w,
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
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
                  ],
                )
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tgender,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Theme.of(context).primaryColorDark),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    SizedBox(
                      height: 40.h,
                      width: 150.w,
                      child: DropdownButtonFormField(
                        isDense: false,
                        dropdownColor: Colors.white,
                        style: Theme.of(context).textTheme.caption,
                        decoration: const InputDecoration(border: OutlineInputBorder()),
                        items: dropdownItems,
                        onChanged: ((value) {}),
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      theight,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Theme.of(context).primaryColorDark),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    SizedBox(
                      height: 40.h,
                      width: 150.w,
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
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
                  ],
                )
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            SizedBox(height: 30.h),
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
                  Get.to(const SignUpScreen3());
                },
                child: Text(contin,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).backgroundColor)),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white, side: const BorderSide(width: 1.0)),
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  goBack,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
