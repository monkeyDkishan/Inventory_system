import 'package:flutter/material.dart';
import 'package:inventory_system/Screens/CategoryScreen.dart';
import 'package:inventory_system/Screens/InvoiceListScreen.dart';
import 'package:inventory_system/Screens/SideMenuDrawer.dart';
import 'package:inventory_system/Utilities/ColorUtil.dart';
import 'package:inventory_system/component/CartButton.dart';
import 'package:inventory_system/component/LoadingSmall.dart';
import 'package:inventory_system/component/NoDataFoundContainer.dart';
import 'package:inventory_system/data/models/UserModel.dart';
import 'package:inventory_system/data/models/res/ResGetProfileDetails.dart';
import 'package:inventory_system/services/webService.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  bool isLoading = false;

  ResGetProfileDetails res;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    UserModel.getProfileDetails(completion: (res) async {
      switch (res.state) {
        case Status.LOADING:
          // TODO: Handle this case.
          setState(() {
            isLoading = true;
          });
          break;
        case Status.COMPLETED:
          // TODO: Handle this case.
          setState(() {
            isLoading = false;
            this.res = res.data;
          });
          break;
        case Status.ERROR:
          // TODO: Handle this case.
          setState(() {
            isLoading = false;
          });
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: _body(),
    );
  }

  Widget _body() {

    if (isLoading){
      return LoadingSmall(color: ColorUtil.primoryColor,);
    }

    if (res == null){
      return NoDataFoundContainer();
    }

    try{
      final data = res.data.list.first;

      return Container(
        padding: EdgeInsets.all(15),
        child: ListView(

          children: [
            Center(
              child: Text(data.partyname ?? '',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),),
            ),
            Center(
              child: Text(data.partytypename ?? '',style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 16
              ),),
            ),

            SizedBox(height: 15),
            Container(
              height: 1,
              color: ColorUtil.primoryColor.withOpacity(0.5),
            ),
            SizedBox(height: 20),

            Text('User Detail',style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16
            ),),
            SizedBox(height: 15),
            Center(
              child: Row(
                children: [
                  Icon(Icons.location_pin),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text('${data.street}, ${data.city}, ${data.statename}, ${data.zipcode}',style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: Row(
                children: [
                  Icon(Icons.phone),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text('${data.phone}',style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: Row(
                children: [
                  Icon(Icons.email),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text('${data.email}',style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: Row(
                children: [

                  Expanded(
                    child: Text('GST No. ${data.gstno ?? "-"}',style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),),
                  ),
                ],
              ),
            ),

            SizedBox(height: 15),
            Container(
              height: 1,
              color: ColorUtil.primoryColor.withOpacity(0.5),
            ),
            SizedBox(height: 15),

            Text('TCS Details',style: TextStyle(
              fontWeight: FontWeight.bold,
                fontSize: 16
            ),),

            SizedBox(height: 15),

            Center(
              child: Row(
                children: [

                  Expanded(
                    child: Text('TcsAmountPercentage: ${data.tcsAmountPercentage ?? "-"} %',style: TextStyle(
                      // fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),),
                  ),
                ],
              ),
            ),

            SizedBox(height: 15),

            Center(
              child: Row(
                children: [

                  Expanded(
                    child: Text('TcsLimit: ${data.tcsLimit ?? "-"}',style: TextStyle(
                      // fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),),
                  ),
                ],
              ),
            ),

            SizedBox(height: 15),

            Center(
              child: Row(
                children: [

                  Expanded(
                    child: Text('TcsAmount: ${data.tcsAmount ?? "-"}',style: TextStyle(
                      // fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),),
                  ),
                ],
              ),
            ),

            SizedBox(height: 15),

            Center(
              child: Row(
                children: [

                  Expanded(
                    child: Text('${data.isTcsApply ? 'TCS is Applied' : 'TCS is not Applied'}',style: TextStyle(
                      // fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),),
                  ),
                ],
              ),
            ),

          ],
        ),
      );

    }catch(e){
      return NoDataFoundContainer();
    }

  }
}
