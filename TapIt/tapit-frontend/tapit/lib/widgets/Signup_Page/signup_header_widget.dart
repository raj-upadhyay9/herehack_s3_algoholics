import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tapit/images.dart';
import 'package:tapit/theme.dart';

import '../../constant.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 130.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              logo,
              height: 30.32.h,
            ),
            SizedBox(
              width: 10.w,
            ),
            Image.asset(
              logoUnderheadDark,
              height: 30.48.h,
            )
          ],
        ),
        SizedBox(
          height: 40.h,
        ),
        Text(
          tSignUpTitle,
          style: Theme.of(context).textTheme.headline1?.copyWith(
              height: 1,
              fontSize: 50.sp,
              fontWeight: FontWeight.w900,
              color: Themes.light.primaryColorDark,
              letterSpacing: 0),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          tsubTitle,
          style: Theme.of(context)
              .textTheme
              .caption
              ?.copyWith(fontWeight: FontWeight.w400, color: Themes.light.primaryColorDark),
        )
      ],
    );
  }
}
