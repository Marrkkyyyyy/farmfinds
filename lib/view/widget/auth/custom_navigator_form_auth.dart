import 'package:flutter/material.dart';

class CustomNavigatorFormAuth extends StatelessWidget {
  const CustomNavigatorFormAuth(
      {super.key,
      required this.size,
      required this.function,
      required this.text});
  final Size size;
  final Function function;
  final String text;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          fixedSize: Size(size.width * 1, 40),
          backgroundColor: const Color.fromARGB(255, 31, 129, 121),
          shape: const RoundedRectangleBorder()),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(color: Colors.white),
      ),
      onPressed: () {
        function();
      },
    );
  }
}
