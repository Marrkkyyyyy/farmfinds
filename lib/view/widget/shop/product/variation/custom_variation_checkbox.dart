import 'package:flutter/material.dart';

class CustomVariationCheckbox extends StatelessWidget {
  const CustomVariationCheckbox({super.key,required this.val, required this.onChanged});
  final bool val;
  final bool? Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: val,
      onChanged: onChanged,
    );
  }
}
