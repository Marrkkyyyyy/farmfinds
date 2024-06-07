import 'package:flutter/material.dart';

class CustomAddressTitle extends StatelessWidget {
  const CustomAddressTitle({super.key, required this.size, required this.text});
  final String text;
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, top: 10, bottom: 10),
      width: size.width,
      color: const Color.fromARGB(8, 0, 0, 0),
      child: Text(text,
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.black54,
              )),
    );
  }
}
