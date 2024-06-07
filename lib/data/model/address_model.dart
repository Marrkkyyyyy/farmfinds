class AddressModel {
  String? userAddressID;
  String? status;
  String? addressID;
  String? userID;
  String? fullName;
  String? phoneNumber;
  String? region;
  String? province;
  String? city;
  String? barangay;
  String? postalCode;
  String? streetName;

  AddressModel(
      {this.userAddressID,
      this.status,
      this.addressID,
      this.userID,
      this.fullName,
      this.phoneNumber,
      this.region,
      this.province,
      this.city,
      this.barangay,
      this.postalCode,
      this.streetName});

  AddressModel.fromJson(Map<String, dynamic> json) {
    userAddressID = json['userAddressID'].toString();
    status = json['status'].toString();
    addressID = json['addressID'].toString();
    userID = json['userID'].toString();
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    region = json['region'];
    province = json['province'];
    city = json['city'];
    barangay = json['barangay'];
    postalCode = json['postalCode'].toString();
    streetName = json['streetName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userAddressID'] = this.userAddressID;
    data['status'] = this.status;
    data['addressID'] = this.addressID;
    data['userID'] = this.userID;
    data['fullName'] = this.fullName;
    data['phoneNumber'] = this.phoneNumber;
    data['region'] = this.region;
    data['province'] = this.province;
    data['city'] = this.city;
    data['barangay'] = this.barangay;
    data['postalCode'] = this.postalCode;
    data['streetName'] = this.streetName;
    return data;
  }
}
