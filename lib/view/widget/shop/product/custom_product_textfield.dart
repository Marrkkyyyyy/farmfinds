import 'package:flutter/material.dart';

class CustomProductTextfield extends StatelessWidget {
  const CustomProductTextfield(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.onChanged,
      required this.valid,
      required this.maxLength,
      this.isDescription = true,this.textCapitalization=TextCapitalization.words});
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?) onChanged;
  final String? Function(String?) valid;
  final int maxLength;
  final bool isDescription;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: isDescription ? null : 1,
      validator: valid,
      onChanged: onChanged,
      controller: controller,
      textCapitalization: textCapitalization,
      style: Theme.of(context).textTheme.headline5,
      maxLength: 100,
      decoration: InputDecoration(
        counterText: '',
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15.0,
        ),
        hintText: hintText,
        hintStyle: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(color: Colors.black54),
        border: InputBorder.none,
      ),
    );
  }
}
