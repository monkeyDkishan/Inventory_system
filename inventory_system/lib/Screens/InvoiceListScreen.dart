import 'package:flutter/material.dart';
import 'package:inventory_system/Screens/InvoiceDetailsScreen.dart';
import 'package:inventory_system/Utilities/ColorUtil.dart';
import 'package:inventory_system/component/CustomPopup.dart';
import 'package:inventory_system/component/LoadingSmall.dart';
import 'package:inventory_system/component/NoDataFoundContainer.dart';
import 'package:inventory_system/data/models/InvoiceModel.dart';
import 'package:inventory_system/data/models/res/ResGetInvoiceList.dart';
import 'package:inventory_system/services/webService.dart';

class InvoiceListScreen extends StatefulWidget {
  @override
  _InvoiceListScreenState createState() => _InvoiceListScreenState();
}

class _InvoiceListScreenState extends State<InvoiceListScreen> {

  List<ResGetInvoiceList> resList;
  bool isLoading = false;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    InvoiceModel.getInvoice(completion: (res){
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
      appBar: AppBar(
          title: Text("Invoice List"),
      ),
      body: buildContainer(),
    );
  }

  Widget buildContainer() {
    final size = MediaQuery.of(context).size;
    if (isLoading) {
      return Container(
        child: Center(
          child: Container(
            width: 22,
            height: 22,
            child: LoadingSmall(
              color: ColorUtil.primoryColor,
            ),
          ),
        ),
      );
    }

    if (resList == null || resList.length <= 0) {
      return NoDataFoundContainer();
    }

    return Container(
      child: SafeArea(
        child: ListView.builder(
          itemCount: resList.length,
          itemBuilder: (BuildContext context, int index){
            final data = resList[index];
            return FittedBox(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: GestureDetector(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: size.width*0.6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data.partyname,style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                ),
                                  softWrap: true,
                                ),
                                SizedBox(height: 10,),
                                Text( 'Bill Number : ' + data.billnumber.toString()),
                              ],
                            ),
                          ),
                          // Icon(Icons.arrow_forward_ios)
                          Container(
                            width: size.width*0.3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(data.totalpayableinstr),
                                SizedBox(height: 10,),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 2.5,horizontal: 5),
                                  decoration: BoxDecoration(
                                    color: data.isamountpaid ? Colors.green[300] : Colors.red[300],
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Text(data.isamountpaid ? "Paid" : "Not Paid",style: TextStyle(
                                    color: Colors.white
                                  ),),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => InvoiceDetailsScreen(orderId: data.orderid,),));
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
