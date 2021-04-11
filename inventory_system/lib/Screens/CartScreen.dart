import 'package:flutter/material.dart';
import 'package:inventory_system/Screens/AddItemToCartPopup.dart';
import 'package:inventory_system/Utilities/ColorUtil.dart';
import 'package:inventory_system/Utilities/ImageUtil.dart';
import 'package:inventory_system/Utilities/constants.dart';
import 'package:inventory_system/component/CustomPopup.dart';
import 'package:inventory_system/component/NoDataFoundContainer.dart';
import 'package:inventory_system/services/CartService.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String dropdownValue;

  CartList cart;

  double total = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCart();

  }

  getCart() async {
    var res = await CartService.getCarts();
    double priceTotal = 0.0;

    // res.cart.forEach((e) {
    //   print('price : ${e.quantity * e.unitPrice}');
    //   priceTotal += (e.quantity * e.unitPrice);
    // });

    print(priceTotal);
    setState(() {
      total = priceTotal;
      cart = res;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: buildContainer(),
    );
  }

  Widget buildContainer() {

    if(cart == null || cart.cart.length <= 0){
      return NoDataFoundContainer();
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Container(
            child: ListView.builder(
              itemCount: cart.cart.length,
              itemBuilder: (BuildContext context, int index) {

                final res = cart.cart[index];

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Card(
                    color: Colors.grey[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 2,
                    child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Container(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                    child: ImageUtil.fadeInImage(kImgUrl + (res.imageUrl.toString() ?? ""), 'Assets/Images/placeholder.png'),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(20)),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    res.productName ?? "Product name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    "Quantity : ${res.quantity}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                        fontSize: 13),
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    res.note ?? "notes",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                        fontSize: 13),
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                     'Rs. ${res.unitPrice} for 1 ${res.unitName} ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                        fontSize: 13),
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(),
                                      ),
                                      TextButton(
                                          onPressed: (){

                                            CustomPopup(context, title: 'Remove', message: "Are you sure you want to remove this item?", primaryBtnTxt: 'YES',secondaryBtnTxt: 'No',primaryAction: (){
                                              CartService.removeItem(index);
                                              getCart();
                                            });
                                          },
                                          child: Text("REMOVE",style: TextStyle(color: Colors.red),)),
                                      Container(
                                        child: TextButton(
                                          onPressed: (){
                                            CartService.editItem(index,'{     "productid": 10,     "ProductName": "productName",     "Categoryid": 0,     "Subcategoryid": 0,     "description": "description",     "ImageURL": ""   }');
                                            getCart();
                                            Navigator.push(context, new MaterialPageRoute(
                                              builder: (BuildContext context) => FullScreenDialog(
                                                dropdownValue: UnitItem(unitId: res.unitId,unitName: res.unitName,unitPrice: res.unitPrice),
                                                quantity: res.quantity,
                                                notes: res.note,
                                                units: [UnitItem(unitId: res.unitId,unitName: res.unitName,unitPrice: res.unitPrice)],
                                                completion: (unit, quantity, notes) async {

                                                  CartService.editItemObj(index,Cart(productid: res.productid,categoryid: res.categoryid,subcategoryid: res.subcategoryid,productName: res.productName,description: res.description,imageUrl: res.imageUrl,unitName: unit.unitName,unitPrice: unit.unitPrice,unitId: unit.unitId,quantity: quantity,note: notes));

                                                  getCart();

                                                },
                                              ),
                                              fullscreenDialog: true,
                                            ));
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: ColorUtil
                                                        .buttonColor)),
                                            child: Text(
                                              "EDIT",
                                              style: TextStyle(
                                                  color:
                                                      ColorUtil.buttonColor),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
                );
              },
            ),
          )),
          Container(
            decoration: BoxDecoration(
                color: ColorUtil.primoryColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            child: SafeArea(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 44,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white)),
                      child: DropdownButton<String>(
                        hint: Text('Select Type',style: TextStyle(
                          color: Colors.white
                        ),),
                        isExpanded: true,
                        value: dropdownValue,
                        dropdownColor: ColorUtil.primoryColor,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                        iconSize: 24,
                        elevation: 16,
                        underline: Container(),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: ["Type1", "Type2"]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total",
                            style:
                                TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          Text(
                            "$total",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Discount",
                            style:
                            TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          Text(
                            "-0.00",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      color: Colors.black12,
                      child: InkWell(
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "PLACE ORDER",
                                  style:
                                  TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "$total",
                                  style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
