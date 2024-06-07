import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomButtonCapture extends StatelessWidget {
  const CustomButtonCapture(
      {super.key,
      required this.function,
      required this.iconData,
      required this.text});
  final Function function;
  final IconData iconData;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 28),
        decoration: const BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              iconData,
              color: Colors.white,
              size: 32,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    letterSpacing: 1.05,
                    color: Colors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
