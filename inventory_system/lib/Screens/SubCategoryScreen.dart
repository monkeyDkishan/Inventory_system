import 'package:flutter/material.dart';
import 'package:inventory_system/Screens/AddItemToCartPopup.dart';
import 'package:inventory_system/Screens/ItemDetailScreen.dart';
import 'package:inventory_system/Utilities/ColorUtil.dart';
import 'package:inventory_system/Utilities/ImageUtil.dart';
import 'package:inventory_system/Utilities/constants.dart';
import 'package:inventory_system/component/CartButton.dart';
import 'package:inventory_system/component/CustomPopup.dart';
import 'package:inventory_system/component/LoadingSmall.dart';
import 'package:inventory_system/component/NoDataFoundContainer.dart';
import 'package:inventory_system/data/models/CategoryModel.dart';
import 'package:inventory_system/data/models/res/ResGetItemList.dart';
import 'package:inventory_system/data/repositories/CategoryRepository.dart';
import 'package:inventory_system/services/CartService.dart';
import 'package:inventory_system/services/webService.dart';

class SubCategoryScreen extends StatefulWidget {

  final String subCategoryName;
  final int categoryId;
  final int subCategoryId;
  final int productId;

  const SubCategoryScreen({this.subCategoryName, this.subCategoryId, this.productId, this.categoryId});

  @override
  _SubCategoryScreenState createState() =>
      _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {

  FullScreenDialog _myDialog;

  bool isLoading = false;

  List<ResGetItemList> resList;

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
    CategoryModel.getItemList(productId: widget.productId,catId: widget.categoryId,subCatId: widget.subCategoryId,completion: (res) {
      switch (res.state) {
        case Status.LOADING:
          setState(() {
            isLoading = true;
          });
          break;
        case Status.COMPLETED:
          setState(() {
            isLoading = false;
            resList = res.data.data.list;
          });
          break;
        case Status.ERROR:
          setState(() {
            isLoading = false;
          });
          CustomPopup(context,
              title: 'Sorry', message: res.msg ?? "Error", primaryBtnTxt: 'OK');
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.subCategoryName), actions: [
        CartForAll(totalCart: totalCartItem,callBack: (){
          updateCount();
        },)
      ]),
      body: Container(
        child: SafeArea(
          child: buildListView(),
        ),
      ),
    );
  }

  cool(){

  }

  Widget buildListView() {

    if(isLoading){
      return LoadingSmall(color: ColorUtil.primoryColor,size: 22,);
    }

    if(resList == null || resList.length <= 0){
      return NoDataFoundContainer();
    }

    return ListView.builder(
          itemCount: resList.length,
          itemBuilder: (BuildContext context, int index) {

            final res = resList[index];

            return Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ItemDetailScreen(index: index,itemDetail: res,))).then((value) {
                    print('cool');
                    updateCount();
                  });
                },
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Container(
                                  color: Colors.black.withOpacity(0.1),
                                  child: ImageUtil.fadeInImage( (kImgUrl + res.imageList.first.imageUrl.toString()) ?? 'https://socialistmodernism.com/wp-content/uploads/2017/07/placeholder-image.png', 'Assets/Images/placeholder.png'),
                                )
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(res.productName ?? "Product name"),
                                      Text(res.description ?? "Description", maxLines: 2),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(child: Container(),),
                                      InkWell(
                                        onTap: () async {
                                          //Add item in cart popup here
                                          Navigator.push(context, new MaterialPageRoute(
                                            builder: (BuildContext context) => FullScreenDialog(units: [UnitItem(unitId: res.standeruom,unitPrice: res.unitprice,unitName: res.unitname)],
                                              completion: (unit, quantity, notes) async {

                                                final cartItem = await CartService.getCarts();

                                                bool exist = cartItem.cart.any((element) {
                                                  return element.productid == res.productid ?? 0;
                                                });

                                                print('exist: $exist');

                                                if(!exist){
                                                  CartService.addItemObj(Cart(productid: res.productid,categoryid: res.categoryid,subcategoryid: res.subcategoryid,productName: res.productName,description: res.description,imageUrl: res.imageList.first.imageUrl.toString(),unitName: unit.unitName,unitPrice: unit.unitPrice,unitId: unit.unitId,quantity: quantity,note: notes));
                                                  CustomPopup(context, title: 'Cart', message: 'Item added in cart', primaryBtnTxt: 'OK');
                                                }else{
                                                  CustomPopup(context, title: 'Cart', message: 'Already in the cart', primaryBtnTxt: 'OK');
                                                }
                                                updateCount();
                                              },
                                            ),
                                            fullscreenDialog: true,
                                          ));
// CartService.addItemObj(Cart(productid: res.productid,categoryid: res.categoryid,subcategoryid: res.subcategoryid,productName: res.productName,description: res.description,imageUrl: res.imageList.first.imageUrl.toString()));
                                          updateCount();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: ColorUtil.buttonColor
                                          ),
                                          padding: EdgeInsets.all(10),
                                          child: Text("ADD",style: TextStyle(color: Colors.white),),
                                        ),
                                      )
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
  }
}
