import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAddressTextfield extends StatelessWidget {
  const CustomAddressTextfield(
      {super.key,
      required this.hint,
      required this.valid,
      this.keyboardType = TextInputType.number,
      this.digitOnly = true,
      required this.controller});
  final String hint;
  final String? Function(String?) valid;
  final TextInputType keyboardType;
  final bool digitOnly;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 5),
      child: TextFormField(
        controller: controller,
        textCapitalization: TextCapitalization.words,
        validator: valid,
        keyboardType: keyboardType,
        inputFormatters: <TextInputFormatter>[
          digitOnly
              ? FilteringTextInputFormatter.digitsOnly
              : FilteringTextInputFormatter.allow(RegExp(r'.*'))
        ],
        style: Theme.of(context).textTheme.headline5,
        decoration: InputDecoration(
          errorMaxLines: 2,
          errorStyle: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.red,
              ),
          fillColor: Colors.white,
          filled: true,
          isDense: true,
          label: Text(hint),
          labelStyle: Theme.of(context).textTheme.headline5!.copyWith(
                color: Colors.teal,
              ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14.0, horizontal: 10),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
