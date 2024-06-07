import 'package:flutter/material.dart';

class CustomHeaderOrderDetails extends StatelessWidget {
  const CustomHeaderOrderDetails({super.key, required this.size});
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.teal.shade400),
      width: size.width,
      padding: EdgeInsets.only(left: 12, top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Pending Payment",
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(color: Colors.white, fontWeight: FontWeight.normal),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            "Anticipating the seller shipping out your product(s).",
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
