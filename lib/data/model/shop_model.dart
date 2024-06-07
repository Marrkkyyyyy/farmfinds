class ShopModel {
  String? userID;
  String? shopID;
  String? shopName;
  String? pickupAddressID;
  String? profile;
  String? province;
  String? city;
  String? barangay;
  String? postalCode;
  String? streetName;
  String? totalRating;
  String? totalRows;

  ShopModel(
      {this.userID,
      this.shopID,
      this.shopName,
      this.pickupAddressID,
      this.profile,
      this.province,
      this.city,
      this.barangay,
      this.postalCode,
      this.streetName,
      this.totalRating,
      this.totalRows});

  ShopModel.fromJson(Map<String, dynamic> json) {
    userID = json['userID'].toString();
    shopID = json['shopID'].toString();
    shopName = json['shopName'];
    pickupAddressID = json['pickupAddressID'].toString();
    profile = json['profile'];
    province = json['province'];
    city = json['city'];
    barangay = json['barangay'];
    postalCode = json['postalCode'].toString();
    streetName = json['streetName'];
    totalRating = json['totalRating'].toString();
    totalRows = json['totalRows'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['shopID'] = this.shopID;
    data['shopName'] = this.shopName;
    data['pickupAddressID'] = this.pickupAddressID;
    data['profile'] = this.profile;
    data['province'] = this.province;
    data['city'] = this.city;
    data['barangay'] = this.barangay;
    data['postalCode'] = this.postalCode;
    data['streetName'] = this.streetName;
    data['totalRating'] = this.totalRating;
    data['totalRows'] = this.totalRows;
    return data;
  }
}
