import 'package:flutter/material.dart';

class CustomTipsPerfectImage extends StatelessWidget {
  const CustomTipsPerfectImage({super.key, required this.image, required this.size});
  final String image;
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * .75,
      height: size.height * .21,
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              image,
            )),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
    );
  }
}
