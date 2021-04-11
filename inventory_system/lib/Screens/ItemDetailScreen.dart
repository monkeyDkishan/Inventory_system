import 'package:flutter/material.dart';
import 'package:inventory_system/Screens/AddItemToCartPopup.dart';
import 'package:inventory_system/Utilities/ColorUtil.dart';
import 'package:inventory_system/Utilities/ImageUtil.dart';
import 'package:inventory_system/component/CartButton.dart';
import 'package:inventory_system/services/CartService.dart';

class ItemDetailScreen extends StatefulWidget {
  ItemDetailScreen({this.index, this.itemName});

  final int index;
  final String itemName;

  List<String> imageUrls = ['https://ae04.alicdn.com/kf/H5974b75654944e03bc7b7b6c7e3cf536Q.jpg','https://cdn.joelandsonfabrics.com/media/catalog/product/cache/ad8edc7db7d60c6f18acda2e15b81da5/1/9/19677c.jpg','https://static.fibre2fashion.com/MemberResources/LeadResources/8/2019/8/Buyer/19166986/Images/19166986_0_suiting-fabric.jpg'];

  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  FullScreenDialog _myDialog = new FullScreenDialog(
    units: ["1", "2", "3", "4"],
  );

  static show({BuildContext context, WidgetBuilder builder}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: builder,
    );
  }

  Widget imagesWidget(){
    return PageView.builder(
      itemCount: widget.imageUrls.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(15),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              child: ImageUtil.fadeInImage(widget.imageUrls[index], 'Assets/Images/placeholder.png'),
            ),
          ),
        );
        },
    );
  }

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
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          title: Text(widget.itemName),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Item Name",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.green[300],
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                "Type",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white),
                              )),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Category",
                        style: TextStyle(
                            fontSize: 20, color: ColorUtil.primoryColor),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "This item is contining the details for the item thai i have added and it is the item you can add inside your cart This item is contining the details for the item thai i have added and it is the item you can add inside your cart This item is contining the details for the item thai i have added and it is the item you can add inside your cart",
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 50,
            width: double.infinity,
            color: ColorUtil.buttonColor,
            child: InkWell(
              onTap: () {
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
                "Add to cart",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )),
            ),
          )
        ],
      )),
    );
  }
}
