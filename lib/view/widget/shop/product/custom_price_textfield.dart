import 'package:ecommerce/core/functions/remove_leading_zeros.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomPriceTextfield extends StatelessWidget {
  const CustomPriceTextfield(
      {super.key,
      required this.text,
      required this.controller,
      required this.function,
      required this.onChanged});
  final String text;
  final TextEditingController controller;
  final Function function;
  final String? Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        controller: controller,
        onTap: () {
          function();
        },
        onChanged: onChanged,
        style: Theme.of(context).textTheme.headline5,
        textAlign: TextAlign.end,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
          RemoveLeadingZerosFormatter(),
        ],
        decoration: InputDecoration(
          hintText: text,
          hintStyle: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: Colors.black54),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
