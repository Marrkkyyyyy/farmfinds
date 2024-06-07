import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/controller/home/edit_profile_controller.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/link_api.dart';
import 'package:ecommerce/view/widget/confirmation_dialog.dart';
import 'package:ecommerce/view/widget/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});
  final controller = Get.put(EditProfileController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(builder: (controller) {
      return WillPopScope(
        onWillPop: controller.image != null
            ? () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return ConfirmationDialog(
                        confirmText: "Discard",
                        message: "Discard Changes?",
                        onCancel: () {
                          Navigator.pop(context);
                        },
                        onConfirm: () {
                          Navigator.pop(context);
                          Get.back();
                        },
                      );
                    });
                return true;
              }
            : () async {
                return true;
              },
        child: Scaffold(
          backgroundColor: const Color.fromARGB(4, 0, 0, 0),
          appBar: AppBar(
            leading: IconButton(
                onPressed: controller.image != null
                    ? () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return ConfirmationDialog(
                                confirmText: "Discard",
                                message: "Discard Changes?",
                                onCancel: () {
                                  Navigator.pop(context);
                                },
                                onConfirm: () {
                                  Navigator.pop(context);
                                  Get.back();
                                },
                              );
                            });
                      }
                    : () {
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
            elevation: 2,
            leadingWidth: 34,
            title: const Text(
              "Edit Profile",
            ),
            actions: [
              IconButton(
                  onPressed: controller.image == null
                      ? () {}
                      : () {
                          controller.userUpdateProfile();
                        },
                  icon: Icon(
                    Icons.check,
                    color: controller.image == null
                        ? Color.fromARGB(47, 0, 0, 0)
                        : Colors.teal,
                  ))
            ],
          ),
          body: GetBuilder<EditProfileController>(builder: (controller) {
            return Container(
              child: Column(children: [
                SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Color.fromARGB(28, 0, 0, 0),
                      child: controller.image != null
                          ? GestureDetector(
                              onTap: () {
                                Get.to(() => ImageView());
                              },
                              child: ClipOval(
                                child: Image.file(
                                  controller.image!,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : controller.profile != null
                              ? GestureDetector(
                                  onTap: () {
                                    Get.to(() => Images());
                                  },
                                  child: ClipOval(
                                      child: CachedNetworkImage(
                                    width: 100,
                                    height: 100,
                                    imageUrl:
                                        "${AppLink.userProfile}${controller.profile}",
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
                                )
                              : Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.blueGrey,
                                ),
                    ),
                    Positioned(
                      right: 0.0,
                      bottom: 0.0,
                      child: GestureDetector(
                        onTap: () {
                          controller.pickImage();
                        },
                        child: Container(
                          width: 30.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(193, 0, 0, 0),
                          ),
                          child: Center(
                            child: FaIcon(
                              FontAwesomeIcons.camera,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(12),
                    color: Colors.white,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Name",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          GestureDetector(
                            onTap: () async {
                              final result = await Get.toNamed(
                                  AppRoute.updateTextField,
                                  arguments: {
                                    "fullName": controller.fullName.value,
                                  });

                              if (result == true) {
                                controller.updateName();
                              }
                            },
                            child: Row(
                              children: [
                                Obx(() {
                                  return Text(
                                    controller.fullName.value,
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                    textAlign: TextAlign.end,
                                    maxLines: 1,
                                  );
                                }),
                                const SizedBox(width: 6),
                                const FaIcon(
                                  FontAwesomeIcons.angleRight,
                                  color: Colors.black45,
                                  size: 16,
                                ),
                              ],
                            ),
                          )
                        ]),
                  ),
                ),
                SpacerWidget(),
                // GestureDetector(
                //   onTap: () {
                //     Get.toNamed(AppRoute.updateUserPhone, arguments: {
                //       "phoneNumber": controller.phoneNumber.value
                //     });
                //   },
                //   child: Container(
                //     padding: EdgeInsets.all(12),
                //     color: Colors.white,
                //     child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: [
                //           Text(
                //             "Phone",
                //             style: Theme.of(context).textTheme.headline5,
                //           ),
                //           Row(
                //             children: [
                //               controller.phoneNumber.value == "null" ||
                //                       controller.phoneNumber.value == ""
                //                   ? Text(
                //                       "Set",
                //                       style: Theme.of(context)
                //                           .textTheme
                //                           .headline5!
                //                           .copyWith(color: Colors.black38),
                //                       textAlign: TextAlign.end,
                //                       maxLines: 1,
                //                     )
                //                   : Text(
                //                       controller.phoneNumber.value,
                //                       style:
                //                           Theme.of(context).textTheme.headline5,
                //                       textAlign: TextAlign.end,
                //                       maxLines: 1,
                //                     ),
                //               const SizedBox(width: 6),
                //               const FaIcon(
                //                 FontAwesomeIcons.angleRight,
                //                 color: Colors.black45,
                //                 size: 16,
                //               ),
                //             ],
                //           )
                //         ]),
                //   ),
                // ),
                // Divider(
                //   height: 0,
                //   thickness: 1,
                // ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoute.updateEmail);
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    color: Colors.white,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Expanded(
                            child: Text(
                              '${controller.email.value.replaceFirstMapped(RegExp(r'^(\w{5})(.*)(?=@)'), (match) => '${match.group(1)}${'*' * 4}')}',
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.end,
                              maxLines: 1,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const FaIcon(
                            FontAwesomeIcons.angleRight,
                            color: Colors.black45,
                            size: 16,
                          ),
                        ]),
                  ),
                ),
              ]),
            );
          }),
        ),
      );
    });
  }
}

class Images extends StatelessWidget {
  Images({super.key});
  final controller = Get.find<EditProfileController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            color: Colors.black,
            child: Center(
              child: CachedNetworkImage(
                imageUrl: "${AppLink.userProfile}${controller.profile}",
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.black26,
                  highlightColor: Colors.white,
                  child: Container(
                    color: Colors.black26,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ImageView extends StatelessWidget {
  ImageView({super.key});
  final controller = Get.find<EditProfileController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            color: Colors.black,
            child: Center(
              child: Image.file(
                controller.image!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
