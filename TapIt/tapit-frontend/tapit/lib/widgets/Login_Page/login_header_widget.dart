import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tapit/images.dart';
import 'package:tapit/theme.dart';

import '../../constant.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({Key? key}) : super(key: key);

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
            SizedBox(
              width: 10.w,
            ),
            Image.asset(
              logoUnderheadDark,
              height: 42.48.h,
            )
          ],
        ),
        SizedBox(
          height: 40.h,
        ),
        Text(
          sloganLine,
          style: Theme.of(context)
              .textTheme
              .headline3
              ?.copyWith(fontWeight: FontWeight.w700, color: Themes.light.primaryColor),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          sloganUnderhead,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(fontWeight: FontWeight.w700, color: Themes.light.primaryColorDark),
        )
      ],
    );
  }
}
