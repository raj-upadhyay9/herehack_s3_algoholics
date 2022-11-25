import 'package:flutter/material.dart';

import '../../constant.dart';

class SignUpFooterWidget extends StatelessWidget {
  const SignUpFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          termsAndConditions,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.w100),
        ),
        Text(
          termsAndConditions2,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: Theme.of(context).canvasColor, fontWeight: FontWeight.w900),
        )
        // TextButton(
        //   onPressed: () {},
        //   child: Text.rich(
        //     TextSpan(text: termsAndConditions, style: Theme.of(context).textTheme.bodyText1),

        //   ),
        // ),
      ],
    );
  }
}
