import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tapit/images.dart';
import 'package:tapit/theme.dart';

import '../../constant.dart';

class SignUpScreen2Header extends StatelessWidget {
  const SignUpScreen2Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              logo,
              height: 58.32.h,
            ),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        Text(
          tsubTitle,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(fontWeight: FontWeight.w700, color: Themes.light.primaryColorDark),
        )
      ],
    );
  }
}
