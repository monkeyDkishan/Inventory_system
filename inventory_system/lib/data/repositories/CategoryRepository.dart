import 'package:inventory_system/Utilities/constants.dart';
import 'package:inventory_system/data/models/res/ResGetCategoryList.dart';
import 'package:inventory_system/data/models/res/ResGetItemID.dart';
import 'package:inventory_system/data/models/res/ResGetItemList.dart';
import 'package:inventory_system/data/models/res/ResGetSubCategoryList.dart';
import 'package:inventory_system/services/webService.dart';

class CategoryRepository{

  WebService _webService = WebService();

  Future<ResGetItemId> getItemId({String text,int page}) async{
    var res = await _webService.getApiWithQuery(kGetItemID, {
      'ItemCode': text,
      'Page': '${page ?? 1}'
    });

    try{
      return ResGetItemId.fromJson(res);
    }catch(e){
      throw "Decoding Error";
    }
  }

  Future<ResGetCategory> getCategoryListApi() async{
    var res = await _webService.getApi(kGetCategoryList);

    try{
      return ResGetCategory.fromJson(res);
    }catch(e){
      throw "Decoding Error";
    }
  }

  Future<ResGetSubCategory> getSubCategoryListApi(int categoryId) async{
    var res = await _webService.getApiWithQuery(kGetSubCategoryList, {
      "Categoryid" : categoryId.toString()
    });

    try{
      return ResGetSubCategory.fromJson(res);
    }catch(e){
      throw "Decoding Error";
    }
  }

  Future<ResGetItem> getItemList(int categoryId,int subCategoryId,int productId) async{

    if(productId != null){
      var res = await _webService.getApiWithQuery(kGetItemList, {
        "ProductID" : productId.toString(),
      });

      try{
        return ResGetItem.fromJson(res);
      }catch(e){
        throw "Decoding Error";
      }
    }else{
      var res = await _webService.getApiWithQuery(kGetItemList, {
        "CategoryID" : categoryId.toString(),
        "SubCategoryID" : subCategoryId.toString(),
        // "ProductID" : productId.toString(),
      });

      try{
        return ResGetItem.fromJson(res);
      }catch(e){
        throw "Decoding Error";
      }
    }


  }

}