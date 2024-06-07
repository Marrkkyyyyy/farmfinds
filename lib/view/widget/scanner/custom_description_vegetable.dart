import 'package:ecommerce/view/widget/scanner/custom_title_head.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomDescriptionVegetable extends StatelessWidget {
  const CustomDescriptionVegetable(
      {super.key,
      required this.titleHead,
      required this.iconHead,
      required this.description});
  final String titleHead;
  final String description;
  final IconData iconHead;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTitleHead(
              titleHead: titleHead, iconHead: FontAwesomeIcons.book),
          const SizedBox(
            height: 10,
          ),
          Text(
            description,
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}
