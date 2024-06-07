import 'package:ecommerce/controller/scan/scanner_controller.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/constant/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class HandlingScanVegetable extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  HandlingScanVegetable(
      {super.key, required this.statusRequest, required this.widget});
  final controller = Get.put(ScannerController());

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
            : statusRequest == StatusRequest.noSearchFound
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
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          fixedSize:
                              Size(MediaQuery.of(context).size.width * .8, 47),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor:
                              const Color.fromARGB(237, 31, 129, 121),
                        ),
                        onPressed: () {
                          controller.camera();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.camera,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text("Retake",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(color: Colors.white)),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          fixedSize:
                              Size(MediaQuery.of(context).size.width * .8, 47),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor:
                              const Color.fromARGB(237, 31, 129, 121),
                        ),
                        onPressed: () {
                          controller.pickImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.solidImage,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text("Photos",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(color: Colors.white)),
                          ],
                        ),
                      ),
                    ],
                  )
                : widget;
  }
}
