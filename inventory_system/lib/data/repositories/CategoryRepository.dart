import 'package:inventory_system/Utilities/constants.dart';
import 'package:inventory_system/data/models/res/ResGetCategoryList.dart';
import 'package:inventory_system/data/models/res/ResGetItemList.dart';
import 'package:inventory_system/data/models/res/ResGetSubCategoryList.dart';
import 'package:inventory_system/services/webService.dart';

class CategoryRepository{

  WebService _webService = WebService();

  Future<ResGetCategory> getCategoryListApi() async{
    var res = await _webService.getApi(kGetCategoryList);

    return ResGetCategory.fromJson(res);
  }

  Future<ResGetSubCategory> getSubCategoryListApi(int categoryId) async{
    var res = await _webService.getApiWithQuery(kGetSubCategoryList, {
      "Categoryid" : categoryId.toString()
    });

    return ResGetSubCategory.fromJson(res);
  }

  Future<ResGetItem> getItemList(int categoryId,int subCategoryId,int productId) async{
    var res = await _webService.getApiWithQuery(kGetItemList, {
      "CategoryID" : categoryId.toString(),
      "SubCategoryID" : subCategoryId.toString(),
      "ProductID" : productId.toString(),
    });

    return ResGetItem.fromJson(res);
  }

}