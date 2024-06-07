import 'package:ecommerce/core/constant/image_asset.dart';
import 'package:flutter/material.dart';

class CustomBackgroundWelcomeRegistration extends StatelessWidget {
  const CustomBackgroundWelcomeRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
        AppImageASset.background,
        fit: BoxFit.cover,
      );
  }
}
