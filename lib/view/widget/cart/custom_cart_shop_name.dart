import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomCartShopName extends StatelessWidget {
  const CustomCartShopName({super.key, required this.shopName});
  final String shopName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          const FaIcon(
            FontAwesomeIcons.store,
            color: Colors.blueGrey,
            size: 18,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            "$shopName",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
