import 'package:ecommerce/core/constant/image_asset.dart';
import 'package:flutter/material.dart';

class OTPLogo extends StatelessWidget {
  const OTPLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
                AppImageASset.otpLogo,
                width: 150,
                height: 150,
              );
  }
}