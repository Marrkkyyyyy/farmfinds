import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomIconTextfield extends StatelessWidget {
  const CustomIconTextfield({
    super.key,
    required this.icon,
  });
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 25,
      child: Center(
        child: FaIcon(
          icon,
          size: 18,
        ),
      ),
    );
  }
}
