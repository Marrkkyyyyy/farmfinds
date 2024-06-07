import 'package:flutter/material.dart';

class CustomTextFormAuth extends StatelessWidget {
  const CustomTextFormAuth(
      {super.key,
      this.keyboardType = TextInputType.text,
      required this.hintText,
      required this.controller,
      required this.valid,
      required this.icon,
      this.isObscureText = false});

  final TextInputType keyboardType;
  final bool isObscureText;
  final String hintText;

  final TextEditingController? controller;
  final String? Function(String?) valid;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscureText,
      controller: controller,
      keyboardType: keyboardType,
      validator: valid,
      decoration: InputDecoration(
        focusedErrorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1)),
        errorMaxLines: 2,
        errorStyle: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(fontSize: 13, color: Colors.red),
        hintText: hintText,
        hintStyle: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(color: Colors.black45),
        prefixIcon: Icon(
          icon,
          color: Colors.teal,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: .5,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal,
            width: 1.0,
          ),
        ),
        prefixStyle: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}
