import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/constant/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class HandlingSearchVegetable extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandlingSearchVegetable(
      {super.key, required this.statusRequest, required this.widget});

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? Center(
            child: Lottie.asset(AppImageASset.loading, width: 250, height: 250),
          )
        : statusRequest == StatusRequest.offlinefailure
            ? Center(
                child: Lottie.asset(AppImageASset.offline,
                    width: 250, height: 250),
              )
            : statusRequest == StatusRequest.failure
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const FaIcon(
                            FontAwesomeIcons.circleExclamation,
                            color: Color.fromARGB(169, 244, 67, 54),
                            size: 20,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "No vegetable found",
                            style: Theme.of(context).textTheme.headline2!,
                          ),
                        ],
                      ),
                      Center(
                        child: Lottie.asset(AppImageASset.noSearchFounnd,
                            width: 250, height: 250),
                      ),
                    ],
                  )
                : widget;
  }
}
