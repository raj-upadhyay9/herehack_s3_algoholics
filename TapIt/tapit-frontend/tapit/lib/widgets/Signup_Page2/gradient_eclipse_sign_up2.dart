import 'package:flutter/material.dart';
import 'package:tapit/theme.dart';

import '../Login_Page/gradient_eclipse.dart';

class GradientEclipse2 extends StatefulWidget {
  double heigt;
  GradientEclipse2({super.key, required this.heigt});

  @override
  State<GradientEclipse2> createState() => _GradientEclipse2State();
}

class _GradientEclipse2State extends State<GradientEclipse2> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ClipPathClass(),
      child: Container(
        height: widget.heigt,
        decoration: BoxDecoration(
            color: Colors.black,
            gradient: LinearGradient(colors: [
              Themes.light.primaryColorDark,
              Themes.light.primaryColor,
            ])),
      ),
    );
  }
}
