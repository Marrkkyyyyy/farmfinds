import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomIconAngleRight extends StatelessWidget {
  const CustomIconAngleRight({super.key});

  @override
  Widget build(BuildContext context) {
    return const FaIcon(
      FontAwesomeIcons.angleRight,
      size: 16,
      color: Colors.black45,
    );
  }
}
