import 'package:flutter/material.dart';
import 'package:inventory_system/Utilities/ColorUtil.dart';
import 'package:inventory_system/component/CustomPopup.dart';
import 'package:inventory_system/component/LoadingSmall.dart';
import 'package:inventory_system/component/NoDataFoundContainer.dart';
import 'package:inventory_system/data/models/OrderModel.dart';
import 'package:inventory_system/data/models/res/ResGetOrderDetails.dart';
import 'package:inventory_system/services/webService.dart';

class OrderListScreen extends StatefulWidget {
  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  
  bool isLoading = true;

  var orders = ResGetOrderDetails();

  getData() async {
    await OrderModel.getAllOrder(completion: (res){
      switch(res.state){
        case Status.LOADING:
          setState(() {
            isLoading = true;
          });
          break;
        case Status.COMPLETED:
          setState(() {
            isLoading = false;
            orders = res.data;
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
            getData();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Orders'),),
      body: buildContainer(),
    );
  }

  Widget buildContainer() {

    if (isLoading){
      return LoadingSmall(color: ColorUtil.primoryColor,);
    }

    if (orders == null || orders.data == null || orders.data.list == null || orders.data.list.length == 0){
      return NoDataFoundContainer();
    }

    return ListView.builder(
      itemCount: orders.data.list.length,
      itemBuilder: (context, index) {
        final data = orders.data.list[index];
        return InkWell(
          onTap: (){
            
          },
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child:
                      Row(
                        children: [
                          Text('Payment: '),
                          Text('${data.isamountpaid ? "Paid" : "Pending"}',
                            maxLines: 1,
                            style: TextStyle(
                                color: data.isamountpaid ? Colors.green : Colors.redAccent,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      )),
                      Text('Total Items: ${data.orderitems.length}'),
                    ],
                  ),
                  Text('Bill no. ${data.billreferencenumber}'),
                  Text('Due Date: ${data.duedate.day}/${data.duedate.month}/${data.duedate.year}'),
                ],
              ),
            ),
          ),
        );
    },);
  }
}
