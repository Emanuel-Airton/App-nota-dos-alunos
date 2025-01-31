import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 22.5,
      height: 15,
      child: SvgPicture.asset(
        'assets/vectors/icon_14_x2.svg',
      ),
    );
  }
}
