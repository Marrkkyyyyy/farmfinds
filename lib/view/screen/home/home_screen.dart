import 'package:ecommerce/controller/home/home_screen_controller.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/view/screen/home/home.dart';
import 'package:ecommerce/view/screen/home/user.dart';
import 'package:ecommerce/view/widget/home/custom_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final controller = Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: controller.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Home(size: controller.size.value),
            User(size: controller.size.value),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF7895B2),
          onPressed: () {
            Get.toNamed(AppRoute.scanner);
          },
          child: const Icon(Icons.sensors_outlined),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: const CircularNotchedRectangle(),
          notchMargin: 5,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CustomFloatingActionButton(
                  icon: FontAwesomeIcons.house,
                  function: () {
                    controller.goToTab(0);
                  }),
              const SizedBox(),
              CustomFloatingActionButton(
                  icon: FontAwesomeIcons.solidUser,
                  function: () {
                    controller.goToTab(1);
                  }),
            ],
          ),
        ));
  }
}
