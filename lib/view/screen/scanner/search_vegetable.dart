import 'dart:math';

import 'package:ecommerce/controller/scan/scanner_controller.dart';
import 'package:ecommerce/core/constant/image_asset.dart';
import 'package:ecommerce/data/model/search_vegetable_model.dart';
import 'package:ecommerce/view/screen/scanner/search_profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SearchVegetable extends SearchDelegate<String> {
  ScannerController controller = Get.find();
  SearchVegetableModel? selectedVegetable;

  @override
  String get searchFieldLabel => 'Search Vegetable...';
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.teal.shade300,
        ),
        textTheme: TextTheme(
            headline2:
                GoogleFonts.manrope(fontSize: 22, fontWeight: FontWeight.w600),
            headline5: GoogleFonts.manrope(
              fontSize: 16,
            ),
            headline6: GoogleFonts.manrope(fontSize: 16, color: Colors.white)),
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.white),
        ));
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (selectedVegetable != null) {
      return SearchVegetableProfile(
        vegetable: selectedVegetable!,
      );
    } else {
      return const SizedBox();
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    controller.checkInternet();
    return GetBuilder<ScannerController>(builder: (controller) {
      return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: controller.isInternet.value != true
              ? Center(
                  child: Lottie.asset(AppImageASset.offline,
                      width: 250, height: 250),
                )
              : FutureBuilder<List<SearchVegetableModel>>(
                  future: controller.getVegetableSearch(query: query),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data?.toList();
                      return data!.isEmpty
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2!,
                                    ),
                                  ],
                                ),
                                Center(
                                  child: Lottie.asset(
                                      AppImageASset.noSearchFounnd,
                                      width: 250,
                                      height: 250),
                                ),
                              ],
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.only(top: 10),
                              reverse: false,
                              shrinkWrap: false,
                              itemCount: min(10, data.length),
                              itemBuilder: (context, index) {
                                var vegetable = data[index];
                                var englishName = vegetable.englishName;
                                var tagalogName = vegetable.tagalogName;
                                var displayName = englishName;
                                if (tagalogName!
                                    .toLowerCase()
                                    .contains(query.toLowerCase())) {
                                  displayName = tagalogName;
                                }

                                if (englishName!
                                    .toLowerCase()
                                    .contains(query.toLowerCase())) {
                                  displayName = englishName;
                                }
                                return InkWell(
                                  onTap: () {
                                    query = displayName.toString();
                                    selectedVegetable = data[index];
                                    showResults(context);
                                  },
                                  child: Container(
                                    color: const Color.fromARGB(8, 0, 0, 0),
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 3),
                                    child: ListTile(
                                      minLeadingWidth: 0,
                                      dense: true,
                                      leading: Container(
                                        width: 56,
                                        height: 56,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.transparent,
                                            width: 2.0,
                                          ),
                                        ),
                                        child: Image.asset(
                                          "${AppImageASset.rootImagesVegetable}/${data[index].id}.jpg",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      title: Text(displayName.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5!
                                              .copyWith(
                                                  fontSize: 16,
                                                  color: const Color.fromARGB(
                                                      167, 0, 0, 0))),
                                    ),
                                  ),
                                );
                              },
                            );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }));
    });
  }
}
