import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomSetAddressRegistration extends StatelessWidget {
  const CustomSetAddressRegistration(
      {super.key,
      required this.function,
      required this.text,
      required this.isVerified,
      required this.color});
  final Function function;
  final String text;
  final bool isVerified;
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
          SizedBox(
            width: MediaQuery.of(context).size.width * .5,
            child: Text(
              text,
              style:
                  Theme.of(context).textTheme.headline5!.copyWith(color: color),
              textAlign: TextAlign.end,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 5),
          isVerified
              ? const SizedBox()
              : const FaIcon(
                  FontAwesomeIcons.angleRight,
                  color: Colors.black45,
                  size: 14,
                ),
        ],
      ),
    );
  }
}
