import 'package:flutter/material.dart';

class CustomAddressDropdownTextfield extends StatelessWidget {
  const CustomAddressDropdownTextfield(
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
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding:
              const EdgeInsets.only(left: 10, right: 15, bottom: 5, top: 5),
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
              style: Theme.of(context).textTheme.headline5,
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
              items: items.map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: SizedBox(
                    width: size.width * .8,
                    child: Text(
                      value,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        const Divider(
          height: 0,
          thickness: 1,
        ),
      ],
    );
  }
}
