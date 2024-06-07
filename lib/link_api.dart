class AppLink {
  static String server = "https://yfcfarmfinds.com/yfcfarmfinds";
  static String test = "$server/test.php";

  // ================================= Auth ====================================

  static String checkNumber = "$server/auth/check_number.php";
  static String checkNumberSign = "$server/auth/check_number_signIn.php";
  static String phoneSignup = "$server/auth/phone_signup.php";
  static String phoneSignin = "$server/auth/phone_signin.php";
  static String checkEmail = "$server/auth/check_email.php";
  static String emailSignup = "$server/auth/google_signup.php";
  static String emailSignin = "$server/auth/google_signin.php";
  static String login = "$server/auth/login.php";
  // ================================= Update User ====================================
  static String userProfile = "$server/auth/";
  static String updateUserProfile = "$server/auth/update_user_profile.php";
  static String updateUserFullName = "$server/auth/update_user_fullName.php";
  static String updateUserPhone = "$server/auth/update_user_phone.php";
  static String sendVerificationCode =
      "$server/auth/verification/send_verification_code.php";
  static String verifyEmail = "$server/auth/verification/verify_email.php";

  // ================================ Shop =====================================

  static String emailBind = "$server/shop/google_bind.php";
  static String registerShop = "$server/shop/register_shop.php";
  static String phoneBind = "$server/shop/phone_bind.php";
  static String shopImage = "$server/shop/";

  // =============================== Product ===================================

  static String fetchVariation = "$server/product/fetch_variation.php";
  static String addProduct = "$server/product/add_product.php";
  static String fetchProducts = "$server/product/fetch_products.php";
  static String delistProduct = "$server/product/delist_product.php";
  static String publishProduct = "$server/product/publish_product.php";

  // =============================== Scanner ===================================

  static String vegetable = "$server/vegetable/fetch_vegetable.php";
  static String searchVegetable = "$server/vegetable/search_vegetable.php";
  static String vegetableImage = "$server/vegetable/image/";

  // =============================== Home ===================================

  static String productImage = "$server/product/";
  static String shops = "$server/home/fetch_shop.php";
  static String shopTestProducts = "$server/home/fetch_test_shop_product.php";
  static String fetchTotalTransaction =
      "$server/home/fetch_total_transaction.php";

  static String fetchTestProductReviews =
      "$server/home/fetch_test_product_reviews.php";

  // =============================== Cart ===================================
  static String updateQuantity = "$server/home/update_quantity.php";
  static String deleteCart = "$server/home/delete_cart.php";
  static String addToCart = "$server/home/add_to_cart.php";
  static String fetchCart = "$server/home/fetch_cart.php";

  // =============================== Cart ===================================
  static String placeOrder = "$server/home/place_order.php";

  // =============================== Address ===================================
  static String selectDefaultAddress =
      "$server/home/select_default_address.php";
  static String editAddress = "$server/home/edit_address.php";
  static String addAddress = "$server/home/add_address.php";
  static String fetchAddress = "$server/home/fetch_address.php";

  // =============================== Order ================================
  static String fetchOrders = "$server/order/fetch_test_orders.php";
  static String confirmReceived = "$server/order/confirm_received.php";
  static String cancelOrder = "$server/order/cancel_order.php";
  static String buyAgain = "$server/order/buy_again.php";

  // =============================== Shop Order ================================
  static String fetchShopOrder = "$server/shop_order/fetch_shop_order.php";

  // =============================== Review ================================
  static String reviewImage = "$server/review/";
  static String submitFeedback = "$server/review/submit_feedback.php";
  static String updateFeedback = "$server/review/update_review.php";
  static String fetchReviews = "$server/review/fetch_reviews.php";

  // =============================== Version ================================
  static String appVersion = "$server/app_version.php";
}
