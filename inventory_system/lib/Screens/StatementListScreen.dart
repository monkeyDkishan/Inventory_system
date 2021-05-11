import 'package:flutter/material.dart';
import 'package:inventory_system/Screens/StatementScreen.dart';
import 'package:inventory_system/Utilities/ColorUtil.dart';
import 'package:inventory_system/component/CustomPopup.dart';
import 'package:inventory_system/component/LoadingSmall.dart';
import 'package:inventory_system/component/NoDataFoundContainer.dart';
import 'package:inventory_system/data/models/OrderModel.dart';
import 'package:inventory_system/data/models/res/ResGetBillDetails.dart';
import 'package:inventory_system/services/webService.dart';

class StatementListScreen extends StatefulWidget {
  
  final String fromDate;
  final String toDate;

  const StatementListScreen({this.fromDate, this.toDate});
  
  @override
  _StatementListScreenState createState() => _StatementListScreenState();
}

class _StatementListScreenState extends State<StatementListScreen> {

  GetBillDetailsData billData;

  bool isLoading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    OrderModel.getOrder(toDate: widget.toDate,fromDate: widget.fromDate,completion: (res){
      switch (res.state) {
        case Status.LOADING:
          setState(() {
            isLoading = true;
          });
          break;
        case Status.COMPLETED:
          setState(() {
            isLoading = false;
            billData = res.data.data;
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
      appBar: AppBar(
          title: Text("Statements"),
      ),
      body: Container(
        child: SafeArea(
          child: buildListView(),
        ),
      ),
    );
  }

  Widget buildListView() {

    if(isLoading){
      return LoadingSmall(color: ColorUtil.primoryColor);
    }

    if(billData == null || billData.list.length == 0){
      return NoDataFoundContainer();
    }

    return ListView.builder(
          itemCount: billData.list.length,
          itemBuilder: (BuildContext context, int index){
            final data = billData.list[index];
            return Container(
              margin: EdgeInsets.all(5),
              child: GestureDetector(
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
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => StatementScreen(index: index,statementName: "Statement $index",res: data,)));
                },
              ),
            );
          },
        );
  }
}
