
import 'dart:io';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:inventory_system/Screens/PaymentScreen.dart';
import 'package:inventory_system/Utilities/ColorUtil.dart';
import 'package:inventory_system/component/CustomPopup.dart';
import 'package:inventory_system/component/LoadingSmall.dart';
import 'package:inventory_system/component/NoDataFoundContainer.dart';
import 'package:inventory_system/data/models/InvoiceModel.dart';
import 'package:inventory_system/data/models/res/ResGetInvoiceList.dart';
import 'package:inventory_system/services/webService.dart';

class InvoiceDetailsScreen extends StatefulWidget {

  InvoiceDetailsScreen({this.orderId});

  final int orderId;

  @override
  _InvoiceDetailsScreenState createState() => _InvoiceDetailsScreenState();
}

class _InvoiceDetailsScreenState extends State<InvoiceDetailsScreen> {

  ResGetInvoiceList resData;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    InvoiceModel.getInvoiceDetail(orderId: widget.orderId, completion: (res){
      switch (res.state) {
        case Status.LOADING:
          setState(() {
            isLoading = true;
          });
          break;
        case Status.COMPLETED:
          setState(() {
            isLoading = false;
            if(res.data.data.list.length > 0){
              resData = res.data.data.list.first;
            }else{
              throw 'No Data Found';
            }
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

  getAllApp() async {
    final apps =  gePaymentApps();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.bgColor,
      appBar: AppBar(
        title: Text('Invoice Details'),
      ),
      body: buildSingleChildScrollView(),
    );
  }

  Widget buildSingleChildScrollView() {

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

    if (resData == null) {
      return NoDataFoundContainer();
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 15),
          Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  resData.partyname,
            style: TextStyle(
                  color: ColorUtil.primoryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
                  textAlign: TextAlign.center,
          ),
              )),
          Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Bill No. ${resData.billnumber}',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              )),
          Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '${resData.orderdate} - Due ${resData.duedate}',
                  style: TextStyle(
                      fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              )),
          SizedBox(height: 30),
          Container(
            margin: EdgeInsets.all(15),
            width: double.infinity,
            color: ColorUtil.primoryColor.withOpacity(0.3),
            padding: EdgeInsets.symmetric(vertical: 1),
            child: Column(
              children: [
                totalRow(title: "Total",price: "${resData.totalpayableinstr}",isLast: false),
                SizedBox(height: 1),
                totalRow(title: "Total Paid",price: "${resData.paidamountinstr}",isLast: false),
                SizedBox(height: 1),
                totalRow(title: "Total Due",price: "${resData.unpaidamountinstr}",isLast: true),
              ],
            ),
          ),
          buildContainer()
        ],
      ),
    );
  }

  Future<List<Application>> gePaymentApps() async {
    Application gPayApp = await DeviceApps.getApp('com.google.android.apps.walletnfcrel');
    Application paytmApp = await DeviceApps.getApp('net.one97.paytm');
    Application phonePayApp = await DeviceApps.getApp('com.phonepe.app');

    List<Application> apps;
    apps.add(gPayApp);
    apps.add(paytmApp);
    apps.add(phonePayApp);

    return apps;
  }

  Container buildContainer() {

    if (Platform.isAndroid){
      if (!resData.isamountpaid){
        return Container(
          height: 44,
          color: ColorUtil.primoryColor,
          child: TextButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen(),));
            },
            child: Text('Pay',
              style: TextStyle(
                  color: Colors.white
              ),
            ),
          ),
        );
      }
    }


    return Container(
          padding: EdgeInsets.all(20),
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 2.5,horizontal: 10),
              decoration: BoxDecoration(
                  color: resData.isamountpaid ? Colors.green[300] : Colors.red[300],
                  borderRadius: BorderRadius.circular(5)
              ),
              child: Text(resData.isamountpaid ? "Paid" : "Not Paid",style: TextStyle(
                  color: Colors.white,
                fontSize: 20
              ),),
            ),
          ),
        );
  }

  Widget totalRow({String title,String price,bool isLast}) {
    return Container(
      color: ColorUtil.bgColor,
      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex:5,
                        child: Container(
                          color: ColorUtil.bgColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(title, style: TextStyle(
                              fontSize: isLast ? 18 : 15,
                              fontWeight: isLast ? FontWeight.bold : FontWeight.normal
                            ),),
                          ),
                        ),
                      ),
                      Container(width: 1,color: ColorUtil.primoryColor.withOpacity(0.3),height: 40,),
                      Expanded(
                        flex:4,
                        child: Container(
                          color: ColorUtil.bgColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(price,textAlign: TextAlign.end,style: TextStyle(
                                fontSize: isLast ? 18 : 15,
                                fontWeight: isLast ? FontWeight.bold : FontWeight.normal
                            )),
                          ),
                        ),
                      )
                    ],
                  ),
    );
  }
}
