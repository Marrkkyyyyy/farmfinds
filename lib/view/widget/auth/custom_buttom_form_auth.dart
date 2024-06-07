import 'package:flutter/material.dart';

class CustomButtonFormAuth extends StatelessWidget {
  const CustomButtonFormAuth(
      {super.key,
      required this.logo,
      required this.function,
      required this.text});
  final Widget logo;
  final Function function;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black38,
              width: 1.0,
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: logo,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: const Color.fromARGB(181, 0, 0, 0), fontSize: 18),
                ),
              )
            ],
          )),
    );
  }
}
