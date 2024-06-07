import 'package:ecommerce/core/functions/remove_leading_zeros.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomVariationTextfield extends StatelessWidget {
  const CustomVariationTextfield({super.key, required this.controller});
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Price is required";
          } 
          return null;
        },
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
          RemoveLeadingZerosFormatter(),
        ],
        decoration: InputDecoration(
          hintText: "₱0",
          hintStyle: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: Colors.black54),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(1.0),
            borderSide: const BorderSide(
              color: Colors.black26,
              width: 1,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 7,
          ),
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(1.0),
            borderSide: const BorderSide(
              color: Colors.black26,
              width: 3,
            ),
          ),
        ),
      ),
    );
  }
}

