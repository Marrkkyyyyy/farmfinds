import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomSetShopRegistration extends StatelessWidget {
  const CustomSetShopRegistration(
      {super.key,
      required this.text,
      this.isVerified = false,
      required this.function,
      this.isPhone = false,
      required this.color});
  final String text;
  final bool isVerified;
  final Function function;
  final bool isPhone;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            !isVerified
                ? text
                : (!isPhone
                    ? '${text.substring(0, 8)}***'
                    : '${text.substring(0, 6)}***'),
            style:
                Theme.of(context).textTheme.headline5!.copyWith(color: color),
            textAlign: TextAlign.end,
            maxLines: 1,
          ),
          const SizedBox(width: 5),
          isVerified
              ? const SizedBox()
              : FaIcon(
                  FontAwesomeIcons.angleRight,
                  color: Colors.black45,
                  size: 14,
                ),
        ],
      ),
    );
  }
}
