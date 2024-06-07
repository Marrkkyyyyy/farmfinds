import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomListTileUser extends StatelessWidget {
  const CustomListTileUser(
      {super.key,
      required this.function,
      required this.icon,
      required this.text,
      this.trailing = true});
  final Function function;
  final IconData icon;
  final String text;
  final bool trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xffffffff), boxShadow: [
        BoxShadow(
          color: Color(0x29000000),
          offset: Offset(0, 1.5),
          blurRadius: .5,
          spreadRadius: .5,
        ),
      ]),
      child: ListTile(
        onTap: () {
          function();
        },
        dense: true,
        minLeadingWidth: 0,
        leading: FaIcon(
          icon,
          color: Colors.teal.shade700,
          size: 16,
        ),
        title: Text(
          text,
          style: Theme.of(context).textTheme.headline5,
        ),
        trailing: !trailing
            ? const SizedBox()
            : const FaIcon(
                FontAwesomeIcons.angleRight,
                size: 16,
              ),
      ),
    );
  }
}
