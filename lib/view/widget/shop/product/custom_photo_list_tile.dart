import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomPhotoListTile extends StatelessWidget {
  const CustomPhotoListTile(
      {super.key,
      required this.icon,
      required this.function,
      required this.text});
  final IconData icon;
  final Function function;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        function();
      },
      title: Row(
        children: [
          FaIcon(
            icon,
            size: 16,
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.headline5,
          )
        ],
      ),
    );
  }
}
