import 'package:ecommerce/controller/scan/search_vegetable_controller.dart';
import 'package:ecommerce/core/class/handling_data_request.dart';
import 'package:ecommerce/data/model/search_vegetable_model.dart';
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

class SearchVegetableProfile extends StatelessWidget {
  final SearchVegetableModel vegetable;
  final controller = Get.put(SearchVegetableController());
  SearchVegetableProfile({super.key, required this.vegetable});

  @override
  Widget build(BuildContext context) {
    controller.imageURLs.value = vegetable.imageURLs!.split(',');

    return Scaffold(
      body: GetBuilder<SearchVegetableController>(builder: (controller) {
        return HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: SingleChildScrollView(
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
                          imageURLs: controller.imageURLs),
                      Obx(() {
                        return CustomImageIndex(
                            imageURLs: controller.imageURLs,
                            currentIndex: controller.currentIndex.value);
                      })
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SpacerWidget(),
                      CustomVegetableHead(
                          englishName: vegetable.englishName!,
                          aka: vegetable.aKA!,
                          familyName: vegetable.familyName!),
                      const SizedBox(
                        height: 15,
                      ),
                      const SpacerWidget(),
                      CustomScientificClassication(
                        tagalogName: vegetable.tagalogName!,
                        botanicalName: vegetable.botanicalName!,
                        familyName: vegetable.familyName!,
                        iconHead: FontAwesomeIcons.tableCellsLarge,
                        titleHead: "Scientific classification",
                      ),
                      CustomDescriptionVegetable(
                          titleHead: "Description",
                          iconHead: FontAwesomeIcons.book,
                          description: vegetable.description!),
                      const SpacerWidget(),
                      CustomKeyFacts(
                          titleHead: "Key facts",
                          iconHead: Icons.notes_rounded,
                          vegetableType: vegetable.vegetableType!,
                          lifeSpan: vegetable.lifespan!,
                          plantingTime: vegetable.plantingTime!),
                      CustomCharacteristics(
                        titleHead: "Characteristics",
                        iconHead: FontAwesomeIcons.envira,
                        harvestTime: vegetable.harvestTime!,
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
    );
  }
}
