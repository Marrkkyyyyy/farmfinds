import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/link_api.dart';

class SignupData {
  Crud crud;
  SignupData(this.crud);

  checkNumber(String phoneNumber) async {
    var response =
        await crud.postData(AppLink.checkNumber, {"phoneNumber": phoneNumber});

    return response.fold((l) => l, (r) => r);
  }

  phoneSignup(String phoneNumber, String password) async {
    var response = await crud.postData(AppLink.phoneSignup,
        {"phoneNumber": phoneNumber, "password": password});
    return response.fold((l) => l, (r) => r);
  }

  checkEmail(String email) async {
    var response = await crud.postData(AppLink.checkEmail, {"email": email});
    return response.fold((l) => l, (r) => r);
  }

  emailSignup(String email, String password) async {
   
    var response = await crud
        .postData(AppLink.emailSignup, {"email": email, "password": password});
    return response.fold((l) => l, (r) => r);
  }
}
