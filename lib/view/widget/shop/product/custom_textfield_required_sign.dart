import 'package:flutter/material.dart';

class CustomTextfieldRequiredSign extends StatelessWidget {
  const CustomTextfieldRequiredSign({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("*",
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(color: Colors.red));
  }
}