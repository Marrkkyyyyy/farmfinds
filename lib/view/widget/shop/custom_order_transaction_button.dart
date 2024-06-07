import 'package:flutter/material.dart';

class CustomOrderTransactionButton extends StatelessWidget {
  const CustomOrderTransactionButton(
      {super.key,
      required this.size,
      required this.text,
      required this.totalTransaction,
      required this.function});
  final Size size;
  final String text;
  final String totalTransaction;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        width: size.width * .23,
        height: size.height * .07,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Color.fromARGB(12, 0, 0, 0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              totalTransaction,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: totalTransaction != "0"
                      ? Colors.teal.shade400
                      : Colors.black54),
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                  color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
