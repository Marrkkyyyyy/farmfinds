import 'package:flutter/material.dart';

class CustomShopTextfield extends StatelessWidget {
  const CustomShopTextfield(
      {super.key,
      required this.hint,
      required this.valid,
      required this.controller,
      required this.function});
  final String hint;
  final String? Function(String?) valid;
  final TextEditingController controller;
  final String? Function(String?) function;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      child: TextFormField(
        onChanged: function,
        controller: controller,
        validator: valid,
        style: Theme.of(context).textTheme.headline5!,
        textCapitalization: TextCapitalization.words,
        maxLength: 30,
        decoration: InputDecoration(
          errorMaxLines: 2,
          errorStyle: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.red,
              ),
          counterText: '',
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12.0,
          ),
          hintText: hint,
          hintStyle: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: Colors.black45),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
