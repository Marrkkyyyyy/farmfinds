import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomShopName extends StatelessWidget {
  const CustomShopName(
      {super.key, required this.shopName, required this.status});
  final String shopName;
  final String status;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 10,
        left: 8,
        right: 12,
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
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
                  "${shopName}",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.w800, fontSize: 14),
                ),
              ],
            ),
          ),
          Text(
            status,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontSize: 14, color: Colors.teal),
          )
        ],
      ),
    );
  }
}
