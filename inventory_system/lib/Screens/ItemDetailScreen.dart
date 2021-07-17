import 'package:flutter/material.dart';
import 'package:inventory_system/Screens/AddItemToCartPopup.dart';
import 'package:inventory_system/Screens/CartScreen.dart';
import 'package:inventory_system/Utilities/ColorUtil.dart';
import 'package:inventory_system/Utilities/ImageUtil.dart';
import 'package:inventory_system/Utilities/constants.dart';
import 'package:inventory_system/component/CartButton.dart';
import 'package:inventory_system/component/CustomPopup.dart';
import 'package:inventory_system/data/models/res/ResGetItemList.dart';
import 'package:inventory_system/services/CartService.dart';

class ItemDetailScreen extends StatefulWidget {
  ItemDetailScreen({this.index,this.itemDetail});

  final ResGetItemList itemDetail;

  final int index;

  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {

  FullScreenDialog _myDialog;

  CartList cartItem;

  static show({BuildContext context, WidgetBuilder builder}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: builder,
    );
  }

  Widget imagesWidget(){
    final res = widget.itemDetail.imageList;
    return PageView.builder(
      itemCount: res.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(15),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              child: ImageUtil.fadeInImage(kImgUrl + (res[index].imageUrl ?? ""), 'Assets/Images/placeholder.png'),
            ),
          ),
        );
        },
    );
  }

  int totalCartItem = 0;

  updateCount() async {
    var cart = await CartService.getCarts();
    if(cart != null){
      setState(() {
        totalCartItem = cart.cart.length ?? 0;
        cartItem = cart;
      });
    }else{
      setState(() {
        totalCartItem = 0;
      });
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    List<UnitItem> units = [];

    int selIndex = 0;

    widget.itemDetail.unitmaster.asMap().forEach((index,element) {

      if(element.unitmasterid == widget.itemDetail.standeruom){
        selIndex = index;
      }

      units.add(UnitItem(unitId: element.unitmasterid ?? 0,unitPrice: element.unitPrize,unitName: element.unitname ?? ""));

    });

    UnitItem selectedUnit = units.where((element) {
      return widget.itemDetail.standeruom == element.unitId;
    }).last;


    _myDialog = new FullScreenDialog(
      dropdownValue: selectedUnit,
      index: selIndex,
      productID: widget.itemDetail.productid ?? 0,
      units: units,
      completion: (unit, quantity, notes, index) async {

        final res = widget.itemDetail;

        final cartItem = await CartService.getCarts();

        if(cartItem == null){

          final cartItem = Cart(productid: res.productid,categoryid: res.categoryid,subcategoryid: res.subcategoryid,productName: res.productName,description: res.description,imageUrl: res.imageList.first.imageUrl.toString(),unitName: unit.unitName,unitPrice: unit.unitPrice,unitId: unit.unitId,quantity: quantity,note: notes,unitmaster: res.unitmaster,selectedIndex: index);

          CartService.addItemObj(cartItem);

          // CartService.addItemObj(Cart(productid: res.productid,categoryid: res.categoryid,subcategoryid: res.subcategoryid,productName: res.productName,description: res.description,imageUrl: res.imageList.first.imageUrl.toString(),unitName: unit.unitName,unitPrice: unit.unitPrice,unitId: unit.unitId,quantity: quantity,note: notes));
          CustomPopup(context, title: 'Cart', message: 'Item added in cart', primaryBtnTxt: 'OK');
        }else{
          bool exist = cartItem.cart.any((element) {
            return element.productid == res.productid ?? 0;
          });

          print('exist: $exist');

          if(!exist){

            final cartItem = Cart(productid: res.productid,categoryid: res.categoryid,subcategoryid: res.subcategoryid,productName: res.productName,description: res.description,imageUrl: res.imageList.first.imageUrl.toString(),unitName: unit.unitName,unitPrice: unit.unitPrice,unitId: unit.unitId,quantity: quantity,note: notes,unitmaster: res.unitmaster,selectedIndex: index);

            CartService.addItemObj(cartItem);

            // CartService.addItemObj(Cart(productid: res.productid,categoryid: res.categoryid,subcategoryid: res.subcategoryid,productName: res.productName,description: res.description,imageUrl: res.imageList.first.imageUrl.toString(),unitName: unit.unitName,unitPrice: unit.unitPrice,unitId: unit.unitId,quantity: quantity,note: notes));
            CustomPopup(context, title: 'Cart', message: 'Item added in cart', primaryBtnTxt: 'OK');
          }else{
            CustomPopup(context, title: 'Cart', message: 'Already in the cart', primaryBtnTxt: 'OK');
          }
        }


      },
    );
    updateCount();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    bool exist = cartItem == null ? false : cartItem.cart.any((element) {
      return element.productid == widget.itemDetail.productid ?? 0;
    });

    return Scaffold(
      appBar: AppBar(
          title: Text('Item'),
          actions: [
            CartForAll(totalCart: totalCartItem,callBack: (){
              updateCount();
            },)
          ]),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: size.width/2,
                  child: imagesWidget(),
                ),
                SizedBox(height: 15),
                Container(
                  margin: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.itemDetail.productName ?? "productName",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        widget.itemDetail.categoryName ?? "Category",
                        style: TextStyle(
                            fontSize: 20, color: ColorUtil.primoryColor),
                      ),
                      SizedBox(height: 10),
                      Text(
                        widget.itemDetail.description ?? "description",
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          if(widget.itemDetail.isProductAvailbleinStock ?? false)
            Container(
            height: 50,
            width: double.infinity,
            color: ColorUtil.buttonColor,
            child: InkWell(
              onTap: () {

                if(exist){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen())).then((value) {
                    updateCount();
                  });
                  return;
                }

                //Open add to cart popup here
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (BuildContext context) => _myDialog,
                      fullscreenDialog: true,
                    )).then((value) {
                  updateCount();
                });
              },
              child: Center(
                  child: Text(
                    exist ? "Go To Cart" : "Add to cart",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )),
            ),
          ),
          if(!(widget.itemDetail.isProductAvailbleinStock ?? false))
            Container(child: Center(
              child: Text('Not Available',style: TextStyle(
                  color: Colors.red
              ),),
            )),

          // Container(
          //   child: Center(
          //     child: Text('Delete'),
          //   ),
          // )

        ],
      )),
    );
  }
}
