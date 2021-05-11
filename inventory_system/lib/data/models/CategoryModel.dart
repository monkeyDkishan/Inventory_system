import 'package:inventory_system/data/models/res/BaseRes.dart';
import 'package:inventory_system/data/models/res/ResGetCategoryList.dart';
import 'package:inventory_system/data/models/res/ResGetItemList.dart';
import 'package:inventory_system/data/models/res/ResGetProfileDetails.dart';
import 'package:inventory_system/data/models/res/ResGetSubCategoryList.dart';
import 'package:inventory_system/data/models/res/ResIsValidOTP.dart';
import 'package:inventory_system/data/repositories/AuthRepository.dart';
import 'package:inventory_system/data/repositories/CategoryRepository.dart';
import 'package:inventory_system/data/repositories/UserRepository.dart';
import 'package:inventory_system/services/userPreferencesService.dart';
import 'package:inventory_system/services/webService.dart';

class CategoryModel {
  static CategoryRepository _userRepo = CategoryRepository();

  static var categoriesRes = ApiResponse<ResGetCategory>();

  static var subCategoriesRes = ApiResponse<ResGetSubCategory>();

  static var itemRes = ApiResponse<ResGetItem>();

  static Future getCategoryList({Function(ApiResponse<ResGetCategory>,bool) completion}) async {

    bool isUserAuth = true;

    try {
      categoriesRes.state = Status.LOADING;

      completion(categoriesRes,isUserAuth);

      ResGetCategory res = await _userRepo.getCategoryListApi();

      if (res.status == 0) {
        isUserAuth = true;
        throw res.message;
      }
      else if(res.status == 2){
        isUserAuth = false;
        throw res.message;
      }

      categoriesRes.data = res;
      categoriesRes.state = Status.COMPLETED;
      completion(categoriesRes,isUserAuth);
    } catch (e) {
      print(e);
      categoriesRes.msg = e.toString();
      categoriesRes.state = Status.ERROR;
      completion(categoriesRes,isUserAuth);
    }
  }

  static Future getSubCategoryList({int id,Function(ApiResponse<ResGetSubCategory>) completion}) async {

    try {
      subCategoriesRes.state = Status.LOADING;

      completion(subCategoriesRes);

      ResGetSubCategory res = await _userRepo.getSubCategoryListApi(id);

      if (res.status == 0) {
        throw res.message;
      }
      // else if(res.status == 2){
      //   //UN AUTHORISEa
      // }

      subCategoriesRes.data = res;
      subCategoriesRes.state = Status.COMPLETED;
      completion(subCategoriesRes);
    } catch (e) {
      print(e);
      subCategoriesRes.msg = e.toString();
      subCategoriesRes.state = Status.ERROR;
      completion(subCategoriesRes);
    }
  }

  static Future getItemList({int catId,int subCatId,int productId,Function(ApiResponse<ResGetItem>) completion}) async {

    try {
      itemRes.state = Status.LOADING;

      completion(itemRes);

      ResGetItem res = await _userRepo.getItemList(catId, subCatId, productId);

      if (res.status == 0) {
        throw res.message;
      }
      // else if(res.status == 2){
      //   //UN AUTHORISEa
      // }

      itemRes.data = res;
      itemRes.state = Status.COMPLETED;
      completion(itemRes);
    } catch (e) {
      print(e);
      itemRes.msg = e.toString();
      itemRes.state = Status.ERROR;
      completion(itemRes);
    }
  }
}
