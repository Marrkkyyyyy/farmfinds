import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/controller/shop/shop/edit_shop_controller.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/link_api.dart';
import 'package:ecommerce/view/widget/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class EditShop extends StatelessWidget {
  EditShop({super.key});
  final controller = Get.put(EditShopController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(4, 0, 0, 0),
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
        elevation: 2,
        leadingWidth: 34,
        title: const Text(
          "Edit Shop",
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.check,
                color: Colors.teal,
              ))
        ],
      ),
      body: GetBuilder<EditShopController>(builder: (controller) {
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
                      ? ClipOval(
                          child: Image.file(
                            controller.image!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        )
                      : controller.profile != "null"
                          ? ClipOval(
                              child: CachedNetworkImage(
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                              imageUrl:
                                  "${AppLink.shopImage}${controller.profile}",
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Color.fromARGB(50, 0, 0, 0),
                                highlightColor:
                                    Color.fromARGB(176, 255, 255, 255),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4)),
                                  child: Container(
                                    color: Color.fromARGB(50, 0, 0, 0),
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ))
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
              onTap: () {
                Get.toNamed(AppRoute.editPickupAddress);
              },
              child: Container(
                padding: EdgeInsets.all(12),
                color: Colors.white,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Pickup Address",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Row(
                        children: [
                          Text(
                            "Octavio Village",
                            style: Theme.of(context).textTheme.headline5,
                            textAlign: TextAlign.end,
                            maxLines: 1,
                          ),
                          const SizedBox(width: 6),
                          const FaIcon(
                            FontAwesomeIcons.angleRight,
                            color: Colors.black45,
                            size: 16,
                          ),
                        ],
                      )
                    ]),
              ),
            ),
            SpacerWidget(),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoute.editPhone);
              },
              child: Container(
                padding: EdgeInsets.all(12),
                color: Colors.white,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Phone",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Row(
                        children: [
                          Text(
                            "***669",
                            style: Theme.of(context).textTheme.headline5,
                            textAlign: TextAlign.end,
                            maxLines: 1,
                          ),
                          const SizedBox(width: 6),
                          const FaIcon(
                            FontAwesomeIcons.angleRight,
                            color: Colors.black45,
                            size: 16,
                          ),
                        ],
                      )
                    ]),
              ),
            ),
            Divider(
              height: 0,
              thickness: 1,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoute.editEmail);
              },
              child: Container(
                padding: EdgeInsets.all(12),
                color: Colors.white,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Email",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Row(
                        children: [
                          Text(
                            "markst***",
                            style: Theme.of(context).textTheme.headline5,
                            textAlign: TextAlign.end,
                            maxLines: 1,
                          ),
                          const SizedBox(width: 6),
                          const FaIcon(
                            FontAwesomeIcons.angleRight,
                            color: Colors.black45,
                            size: 16,
                          ),
                        ],
                      )
                    ]),
              ),
            ),
          ]),
        );
      }),
    );
  }
}
