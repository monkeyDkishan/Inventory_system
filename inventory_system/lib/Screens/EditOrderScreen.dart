import 'package:flutter/material.dart';
import 'package:inventory_system/Screens/AddItemToCartPopup.dart';
import 'package:inventory_system/Utilities/ColorUtil.dart';
import 'package:inventory_system/component/CustomPopup.dart';
import 'package:inventory_system/component/LoadingSmall.dart';
import 'package:inventory_system/data/models/CartModel.dart';
import 'package:inventory_system/data/models/OrderModel.dart';
import 'package:inventory_system/data/models/req/ReqUpdateOrderDetails.dart';
import 'package:inventory_system/data/models/res/ResGetBillDetails.dart';
import 'package:inventory_system/data/models/res/ResGetDeliveryType.dart';
import 'package:inventory_system/data/models/res/ResGetItemList.dart';
import 'package:inventory_system/services/userPreferencesService.dart';
import 'package:inventory_system/services/webService.dart';

class EditOrderScreen extends StatefulWidget {

  final GetBillDetailsList res;

  const EditOrderScreen({this.res});

  @override
  _EditOrderScreenState createState() => _EditOrderScreenState();
}

class _EditOrderScreenState extends State<EditOrderScreen> {

  // double subTotal = 0.0;
  //
  // double finalTotal = 0.0;
  //
  // double deliveryCharge = 0.0;
  //
  // double tcsCharge = 0.0;

  bool isLoading = false;

  List<ResGetDeliveryTypeListElement> deliveryTypes;

  ResGetDeliveryTypeListElement dropdownValue;

  ReqUpdateOrderDetails req;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // subTotal = widget.res.totalpayable - widget.res.deliveryCharges - widget.res.tcsAmount;
    // finalTotal = widget.res.totalpayable;
    // deliveryCharge = widget.res.deliveryCharges;
    // tcsCharge = widget.res.tcsAmount;

    req = ReqUpdateOrderDetails();

    setState(() {
      req.orderid = widget.res.orderid ?? 0;
      req.subTotal = (widget.res.totalpayable ?? 0.0) - (widget.res.deliveryCharges ?? 0.0) - (widget.res.tcsAmount ?? 0.0);
      req.deliveryCharge = widget.res.deliveryCharges ?? 0.0;
      req.finalTotal = widget.res.totalpayable ?? 0.0;
      req.tcsamount = widget.res.tcsAmount ?? 0.0;
      req.tcsamountpercentage = widget.res.tcsAmountPercentage ?? 0.0;
      req.partyid = widget.res.partyid ?? 0;

      req.cartItems = [];

      widget.res.orderitems.forEach((order) {

        req.cartItems.add(CartItem(
          categoryid: order.categoryid ?? 0,
          subcategoryid: order.subcategoryid ?? 0,
          productid: order.productid ?? 0,
          orderitemid: order.orderitemid ?? 0,
          note: order.note ?? "",
          quantity: order.noofunit.toInt(),
          unitPrise: order.unitprice ?? 0.0,
          itempayable: order.itempayable ?? 0.0,
          selectedUnitId: order.unitid ?? 0
        ));

      });
    });

