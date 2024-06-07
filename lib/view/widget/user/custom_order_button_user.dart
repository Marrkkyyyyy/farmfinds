import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomOrderButtonUser extends StatelessWidget {
  const CustomOrderButtonUser(
      {super.key,
      required this.icon,
      required this.text,
      required this.function,
      required this.totalTransaction});
  final IconData icon;
  final String text;
  final Function function;
  final String totalTransaction;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FaIcon(
                  icon,
                  size: 20,
                  color: Colors.blueGrey,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.black54),
                ),
              ],
            ),
            // Positioned widget is used to position the badge
            totalTransaction == "0"
                ? SizedBox()
                : Positioned(
                    bottom: 35,
                    left: icon == FontAwesomeIcons.boxArchive
                        ? 40
                        : icon == FontAwesomeIcons.truck
                            ? 30
                            : 28,
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.teal,
                      ),
                      child: Text(
                        totalTransaction,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
