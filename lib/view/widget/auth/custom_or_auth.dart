import 'package:flutter/material.dart';

class CustomOrAuth extends StatelessWidget {
  const CustomOrAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: Colors.black54,
            height: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'OR',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        const Expanded(
          child: Divider(
            color: Colors.black54,
            height: 1.0,
          ),
        ),
      ],
    );
  }
}
