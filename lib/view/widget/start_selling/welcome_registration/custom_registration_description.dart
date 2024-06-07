import 'package:flutter/material.dart';

class CustomRegistrationDescription extends StatelessWidget {
  const CustomRegistrationDescription(
      {super.key, required this.size, required this.description});
  final Size size;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * .9,
      padding: const EdgeInsets.only(left: 5, right: 5, top: 15),
      child: Text(
        description,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .headline1!
            .copyWith(color: const Color.fromARGB(169, 0, 0, 0)),
      ),
    );
  }
}
