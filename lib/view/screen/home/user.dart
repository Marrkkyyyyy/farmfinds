import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/link_api.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ecommerce/controller/home/home_screen_controller.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/view/widget/home/custom_popup_button.dart';
import 'package:ecommerce/view/widget/spacer_widget.dart';
import 'package:ecommerce/view/widget/user/custom_auth_button_user.dart';
import 'package:ecommerce/view/widget/user/custom_button_user.dart';
import 'package:ecommerce/view/widget/user/custom_list_tile_user.dart';
import 'package:ecommerce/view/widget/user/custom_name_user.dart';
import 'package:ecommerce/view/widget/user/custom_order_button_user.dart';
import 'package:ecommerce/view/widget/user/custom_profile_user.dart';
import 'package:shimmer/shimmer.dart';

class User extends StatelessWidget {
  final Size size;
  const User({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    HomeScreenController controller = Get.find();
    return RefreshIndicator(
      onRefresh: () async => await controller.refreshData(),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              color: Colors.teal.shade300,
              padding: const EdgeInsets.only(
                left: 4,
              ),
              child: Stack(children: [
                SafeArea(
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 4,
                      bottom: 8,
                    ),
                    width: size.width,
                    child: Row(children: [
                      Expanded(
                        child: Row(
                          children: [
                            Obx(() {
                              return CustomProfile(
                                backgroundColor: Colors.white,
                                size: size,
                                widget: controller.userProfile.value == "" ||
                                        controller.userProfile.value == "null"
                                    ? const Icon(
                                        Icons.person,
                                        size: 40,
                                        color: Colors.teal,
                                      )
                                    : ClipOval(
                                        child: CachedNetworkImage(
                                        width: 100,
                                        height: 100,
                                        imageUrl:
                                            "${AppLink.userProfile}${controller.userProfile.value}",
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            Shimmer.fromColors(
                                          baseColor: Colors.black26,
                                          highlightColor: Colors.white,
                                          child: Container(
                                            color: Colors.black26,
                                          ),
                                        ),
                                      )),
                              );
                            }),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(child: Obx(() {
                              return CustomName(
                                textColor: Colors.white,
                                name: controller.fullName.value,
                                size: size,
                              );
                            })),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                CustomButtonUser(
                                    function: controller.userID == null
                                        ? () {
                                            controller.goToLogin();
                                          }
                                        : () {
                                            Get.toNamed(AppRoute.cartPage);
                                          },
                                    icon: FontAwesomeIcons.cartShopping),
                                const SizedBox(
                                  width: 4,
                                ),
                                controller.userID == null
                                    ? SizedBox()
                                    : CustomPopupButton(
                                        items: [
                                          CustomPopupMenuItem(
                                              value: 0,
                                              icon: Icons.person,
                                              text: 'Edit Profile'),
                                          CustomPopupMenuItem(
                                              value: 1,
                                              icon: Icons.location_on_outlined,
                                              text: 'My Addresses'),
                                        ],
                                        onItemSelected: (value) async {
                                          if (value == 0) {
                                            final result = await Get.toNamed(
                                                AppRoute.editProfile);
                                            if (result == true) {
                                              controller.updateProfile();
                                            }
                                          }
                                          if (value == 1) {
                                            Get.toNamed(AppRoute.myAddress);
                                          }
                                        },
                                      ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            controller.userID != null
                                ? const SizedBox()
                                : Row(
                                    children: [
                                      CustomAuthButtonUser(
                                        function: () {
                                          Get.toNamed(AppRoute.login,
                                              arguments: {
                                                'fromUserPage': true
                                              });
                                        },
                                        text: "Login",
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      // CustomAuthButtonUser(
                                      //   function: () {
                                      //     Get.toNamed(AppRoute.signUp,
                                      //         arguments: {
                                      //           'fromUserPage': true
                                      //         });
                                      //   },
                                      //   text: "Sign up",
                                      // ),
                                    ],
                                  )
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
              ]),
            ),
          ),
          SliverToBoxAdapter(
            child: const SpacerWidget(
              height: 5,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                top: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Orders",
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                    onTap: controller.userID == null
                        ? () {
                            controller.goToLogin();
                          }
                        : () {
                            Get.toNamed(AppRoute.viewAllOrders);
                          },
                    child: Row(
                      children: [
                        Text(
                          "View All Orders",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.black45),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const FaIcon(
                          FontAwesomeIcons.angleRight,
                          color: Colors.black45,
                          size: 12,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomOrderButtonUser(
                    icon: FontAwesomeIcons.boxArchive,
                    text: "Processing",
                    function: controller.userID == null
                        ? () {
                            controller.goToLogin();
                          }
                        : () {
                            Get.toNamed(AppRoute.viewAllOrders,
                                arguments: {'initialIndex': 0});
                          },
                    totalTransaction:
                        controller.processingOrders.length.toString(),
                  ),
                  CustomOrderButtonUser(
                    icon: FontAwesomeIcons.truck,
                    text: "Shipped",
                    function: controller.userID == null
                        ? () {
                            controller.goToLogin();
                          }
                        : () {
                            Get.toNamed(AppRoute.viewAllOrders,
                                arguments: {'initialIndex': 1});
                          },
                    totalTransaction:
                        controller.shippedOrders.length.toString(),
                  ),
                  CustomOrderButtonUser(
                    icon: FontAwesomeIcons.solidMessage,
                    text: "To Review",
                    function: controller.userID == null
                        ? () {
                            controller.goToLogin();
                          }
                        : () {
                            Get.toNamed(AppRoute.myRating);
                          },
                    totalTransaction: controller.toRateOrders.length.toString(),
                  ),
                ],
              );
            }),
          ),
          SliverToBoxAdapter(
            child: const SpacerWidget(),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Obx(() {
                  return controller.shopID.value != ""
                      ? CustomListTileUser(
                          function: () {
                            Get.toNamed(AppRoute.shop);
                          },
                          icon: FontAwesomeIcons.store,
                          text: "My Shop",
                        )
                      : CustomListTileUser(
                          function: controller.userID == null
                              ? () {
                                  controller.goToLogin();
                                }
                              : () {
                                  Get.toNamed(AppRoute.welcomeRegistration);
                                },
                          icon: FontAwesomeIcons.store,
                          text: "Start Selling",
                        );
                }),
                // CustomListTileUser(
                //     function: () {},
                //     icon: FontAwesomeIcons.heart,
                //     text: "Following Shops"),
                CustomListTileUser(
                    function: controller.userID == null
                        ? () {
                            controller.goToLogin();
                          }
                        : () {
                            Get.toNamed(AppRoute.myRating);
                          },
                    icon: FontAwesomeIcons.star,
                    text: "My Rating"),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: const SpacerWidget(),
          ),
          SliverToBoxAdapter(
            child: controller.userID != null
                ? CustomListTileUser(
                    function: () async {
                      controller.logout();
                    },
                    icon: FontAwesomeIcons.rightFromBracket,
                    text: "Logout",
                    trailing: false,
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
