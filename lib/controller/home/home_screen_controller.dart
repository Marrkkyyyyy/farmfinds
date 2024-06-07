import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/core/functions/handling_data_controller.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/data/datasource/remote/home/shop.dart';
import 'package:ecommerce/data/model/new/order_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreenController extends GetxController {
  ShopData productController = ShopData(Get.find());
  MyServices myServices = Get.find();
  String? userID;
  RxString fullName = "".obs;
  RxString userProfile = "".obs;
  String? phoneNumber;
  String? email;
  RxString shopID = "".obs;
  int currentPage = 0;
  StatusRequest statusRequest = StatusRequest.none;
  late PageController pageController;
  var size = Rx<Size>(Size.zero);
  late RxString localVersion = "".obs;
  late RxString storeVersion = "".obs;
  late BuildContext context;
  late RxList<OrderItemModels> processingOrders = RxList<OrderItemModels>([]);
  late RxList<OrderItemModels> cancelledOrders = RxList<OrderItemModels>([]);
  late RxList<OrderItemModels> shippedOrders = RxList<OrderItemModels>([]);
  late RxList<OrderItemModels> completedOrders = RxList<OrderItemModels>([]);
  late RxList<OrderItemModels> toRateOrders = RxList<OrderItemModels>([]);

  initialData() {
    pageController = PageController(initialPage: 0);
    userID = myServices.getUser()?["userID"].toString();
    fullName.value = myServices.getUser()?["fullName"] ?? "";
    userProfile.value = myServices.getUser()?["userProfile"] ?? "";
    phoneNumber = myServices.getUser()?["phoneNumber"] ?? "";
    email = myServices.getUser()?["email"] ?? "";
    int? shopIDInt = myServices.getShop()?["shopID"];
    shopID.value = shopIDInt?.toString() ?? "";

    size.value = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    userID != null ? fetchTransaction() : null;
    _initPackageInfo();
    versionCheck();
  }

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );
  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();

    _packageInfo = info;
    localVersion.value = _packageInfo.version;
  }

  versionCheck() async {
    var response = await productController.fetchVersion();
    if (response["status"] == "success") {
      storeVersion.value = response["appVersion"];
      if (localVersion.value != storeVersion.value) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return WillPopScope(
              onWillPop: () async => false,
              child: Dialog(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                insetPadding: const EdgeInsets.all(0),
                child: Container(
                  color: const Color.fromARGB(255, 243, 243, 243),
                  width: MediaQuery.of(context).size.width * .9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          "Update Required",
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 20, top: 12, bottom: 20),
                        child: Text(
                          "The app is outdated. Please update to the latest version to continue.",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Colors.black87),
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                        height: 0,
                      ),
                      SizedBox(
                        height: Get.height * .060,
                        child: GestureDetector(
                          onTap: () {
                            _launchPlayStore();
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Center(
                              child: Text(
                                "Update Now",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                        color: Colors.teal,
                                        fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
  }

  void _launchPlayStore() async {
    const url =
        'https://play.google.com/store/apps/details?id=com.FarmFinds.ecommerce';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  logout() async {
    await myServices.clearPreferences();
    goToHome();
  }

  void goToTab(int page) {
    currentPage = page;
    pageController.jumpToPage(page);
    update();
  }

  goToHome() {
    Get.offAllNamed(AppRoute.home);
  }

  goToLogin() {
    Get.toNamed(AppRoute.login);
  }

  Future<void> refreshData() async {
    await fetchTransaction();
  }

  Future<void> loadAddressData() async {
    await rootBundle.loadString('assets/address.json');
  }

  fetchTransaction() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await productController.fetchOrders(userID!);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> userOrderView = response['userorderview'];

        List<OrderItemModels> processedOrders = userOrderView
            .map((shopData) => OrderItemModels.fromJson(shopData))
            .where((orderModel) => orderModel.status == '1')
            .toList();

        List<OrderItemModels> cancelOrders = userOrderView
            .map((shopData) => OrderItemModels.fromJson(shopData))
            .where((orderModel) => orderModel.status == '4')
            .toList();
        List<OrderItemModels> shipOrders = userOrderView
            .map((shopData) => OrderItemModels.fromJson(shopData))
            .where((orderModel) =>
                (orderModel.status == '2' || orderModel.status == '3') &&
                orderModel.receiveConfirmed != '1')
            .toList();
        List<OrderItemModels> toRateOrder = userOrderView
            .map((shopData) => OrderItemModels.fromJson(shopData))
            .where((orderModel) =>
                orderModel.receiveConfirmed == '1' &&
                orderModel.reviewID == "null")
            .toList();
        List<OrderItemModels> completeOrders = userOrderView
            .map((shopData) => OrderItemModels.fromJson(shopData))
            .where((orderModel) => orderModel.receiveConfirmed == '1')
            .toList();

        completeOrders
            .sort((a, b) => a.dateReceived!.compareTo(b.dateReceived!));
        shipOrders.sort((a, b) => a.dateReceived!.compareTo(b.dateReceived!));

        processingOrders.assignAll(processedOrders.reversed.toList());
        cancelledOrders.assignAll(cancelOrders.reversed.toList());
        shippedOrders.assignAll(shipOrders.reversed.toList());
        toRateOrders.assignAll(toRateOrder.reversed.toList());
        completedOrders.assignAll(completeOrders.reversed.toList());
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  void updateProfile() {
    userProfile.value = myServices.getUser()!['userProfile'];
  }

  @override
  void onInit() {
    context = Get.context!;
    initialData();
    loadAddressData();
    super.onInit();
  }
}
