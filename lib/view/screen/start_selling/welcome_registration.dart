import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/view/widget/start_selling/welcome_registration/custom_background.dart';
import 'package:ecommerce/view/widget/start_selling/welcome_registration/custom_background_shop_registration.dart';
import 'package:ecommerce/view/widget/start_selling/welcome_registration/custom_registration_description.dart';
import 'package:ecommerce/view/widget/start_selling/welcome_registration/custom_welcome_button_navigation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class WelcomeRegistration extends StatelessWidget {
  const WelcomeRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.only(left: 8.0),
                child: const FaIcon(
                  FontAwesomeIcons.arrowLeft,
                  color: Colors.teal,
                  size: 20,
                ),
              )),
          leadingWidth: 34,
          title: const Text(
            "Welcome to FarmFinds!",
          ),
        ),
        body: Column(
          children: [
            CustomBackgroundShopRegistration(
              size: size,
              widget: const CustomBackgroundWelcomeRegistration(),
            ),
            CustomRegistrationDescription(
                size: size,
                description:
                    "To get started, join as a seller by giving the necessary information.")
          ],
        ),
        bottomNavigationBar: CustomWelcomeButtonNavigationBar(
          size: size,
          text: "START REGISTRATION",
          function: () {
            Get.offNamed(AppRoute.shopRegistration);
          },
        ));
  }
}
