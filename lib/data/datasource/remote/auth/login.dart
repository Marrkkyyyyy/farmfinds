import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/link_api.dart';

class LoginData {
  Crud crud;
  LoginData(this.crud);

  checkNumberSignin(String phoneNumber) async {
    var response = await crud
        .postData(AppLink.checkNumberSign, {"phoneNumber": phoneNumber});

    return response.fold((l) => l, (r) => r);
  }

  login(String emailPhone, String password) async {
    var response = await crud.postData(
        AppLink.login, {"emailPhone": emailPhone, "password": password});

    return response.fold((l) => l, (r) => r);
  }

  emailLogin(String email) async {
    var response = await crud.postData(AppLink.emailSignin, {"email": email});

    return response.fold((l) => l, (r) => r);
  }

  phoneSignin(String phoneNumber) async {
    var response =
        await crud.postData(AppLink.phoneSignin, {"phoneNumber": phoneNumber});

    return response.fold((l) => l, (r) => r);
  }
}
