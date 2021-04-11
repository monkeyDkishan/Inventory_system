import 'package:flutter/material.dart';
import 'package:inventory_system/Utilities/ColorUtil.dart';
import 'package:inventory_system/component/CustomPopup.dart';
import 'package:inventory_system/component/LoadingSmall.dart';
import 'package:inventory_system/component/NoDataFoundContainer.dart';
import 'package:inventory_system/data/models/ServiceModel.dart';
import 'package:inventory_system/data/models/res/ResCMS.dart';
import 'package:inventory_system/services/webService.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class CMSPagesScreen extends StatefulWidget {

  CMSPagesScreen(this.cmsType);

  final CMSType cmsType;

  @override
  _CMSPagesScreenState createState() => _CMSPagesScreenState();
}

class _CMSPagesScreenState extends State<CMSPagesScreen> {

  getPageTitle(){
    switch (widget.cmsType){
      case CMSType.Privacy:
        return "Privacy Policies";
        break;
      case CMSType.Terms:
        return "Terms & Conditions";
        break;
      case CMSType.AboutUs:
        return "About Us";
        break;
    }
  }

  ResCMSList cmsData;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ServiceModel.getProfileDetails(type: widget.cmsType,completion: (res){
      switch (res.state) {
        case Status.LOADING:
          setState(() {
            isLoading = true;
          });
          break;
        case Status.COMPLETED:
          setState(() {
            isLoading = false;
            cmsData = res.data.data.list.first;
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
          title: Text(getPageTitle()),
        ),
        body: buildContainer()
    );
  }

  Widget buildContainer() {

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

    if (cmsData == null) {
      return NoDataFoundContainer();
    }

    return WebViewPlus(
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (controller) {
        controller.loadString(cmsData.htmldata ?? "");
      },
    );
  }
}