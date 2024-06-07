import 'package:ecommerce/controller/shop/product_status/product_status_controller.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/view/screen/shop/product_status/delisted_products.dart';
import 'package:ecommerce/view/screen/shop/product_status/live_products.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopProductStatus extends StatelessWidget {
  final controller = Get.put(ProductStatusController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: FaIcon(
                  FontAwesomeIcons.arrowLeft,
                  color: Colors.teal,
                  size: 20,
                ),
              )),
          actions: [
            Center(
              child: GestureDetector(
                child: Container(
                  margin: const EdgeInsets.only(right: 3),
                  padding: const EdgeInsets.all(12),
                  child: const FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                    color: Colors.black54,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
          backgroundColor: Colors.white,
          elevation: 2,
          foregroundColor: Colors.black,
          leadingWidth: 34,
          title: Text(
            "My Products",
          ),
          bottom: TabBar(
            indicatorWeight: 1,
            unselectedLabelStyle:
                GoogleFonts.manrope(fontWeight: FontWeight.normal),
            indicatorColor: Colors.teal,
            labelColor: Colors.teal,
            labelStyle:
                GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w500),
            tabs: [
              Tab(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Live"),
                      Obx(() {
                        return Text("(${controller.liveProducts.length})");
                      })
                    ]),
              ),
              Tab(
                child: Column(children: [const Text("Sold out"), Text("(0)")]),
              ),
              Tab(
                child: Column(children: [
                  const Text("Violation"),
                  Obx(() {
                    return Text("(${controller.violationProducts.length})");
                  }),
                ]),
              ),
              Tab(
                child: Column(children: [
                  const Text("Delisted"),
                  Obx(() {
                    return Text("(${controller.delistedProducts.length})");
                  }),
                ]),
              )
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            LiveProducts(),
            Container(),
            Container(),
            DelistedProducts(),
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(5),
          color: Colors.white,
          child: TextButton(
            style: TextButton.styleFrom(
              fixedSize: Size(MediaQuery.of(context).size.width * .8, 47),
              shape: const RoundedRectangleBorder(),
              backgroundColor: const Color.fromARGB(255, 31, 129, 121),
            ),
            onPressed: () async {
              Get.toNamed(AppRoute.addProduct);
            },
            child: Text(
              "ADD NEW PRODUCT",
              style: GoogleFonts.manrope(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
