import 'dart:io';

import 'package:flutter/material.dart';
import 'package:inventory_system/Screens/EditOrderScreen.dart';
import 'package:inventory_system/Screens/PaymentScreen.dart';
import 'package:inventory_system/Utilities/ColorUtil.dart';
import 'package:inventory_system/component/CustomPopup.dart';
import 'package:inventory_system/component/LoadingSmall.dart';
import 'package:inventory_system/component/NoDataFoundContainer.dart';
import 'package:inventory_system/data/models/OrderModel.dart';
import 'package:inventory_system/data/models/res/ResGetBillDetails.dart';
import 'package:inventory_system/services/webService.dart';

class StatementScreen extends StatefulWidget {

  StatementScreen({this.statementName,this.index,this.res,this.isFromstatement});

  final String statementName;
  final int index;

  final bool isFromstatement;

  final GetBillDetailsList res;

  @override
  _StatementScreenState createState() => _StatementScreenState();
}

class _StatementScreenState extends State<StatementScreen> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Order'),
        actions: [

          if(!widget.res.isamountpaid && !widget.isFromstatement)
            IconButton(onPressed: (){
              CustomPopup(context, title: 'Are you sure', message: 'You want to delete this order?', primaryBtnTxt: 'YES',primaryAction: (){
                deleteOrder(widget.res.orderid ?? 0);
              },secondaryBtnTxt: 'NO');
            }, icon: Icon(Icons.delete)),
          if(!widget.res.isamountpaid && !widget.isFromstatement)
            IconButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditOrderScreen(res: widget.res,),));
            }, icon: Icon(Icons.edit))
        ],
      ),
      body: buildContainer()
    );
  }

  deleteOrder(int id) async {
    await OrderModel.deleteOrder(id: id,completion: (res){
      switch(res.state){
        case Status.LOADING:
          setState(() {
            isLoading = true;
          });
          break;
        case Status.COMPLETED:
          setState(() {
            isLoading = false;
            Navigator.pop(context,true);
          });
          break;
        case Status.ERROR:
          setState(() {
            isLoading = false;
          });
          CustomPopup(context, title: 'Sorry', message: res.msg, primaryBtnTxt: 'ok');
          break;
      }
    });
  }

  Widget buildContainer() {

    if (isLoading) {
      return LoadingSmall(color: ColorUtil.primoryColor,);
    }

    if(widget.res == null){
      return NoDataFoundContainer();
    }

    final data = widget.res;

    return Container(
      child: Column(
        children: [
          Expanded(child: Container(
            child: buildListView(),
          )),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: ColorUtil.primoryColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
            ),
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Order Is: ',style: TextStyle(color: Colors.white),),
                    Text('${data.isOrderPlaced ? 'Placed' : 'Pending'}',style: TextStyle(
                        fontSize: 16,
                        color: data.isOrderPlaced ? Colors.green : Colors.redAccent
                    ),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Payment Is: ',style: TextStyle(color: Colors.white),),
                    Text('${data.isamountpaid ? 'Paid' : 'Pending'}',style: TextStyle(
                        fontSize: 16,
                      color: data.isamountpaid ? Colors.green : Colors.redAccent
                    ),),
                  ],
                ),

                SizedBox(height: 5),
                Container(height: 1,color: Colors.white.withOpacity(0.4),),
                SizedBox(height: 5),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Delivery Charge: ',style: TextStyle(color: Colors.white),),
                    Text('${data.deliveryCharges}',style: TextStyle(
                      fontSize: 16,
                      color: Colors.white
                    ),),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('TCS Charge: ',style: TextStyle(color: Colors.white),),
                    Text('${data.tcsAmount}',style: TextStyle(
                      fontSize: 16,
                      color: Colors.white
                    ),),
                  ],
                ),

                SizedBox(height: 5),
                Container(height: 1,color: Colors.white.withOpacity(0.4),),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total: ',style: TextStyle(color: Colors.white),),
                    Text('Rs. ${data.totalpayable.toStringAsFixed(2)}',style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),),
                  ],
                ),

                if(!widget.res.isamountpaid && Platform.isAndroid && !widget.isFromstatement)
                  Container(
                    alignment: Alignment.centerRight,
                    height: 44,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen(),));
                      },
                      child: Text('PAY',style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),),
                    ),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildListView() {
    if (widget.res.orderitems.length == 0){
      return NoDataFoundContainer(errText: 'No Times Found',);
    }
    return ListView.builder(
            itemCount: widget.res.orderitems.length,
            itemBuilder: (context, index) {

              final data = widget.res.orderitems[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${data.productname}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                          ),
                        ),
                        Text('Note: ${data.note}'),
                        Text('Category: ${data.categoryName}'),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                            child: Text('RS. ${data.itempayable}',
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
