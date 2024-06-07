import 'package:ecommerce/controller/scan/scanned_profile_controller.dart';
import 'package:ecommerce/core/class/handling_data_request.dart';
import 'package:ecommerce/view/widget/scanner/custom_characteristics_vegetable.dart';
import 'package:ecommerce/view/widget/scanner/custom_description_vegetable.dart';
import 'package:ecommerce/view/widget/scanner/custom_image_display.dart';
import 'package:ecommerce/view/widget/scanner/custom_image_index.dart';
import 'package:ecommerce/view/widget/scanner/custom_key_facts.dart';
import 'package:ecommerce/view/widget/scanner/custom_scientific_classification.dart';
import 'package:ecommerce/view/widget/scanner/custom_vegetable_head.dart';
import 'package:ecommerce/view/widget/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ScannedVegetable extends StatelessWidget {
  ScannedVegetable({Key? key}) : super(key: key);
  final controller = Get.put(ScannedProfileController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: GetBuilder<ScannedProfileController>(builder: (controller) {
          return HandlingDataRequest(
              statusRequest: controller.statusRequest,
              widget: controller.data.isEmpty
                  ? const SizedBox()
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              CustomImageDisplay(
                                  size: controller.size.value,
                                  onPageChaged: (index, reason) {
                                    controller.currentIndex.value = index;
                                  },
                                  imageURLs: controller.imageUrls),
                              Obx(() {
                                return CustomImageIndex(
                                    imageURLs: controller.imageUrls,
                                    currentIndex:
                                        controller.currentIndex.value);
                              }),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SpacerWidget(),
                              CustomVegetableHead(
                                  englishName: controller.data[0].englishName!,
                                  aka: controller.data[0].aKA!,
                                  familyName: controller.data[0].familyName!),
                              const SizedBox(
                                height: 15,
                              ),
                              const SpacerWidget(),
                              CustomScientificClassication(
                                tagalogName: controller.data[0].tagalogName!,
                                botanicalName:
                                    controller.data[0].botanicalName!,
                                familyName: controller.data[0].familyName!,
                                iconHead: FontAwesomeIcons.tableCellsLarge,
                                titleHead: "Scientific classification",
                              ),
                              CustomDescriptionVegetable(
                                  titleHead: "Description",
                                  iconHead: FontAwesomeIcons.book,
                                  description: controller.data[0].description!),
                              const SpacerWidget(),
                              CustomKeyFacts(
                                  titleHead: "Key facts",
                                  iconHead: Icons.notes_rounded,
                                  vegetableType:
                                      controller.data[0].vegetableType!,
                                  lifeSpan: controller.data[0].lifespan!,
                                  plantingTime:
                                      controller.data[0].plantingTime!),
                              CustomCharacteristics(
                                titleHead: "Characteristics",
                                iconHead: FontAwesomeIcons.envira,
                                harvestTime: controller.data[0].harvestTime!,
                              ),
                              Container(
                                height: 30,
                                color: const Color.fromARGB(115, 235, 235, 235),
                              )
                            ],
                          )
                        ],
                      ),
                    ));
        }),
      ),
    );
  }
}
