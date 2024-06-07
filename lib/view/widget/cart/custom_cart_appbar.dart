import 'package:ecommerce/core/constant/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomCartEmpty extends StatelessWidget {
  const CustomCartEmpty({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .25,
          ),
          Text(
            "Your cart is empty. Start shopping now!",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Colors.black54),
          ),
          Lottie.asset(
            AppImageASset.nodata,
            width: 250,
            height: 250,
          ),
        ],
      ),
    );
  }
}
