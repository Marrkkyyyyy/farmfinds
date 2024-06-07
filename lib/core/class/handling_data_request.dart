import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/constant/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HandlingDataRequest extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandlingDataRequest(
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
            : statusRequest == StatusRequest.serverfailure
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Server failure. Please check your internet connection and refresh the page",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.black54),
                        ),
                        Center(
                          child: Lottie.asset(AppImageASset.server,
                              width: 200, height: 200),
                        ),
                      ],
                    ),
                  )
                : statusRequest == StatusRequest.failure
                    ? Center(
                        child: Lottie.asset(
                          AppImageASset.nodata,
                          width: 250,
                          height: 250,
                        ),
                      )
                    : widget;
  }
}
