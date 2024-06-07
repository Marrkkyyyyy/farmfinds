import 'package:ecommerce/controller/order/order_controller.dart';
import 'package:ecommerce/view/screen/order/cancelled.dart';
import 'package:ecommerce/view/screen/order/completed.dart';
import 'package:ecommerce/view/screen/order/processing.dart';
import 'package:ecommerce/view/screen/order/shipped.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ViewAllOrders extends StatelessWidget {
  ViewAllOrders({Key? key}) : super(key: key);
  final controller = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: WillPopScope(
        onWillPop: () async {
          return true;
        },
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
              ),
            ),
            elevation: 2,
            leadingWidth: 34,
            title: Text("My Orders"),
            bottom: TabBar(
              controller: controller.tabController,
              labelPadding: EdgeInsets.symmetric(horizontal: 20.0),
              isScrollable: true,
              indicatorWeight: 1,
              unselectedLabelStyle: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.normal),
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
                Tab(
                  child: Text("Cancelled"),
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
                      controller: controller.tabController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Processing(),
                        Shipped(),
                        Completed(),
                        Cancelled(),
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
