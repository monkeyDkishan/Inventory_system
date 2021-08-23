import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventory_system/Screens/HomeScreen.dart';
import 'package:inventory_system/Utilities/ColorUtil.dart';
import 'package:inventory_system/Utilities/ImageUtil.dart';
import 'package:inventory_system/component/CustomPopup.dart';
import 'package:inventory_system/component/LoadingSmall.dart';
import 'package:inventory_system/data/models/AuthModel.dart';
import 'package:inventory_system/services/webService.dart';

class LoginOTPScreen extends StatefulWidget {
  @override
  _LoginOTPScreenState createState() => _LoginOTPScreenState();
}

class _LoginOTPScreenState extends State<LoginOTPScreen> {
  //Objects
  TextEditingController otpTextField1 = new TextEditingController();
  TextEditingController otpTextField2 = new TextEditingController();
  TextEditingController otpTextField3 = new TextEditingController();
  TextEditingController otpTextField4 = new TextEditingController();

  FocusNode otp_node_1 = FocusNode();
  FocusNode otp_node_2 = FocusNode();
  FocusNode otp_node_3 = FocusNode();
  FocusNode otp_node_4 = FocusNode();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var mediaQuerySize = MediaQuery.of(context).size;

    middleSizedBoxes(int height) {
      return SizedBox(
        height: mediaQuerySize.height / height,
      );
    }

    Widget KeyBordDismissGesture(Widget child) {
      return new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: new Container(
            child: child,
          ));
    }

    Widget OTPBox(TextEditingController textField, FocusNode node,
        FocusNode nextNode, FocusNode previousNode) {
      return Container(
        width: mediaQuerySize.width / 7,
        child: TextFormField(
          focusNode: node,
          controller: textField,
          autofocus: true,
          autocorrect: false,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
          ],
          keyboardType: TextInputType.number,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          onChanged: (text) {
            if (text.length >= 1) {
              node.unfocus();
              if (nextNode != null) {
                nextNode.requestFocus();
              }
            }
            if (text.isEmpty) {
              node.unfocus();
              if (previousNode != null) {
                previousNode.requestFocus();
              }
            }
          },
          textAlign: TextAlign.center,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign In',
          style: TextStyle(color: Colors.black),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: KeyBordDismissGesture(
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      middleSizedBoxes(30),
                      Container(
                        height: mediaQuerySize.height / 5,
                        child: ImageUtil.app_logo,
                      ),
                      middleSizedBoxes(30),
                      Text("OTP Verification",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            OTPBox(otpTextField1, otp_node_1, otp_node_2,
                                FocusNode()),
                            OTPBox(otpTextField2, otp_node_2, otp_node_3,
                                otp_node_1),
                            OTPBox(otpTextField3, otp_node_3, otp_node_4,
                                otp_node_2),
                            OTPBox(otpTextField4, otp_node_4, FocusNode(),
                                otp_node_3),
                          ],
                        ),
                      ),
                      middleSizedBoxes(30),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: ColorUtil.buttonColor,
                        ),
                        child: isLoading
                            ? Container(
                          width: 50,
                                child: Center(
                                    child: Container(
                                child: LoadingSmall(),
                                height: 22,
                                width: 22,
                              )))
                            : Container(
                                width: double.infinity,
                                child: TextButton(
                                  child: Text(
                                    "VERIFY & PROCEED",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  onPressed: () {

                                    final otp = otpTextField1.text + otpTextField2.text + otpTextField3.text + otpTextField4.text;

                                    AuthModel.validateOtp(otp: otp,completion: (res){

                                      switch(res.state){
                                        case Status.LOADING:
                                          setState(() {
                                            isLoading = true;
                                          });
                                          break;
                                        case Status.COMPLETED:
                                          setState(() {
                                            isLoading = false;

                                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);

                                          });
                                          break;
                                        case Status.ERROR:
                                          setState(() {
                                            isLoading = false;
                                          });
                                          CustomPopup(context, title: 'Sorry', message: res.msg ?? "Error", primaryBtnTxt: 'OK');

                                          break;
                                      }

                                    });

                                    setState(() {
                                      isLoading = true;
                                    });
                                  },
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
