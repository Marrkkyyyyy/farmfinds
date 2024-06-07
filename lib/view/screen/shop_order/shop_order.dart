import 'package:ecommerce/controller/shop_order/shop_order_controller.dart';
import 'package:ecommerce/view/screen/shop_order/completed.dart';
import 'package:ecommerce/view/screen/shop_order/processing.dart';
import 'package:ecommerce/view/screen/shop_order/shipped.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ShopOrder extends StatelessWidget {
  ShopOrder({super.key});
  final controller = Get.put(ShopOrderController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: controller.initialIndex,
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
          elevation: 2,
          leadingWidth: 34,
          title: Text("My Sales"),
          bottom: TabBar(
            indicatorWeight: 1,
            indicatorColor: Colors.teal,
            labelColor: Colors.teal,
            labelStyle: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.w600),
            tabs: const [
              Tab(
                child: Text("Processing"),
              ),
              Tab(
                child: Text("Shipped"),
              ),
              Tab(
                child: Text("Completed"),
              ),
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await controller.initData();
          },
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      ProcessingOrders(),
                      ShippedOrders(),
                      CompletedOrders(),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
