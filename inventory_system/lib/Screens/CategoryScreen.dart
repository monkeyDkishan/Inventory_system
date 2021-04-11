import 'dart:async';

import 'package:flutter/material.dart';
import 'package:inventory_system/Screens/SubCategoryScreen.dart';
import 'package:inventory_system/Utilities/ColorUtil.dart';
import 'package:inventory_system/Utilities/ImageUtil.dart';
import 'package:inventory_system/Utilities/constants.dart';
import 'package:inventory_system/component/CartButton.dart';
import 'package:inventory_system/component/CustomPopup.dart';
import 'package:inventory_system/component/LoadingSmall.dart';
import 'package:inventory_system/component/NoDataFoundContainer.dart';
import 'package:inventory_system/data/models/CategoryModel.dart';
import 'package:inventory_system/data/models/res/ResGetCategoryList.dart';
import 'package:inventory_system/data/models/res/ResGetSubCategoryList.dart';
import 'package:inventory_system/data/repositories/CategoryRepository.dart';
import 'package:inventory_system/services/CartService.dart';
import 'package:inventory_system/services/webService.dart';

class CategoryScreen extends StatefulWidget {

  CategoryScreen({this.categoryId,this.categoryName});

  final String categoryName;
  final int categoryId;

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  bool isLoading = false;

  List<ResGetSubCategoryList> resList;

  int totalCartItem = 0;

  updateCount() async {
    var cart = await CartService.getCarts();
    setState(() {
      totalCartItem = cart.cart.length;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateCount();
    CategoryModel.getSubCategoryList(id: widget.categoryId,completion: (apiRes){
      switch(apiRes.state){
        case Status.LOADING:
          setState(() {
            isLoading = true;
          });
          break;
        case Status.COMPLETED:
          setState(() {
            isLoading = false;
            resList = apiRes.data.data.list;
          });
          break;
        case Status.ERROR:
          setState(() {
            isLoading = false;
          });
          CustomPopup(context, title: 'Sorry', message: apiRes.msg ?? "Error", primaryBtnTxt: 'OK');
          break;
      }
    });
    
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
          actions: [
            CartForAll(totalCart: totalCartItem,callBack: (){
              updateCount();
            },)
          ]
      ),
      body: buildContainer(),
    );
  }

  Widget buildContainer() {

    if(isLoading){
      return LoadingSmall(color: ColorUtil.primoryColor,size: 22,);
    }

    if(resList == null || resList.length <= 0){
      return NoDataFoundContainer();
    }

    return Container(
      child: SafeArea(
        child: ListView.builder(
          itemCount: resList.length,
          padding: EdgeInsets.symmetric(vertical: 10),
          itemBuilder: (BuildContext context, int index){

            final res = resList[index];

            return ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SubCategoryScreen(subCategoryName: res.subCategoryName,productId: res.productid,subCategoryId: res.subcategoryid ?? 0,categoryId: res.categoryid,))).then((value) {
                  updateCount();
                });
              },
              title: Text(res.subCategoryName ?? "productName",style: TextStyle(color: Colors.black,fontSize: 20),),
              subtitle: Text(res.description ?? "description"),
              trailing: Icon(Icons.arrow_forward_ios_sharp,size: 20,),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    color: Colors.white,
                    child: ImageUtil.fadeInImage( kImgUrl + res.imageUrl ?? "https://socialistmodernism.com/wp-content/uploads/2017/07/placeholder-image.png", 'Assets/Images/placeholder.png'),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
