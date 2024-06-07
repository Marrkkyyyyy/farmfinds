import 'package:flutter/material.dart';

class CustomRegionAddressTextfield extends StatelessWidget {
  const CustomRegionAddressTextfield(
      {super.key,
      required this.size,
      required this.function,
      required this.hint,
      required this.value,
      required this.items});
  final Size size;
  final String? Function(String?) function;
  final String hint;
  final String? value;
  final Map<String, String> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 15, bottom: 5, top: 5),
      width: size.width,
      color: Colors.white,
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          validator: (val) {
            if (val == null || val.isEmpty) {
              return 'Please select address';
            }
            return null;
          },
          style: Theme.of(context).textTheme.headline5!.copyWith(),
          decoration: InputDecoration(
              errorStyle: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.red,
                  ),
              isDense: true,
              labelText: hint,
              labelStyle: Theme.of(context).textTheme.headline5!.copyWith(
                    color: Colors.teal,
                  ),
              focusedBorder: InputBorder.none,
              border: InputBorder.none),
          menuMaxHeight: 300,
          onChanged: function,
          value: value,
          items: items.entries.map<DropdownMenuItem<String>>((entry) {
            final code = entry.key;
            final regionName = entry.value;
            return DropdownMenuItem<String>(
              value: code,
              child: Text(regionName),
            );
          }).toList(),
        ),
      ),
    );
  }
}
