import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/view/screen/address/add_address.dart';
import 'package:ecommerce/view/screen/address/address_selection.dart';
import 'package:ecommerce/view/screen/address/edit_address.dart';
import 'package:ecommerce/view/screen/address/my_address.dart';
import 'package:ecommerce/view/screen/auth/login.dart';
import 'package:ecommerce/view/screen/auth/login_phone_number.dart';
import 'package:ecommerce/view/screen/auth/otp.dart';
import 'package:ecommerce/view/screen/auth/otp_bind.dart';
import 'package:ecommerce/view/screen/auth/otp_update.dart';
import 'package:ecommerce/view/screen/auth/set_password.dart';
import 'package:ecommerce/view/screen/auth/signup.dart';
import 'package:ecommerce/view/screen/cart/cart.dart';
import 'package:ecommerce/view/screen/cart/place_order.dart';
import 'package:ecommerce/view/screen/home/change_email_otp.dart';
import 'package:ecommerce/view/screen/home/edit_email.dart';
import 'package:ecommerce/view/screen/home/edit_phone.dart';
import 'package:ecommerce/view/screen/home/edit_profile.dart';
import 'package:ecommerce/view/screen/home/edit_name.dart';
import 'package:ecommerce/view/screen/home/home_screen.dart';
import 'package:ecommerce/view/screen/home/product_item_list.dart';
import 'package:ecommerce/view/screen/home/product_profile.dart';
import 'package:ecommerce/view/screen/home/view_all_product_rating.dart';
import 'package:ecommerce/view/screen/order/cancelled_order_details.dart';
import 'package:ecommerce/view/screen/order/processing_order_details.dart';
import 'package:ecommerce/view/screen/rating/rate_product.dart';
import 'package:ecommerce/view/screen/order/shipped_order_details.dart';
import 'package:ecommerce/view/screen/order/completed_order_details.dart';
import 'package:ecommerce/view/screen/order/view_all_orders.dart';
import 'package:ecommerce/view/screen/rating/my_rating.dart';
import 'package:ecommerce/view/screen/rating/update_review.dart';
import 'package:ecommerce/view/screen/scanner/scanned_vegetable.dart';
import 'package:ecommerce/view/screen/scanner/scanner.dart';
import 'package:ecommerce/view/screen/shop/add_product.dart';
import 'package:ecommerce/view/screen/shop/edit_shop/edit_email.dart';
import 'package:ecommerce/view/screen/shop/edit_shop/edit_phone.dart';
import 'package:ecommerce/view/screen/shop/edit_shop/edit_pickup_address.dart';
import 'package:ecommerce/view/screen/shop/edit_shop/edit_shop.dart';
import 'package:ecommerce/view/screen/shop/product_status/shop_product_status.dart';
import 'package:ecommerce/view/screen/shop/shop.dart';
import 'package:ecommerce/view/screen/shop/variation/add_variation.dart';
import 'package:ecommerce/view/screen/shop/variation/variation_price.dart';
import 'package:ecommerce/view/screen/shop_order/shop_order.dart';
import 'package:ecommerce/view/screen/shop_order/to_ship_details.dart';
import 'package:ecommerce/view/screen/start_selling/shop_registration/phone_bind.dart';
import 'package:ecommerce/view/screen/start_selling/shop_registration/shop_registration.dart';
import 'package:ecommerce/view/screen/start_selling/welcome_registration.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>>? routes = [
  // GetPage(name: "/", page: () => const TestView()),
  GetPage(name: "/", page: () => HomeScreen()),
  GetPage(name: AppRoute.home, page: () => HomeScreen()),
  GetPage(
      name: AppRoute.login,
      page: () => LoginPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),
  GetPage(
      name: AppRoute.loginPhone,
      page: () => LoginPhone(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),
  GetPage(
      name: AppRoute.signUp,
      page: () => SignupPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),
  GetPage(
      name: AppRoute.otp,
      page: () => OTPPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),
  GetPage(
      name: AppRoute.setPassword,
      page: () => SetPassword(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),
  GetPage(
      name: AppRoute.welcomeRegistration,
      page: () => const WelcomeRegistration(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),
  GetPage(
      name: AppRoute.shopRegistration,
      page: () => ShopRegistration(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),

  GetPage(
      name: AppRoute.shop,
      page: () => ShopPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),
  GetPage(
      name: AppRoute.bindPhoneNumber,
      page: () => BindPhoneNumber(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),
  GetPage(
      name: AppRoute.otpBind,
      page: () => OTPBindPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),

  GetPage(
      name: AppRoute.addProduct,
      page: () => AddProduct(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),

  GetPage(
      name: AppRoute.addVariation,
      page: () => AddVariation(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),

  GetPage(
      name: AppRoute.setPrice,
      page: () => VariationPrice(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 150)),

  GetPage(
      name: AppRoute.scanner,
      page: () => Scanner(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 150)),
  GetPage(
      name: AppRoute.scannedVegetable,
      page: () => ScannedVegetable(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 150)),
  GetPage(
    name: AppRoute.productItemList,
    page: () => ProductItemList(),
  ),
  GetPage(
      name: AppRoute.productProfile,
      page: () => ProductProfile(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),
  GetPage(
      name: AppRoute.shopProductStatus,
      page: () => ShopProductStatus(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),
  GetPage(
      name: AppRoute.cartPage,
      page: () => CartPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),
  GetPage(
      name: AppRoute.placeOrder,
      page: () => PlaceOrder(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),
  GetPage(
      name: AppRoute.viewAllOrders,
      page: () => ViewAllOrders(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),

  GetPage(
      name: AppRoute.processingOrderDetails,
      page: () => ProcessingOrderDetails(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),

  GetPage(
      name: AppRoute.cancelledOrderDetails,
      page: () => CancelledOrderDetails(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),
  GetPage(
      name: AppRoute.shopOrder,
      page: () => ShopOrder(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),
  GetPage(
      name: AppRoute.editProfile,
      page: () => EditProfile(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),
  GetPage(
      name: AppRoute.editShop,
      page: () => EditShop(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),

  GetPage(
      name: AppRoute.editPhone,
      page: () => EditPhone(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),
  GetPage(
      name: AppRoute.editEmail,
      page: () => EditEmail(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),
  GetPage(
      name: AppRoute.editPickupAddress,
      page: () => EditPickupAddress(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),
  GetPage(
      name: AppRoute.toShipDetails,
      page: () => ToShipDetails(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),
  GetPage(
      name: AppRoute.shippedOrderDetails,
      page: () => ShippedOrderDetails(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),
  GetPage(
      name: AppRoute.completedOrderDetails,
      page: () => CompletedOrderDetails(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),
  GetPage(
      name: AppRoute.rateProduct,
      page: () => RateProduct(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),
  GetPage(
      name: AppRoute.myRating,
      page: () => MyRating(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),
  GetPage(
      name: AppRoute.viewAllProductRating,
      page: () => ViewAllProductRating(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),
  GetPage(
      name: AppRoute.updateTextField,
      page: () => UpdateName(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),
  GetPage(
      name: AppRoute.updateUserPhone,
      page: () => UpdateUserPhone(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),
  GetPage(
      name: AppRoute.otpUpdate,
      page: () => OTPUpdatePage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),
  GetPage(
      name: AppRoute.updateReview,
      page: () => UpdateReview(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),
  GetPage(
      name: AppRoute.myAddress,
      page: () => MyAddress(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),
  GetPage(
      name: AppRoute.addNewAddress,
      page: () => AddNewAddress(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),
  GetPage(
      name: AppRoute.editAddress,
      page: () => EditAddress(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),
  GetPage(
      name: AppRoute.addressSelection,
      page: () => AddressSelection(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),
  GetPage(
      name: AppRoute.updateEmail,
      page: () => UpdateEmail(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),
      GetPage(
      name: AppRoute.changeEmailOTP,
      page: () => ChangeEmailOTP(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),
];
