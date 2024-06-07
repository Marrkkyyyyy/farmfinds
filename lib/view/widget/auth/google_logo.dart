import 'package:ecommerce/core/constant/image_asset.dart';
import 'package:flutter/material.dart';

class GoogleLogo extends StatelessWidget {
  const GoogleLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImageASset.googleLogo,
      height: 20,
    );
  }
}
