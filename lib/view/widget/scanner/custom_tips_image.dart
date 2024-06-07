import 'package:flutter/material.dart';

class CustomTipsImage extends StatelessWidget {
  const CustomTipsImage(
      {super.key, required this.image, required this.text, required this.size});
  final String image;
  final String text;
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size.width * .41,
          height: size.height * .15,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  image,
                )),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.headline6,
        )
      ],
    );
  }
}
