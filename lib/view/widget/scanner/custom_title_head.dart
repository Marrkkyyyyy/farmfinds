import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomTitleHead extends StatelessWidget {
  const CustomTitleHead(
      {super.key, required this.titleHead, required this.iconHead});

  final String titleHead;
  final IconData iconHead;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FaIcon(
          iconHead,
          color: Colors.blueGrey,
          size: 20,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          titleHead,
          style: Theme.of(context).textTheme.headline5!.copyWith(
              color: Colors.teal, fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}
