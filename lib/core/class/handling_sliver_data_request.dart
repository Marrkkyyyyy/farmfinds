import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/constant/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HandlingSliverDataRequest extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  final Widget shimmer;
  const HandlingSliverDataRequest(
      {super.key,
      required this.statusRequest,
      required this.widget,
      required this.shimmer});

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.none ||
            statusRequest == StatusRequest.loading
        ? shimmer
        : statusRequest == StatusRequest.offlinefailure
            ? SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Lottie.asset(
                      AppImageASset.offline,
                      height: 250,
                      width: 250,
                    ),
                  ],
                ),
              )
            : statusRequest == StatusRequest.failure
                ? SliverToBoxAdapter(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 150,
                        ),
                        Text(
                          "This shop currently has no products listed",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.black54, fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Lottie.asset(
                          AppImageASset.noProduct,
                        ),
                      ],
                    ),
                  )
                : statusRequest == StatusRequest.serverfailure
                    ? SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 50,
                              ),
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
                                    width: 250, height: 250),
                              ),
                            ],
                          ),
                        ),
                      )
                    : widget;
  }
}
