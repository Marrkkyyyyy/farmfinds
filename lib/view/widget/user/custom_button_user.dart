import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomButtonUser extends StatelessWidget {
  const CustomButtonUser(
      {super.key, required this.function, required this.icon});
  final Function function;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(12),
        child: FaIcon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
