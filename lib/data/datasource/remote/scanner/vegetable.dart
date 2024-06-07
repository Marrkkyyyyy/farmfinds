import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/link_api.dart';

class Vegetable {
  Crud crud;
  Vegetable(this.crud);

  getData(String englishName) async {
    var response =
        await crud.postData(AppLink.vegetable, {"english_name": englishName});
    return response.fold((l) => l, (r) => r);
  }

  getSearchData(String englishName) async {
    var response =
        await crud.postData(AppLink.searchVegetable, {"search": englishName});
    return response.fold((l) => l, (r) => r);
  }
}
