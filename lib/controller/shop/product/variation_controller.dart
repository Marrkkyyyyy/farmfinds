import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/core/functions/handling_data_controller.dart';
import 'package:ecommerce/data/datasource/remote/product/product.dart';
import 'package:ecommerce/view/widget/show_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VariationController extends GetxController {
  ProductData productController = ProductData(Get.find());
  Map<String, TextEditingController> variationPrice = {};
  Map<String, List<Map<String, dynamic>>> unitVariations = {};
  RxList<Map<String, dynamic>> variationList = RxList<Map<String, dynamic>>([]);
  List<String> selectedVariation = [];
  List<String> units = [];
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late StatusRequest statusRequest;

  resetData() {
    selectedVariation.clear();
    variationPrice.clear();
    variationList.clear();
    units.clear();
    update();
  }

  refreshVariation() {
    fetchVariation();
    update();
  }

  onChangedCheckbox(bool val, Map<String, dynamic> variation) {
    final variationID = variation['variationID'].toString();
    final unit = "${variation['value']} ${variation['units']}";
    if (val) {
      selectedVariation.add(variationID);
      variationPrice[unit] = TextEditingController();
    } else {
      selectedVariation.remove(variationID);
      variationPrice.remove(unit);
      units.remove(unit);
      variationList.removeWhere((map) => map['variationName'] == unit);
    }
    update();
  }

  fetchVariation() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await productController.fetchVariation();
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var unitsData = response['units'];
        unitsData.forEach((unitName, variations) {
          if (variations is List) {
            unitVariations[unitName] =
                List<Map<String, dynamic>>.from(variations);
          }
        });
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  validateVariation() {
    if (variationPrice.length > 1) {
      Get.toNamed(AppRoute.setPrice);
    } else {
      showErrorMessage(
          "Please select at least two variations before proceeding");
    }
  }

  validatePrice() {
    var formData = formstate.currentState;
    if (formData!.validate()) {
      variationPrice.forEach((variationName, textController) {
        final price = textController.text;
        final variationMap = {
          'variationName': variationName,
          'price': price,
        };

        if (!units.contains(variationName)) {
          units.add(variationName);
          variationList.add(variationMap);
        }
      });
      variationList.sort((a, b) {
        final unitA = a['variationName'];
        final unitB = b['variationName'];

        final unitAValue = int.tryParse(unitA.split(' ')[0]) ?? 0;
        final unitBValue = int.tryParse(unitB.split(' ')[0]) ?? 0;

        return unitAValue.compareTo(unitBValue);
      });
      update();
      Get.back();
      Get.back();
    }
  }

  @override
  void onInit() {
    fetchVariation();
    super.onInit();
  }
}