    calculateTotal();
    getDeliveryType();

  }

  getDeliveryType() async {
    CartModel.getDeliveryType(completion: (res){
      switch (res.state) {
        case Status.LOADING:
          setState(() {
            isLoading = true;
          });
          break;
        case Status.COMPLETED:
          setState((){
            isLoading = false;
            deliveryTypes = res.data.data.list;

            if (widget.res.deliveryCharges > 0.0){
              if(deliveryTypes.length >= 2){
                dropdownValue = deliveryTypes[1];

              }else{
                dropdownValue = deliveryTypes[0];
              }
            }else{
              dropdownValue = deliveryTypes[0];
            }
            req.selectedDeliveryType = dropdownValue.deliveryid ?? 0;
            req.deliveryCharge = dropdownValue.price ?? 0.0;
            getTCSCharge();
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

  calculateTotal() async {

    double priceTotal = 0.0;

    req.cartItems.forEach((element) {
      priceTotal += ((element.quantity ?? 0.0) * (element.unitPrise ?? 0.0));
    });

    setState(() {
      req.subTotal = priceTotal ?? 0.0;
      req.finalTotal = priceTotal ?? 0.0;
    });

  }

  Future getTCSCharge() async {
    calculateTotal();

    final user = await UserPreferencesService().getUser();

    if(user.isTCSApply ?? false){
      req.tcsamount = ((req.subTotal.toDouble() + req.deliveryCharge.toDouble()) * (user.tcsAmountPercentage.toDouble() ?? 0.0))/100.toDouble();
      print('cool1');
    }else{
      final tcs = ((req.subTotal.toDouble() + req.deliveryCharge.toDouble()) + (user.tcsAmount.toDouble() ?? 0.0)) - (user.tcsLimit.toDouble() ?? 0.0);
      if(tcs > 0){
        req.tcsamount = (tcs.toDouble() * (user.tcsAmountPercentage.toDouble() ?? 0.0))/100;
        print('cool2');
      }else{
        req.tcsamount = 0.0;
        print('cool3');
      }
    }
    req.finalTotal = req.subTotal.toDouble() + req.deliveryCharge.toDouble() + req.tcsamount.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Order'),
        actions: [
          IconButton(onPressed: (){

            OrderModel.updateOrderDetails(req: req,completion: (apiRes){

              switch(apiRes.state){
                case Status.LOADING:
                  setState(() {
                    isLoading = true;
                  });
                  break;
                case Status.COMPLETED:
                  setState(() {
                    isLoading = false;
                  });
                  Navigator.of(context).pop(true);
                  Navigator.of(context).pop(true);
                  break;
                case Status.ERROR:
                  setState(() {
                    isLoading = false;
                  });
                  CustomPopup(context, title: 'Sorry', message: apiRes.msg ?? "sorry", primaryBtnTxt: 'ok');
                  break;
              }
            });

          }, icon: Icon(Icons.done))
        ],
      ),
      body: buildContainer(),
    );
  }

  Widget bottomView(){
    return Container(
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
              if(dropdownValue != null)
                Container(
                  height: 44,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white)),
                  child: DropdownButton<ResGetDeliveryTypeListElement>(
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
                    onChanged: (ResGetDeliveryTypeListElement newValue) {
                      setState((){
                        dropdownValue = newValue;
                        req.deliveryCharge = dropdownValue.price ?? 0.0;
                        getTCSCharge();
                      });
                    },
                    items: deliveryTypes
                        .map<DropdownMenuItem<ResGetDeliveryTypeListElement>>((ResGetDeliveryTypeListElement value) {
                      return DropdownMenuItem<ResGetDeliveryTypeListElement>(
                        value: value,
                        child: Text(
                          value.deliveryType ?? "",
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
                    SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        "${(req.subTotal ?? 0.0).toStringAsFixed(2)}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
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
                      "Delivery Charge",
                      style:
                      TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        '${(dropdownValue.price ?? 0.0).toStringAsFixed(2)}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
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
                      "TCS Charge",
                      style:
                      TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        '${req.tcsamount.toStringAsFixed(2)}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 50,
                color: Colors.black12,
                child: Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Final Total",
                          style:
                          TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "${(req.finalTotal ?? 0.0).toStringAsFixed(2)}",
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textAlign: TextAlign.end,
                            style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContainer() {

    if(isLoading){
      return LoadingSmall(color: ColorUtil.primoryColor,);
    }

    return Column(
      children: [
        Expanded(child: buildListView()),
        bottomView()
      ],
    );
  }

  Widget buildListView() {
    return ListView.builder(
    itemCount: req.cartItems.length, //widget.res.orderitems.length,
    itemBuilder: (context, index) {

      final reqData = req.cartItems[index];

      final resData = widget.res.orderitems[index];

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text('${resData.productname}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        ),
                      ),
                    ),
                    IconButton(onPressed: (){

                      List<UnitItem> units = [];

                      resData.unitmaster.forEach((element) {

                        units.add(UnitItem(unitId: element.unitmasterid ?? 0,unitPrice: element.unitPrize,unitName: element.unitname ?? ""));

                      });

                      GetBillDetailsUnitmaster item = resData.unitmaster.singleWhere((element) => element.unitmasterid == reqData.selectedUnitId);

                      final selected_index = resData.unitmaster.indexOf(item);
                      
                      if(item != null && selected_index != null){
                        Navigator.push(context, new MaterialPageRoute(
                          builder: (BuildContext context) => FullScreenDialog(
                            productID: reqData.productid ?? 0,
                            index: selected_index,
                            dropdownValue: UnitItem(unitId: units.first.unitId ?? 0,unitPrice: units.first.unitPrice,unitName: units.first.unitName ?? ""),
                            quantity: reqData.quantity,
                            notes: reqData.note,
                            units: units,
                            completion: (unit, quantity, notes, id){

                              // CartService.editItemObj(index,Cart(productid: res.productid,categoryid: res.categoryid,subcategoryid: res.subcategoryid,productName: res.productName,description: res.description,imageUrl: res.imageUrl,unitName: unit.unitName,unitPrice: unit.unitPrice ?? 0.0,unitId: unit.unitId,quantity: quantity,note: notes,unitmaster: res.unitmaster,selectedIndex: id));

                              req.cartItems[index].note = notes;
                              req.cartItems[index].quantity = quantity;
                              req.cartItems[index].selectedUnitId = unit.unitId;
                              req.cartItems[index].unitPrise = unit.unitPrice;
                              req.cartItems[index].itempayable = unit.unitPrice * quantity;
                              req.cartItems[index].selectedUnitId = unit.unitId;

                              getTCSCharge();
                            },
                          ),
                          fullscreenDialog: true,
                        ));  
                      }

                    }, icon: Icon(Icons.edit))
                  ],
                ),
                Text('Note: ${reqData.note}'),
                Text('Category: ${resData.categoryName}'),
                Text('Unit: ${resData.unitmaster.where((element) => element.unitmasterid == resData.unitid).first.unitname ?? ''}'),
                Text('Qty: ${resData.noofunit}'),
                SizedBox(height: 10),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text('RS. ${reqData.itempayable}',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),
                    ))
              ],
            ),
          ),
        ),
      );
    },);
  }
}
