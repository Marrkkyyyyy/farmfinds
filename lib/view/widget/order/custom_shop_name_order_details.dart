import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomShopNameOrderDetails extends StatelessWidget {
  const CustomShopNameOrderDetails({super.key, required this.shopName});
  final String shopName;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const FaIcon(
          FontAwesomeIcons.store,
          color: Colors.teal,
          size: 18,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          shopName,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontWeight: FontWeight.w800, fontSize: 14),
        ),
      ],
    );
  }
}
