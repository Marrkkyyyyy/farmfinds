import 'package:flutter/material.dart';

class CustomTitleShopRegistration extends StatelessWidget {
  const CustomTitleShopRegistration({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text(title, style: Theme.of(context).textTheme.headline3!),
        const SizedBox(
          width: 5,
        ),
        Text("*",
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: Colors.red))
      ],
    );
  }
}
