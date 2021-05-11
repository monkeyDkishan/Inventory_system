import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_system/AppLocalizations.dart';
import 'package:inventory_system/Screens/HomeScreen.dart';
import 'package:inventory_system/Screens/LoginOTPScreen.dart';
import 'package:inventory_system/Screens/OTPScreen.dart';
import 'package:inventory_system/Utilities/ColorUtil.dart';
import 'package:inventory_system/Utilities/FontUtil.dart';
import 'package:inventory_system/Utilities/ImageUtil.dart';
import 'package:inventory_system/component/CustomPopup.dart';
import 'package:inventory_system/component/LoadingSmall.dart';
import 'package:inventory_system/data/models/AuthModel.dart';
import 'package:inventory_system/data/models/res/BaseRes.dart';
import 'package:inventory_system/services/webService.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController _controller;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    String translate(String key){
      return AppLocalizations.of(context).translate(key) ?? "";
    }

    return Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    Column(
                      children: [
                        SizedBox(height: 30),
                        Center(child: Text(translate("welcome_to_app_LOGIN_SCREEN"),style: TextStyle(
                            fontFamily: FontUtil.regular_fonts,
                            fontSize: 30
                        ),)),
                        SizedBox(height: 40),
                        Container(child: ImageUtil.app_logo),
                        SizedBox(height: 40),
                        Center(child: Text(translate("enter_mobile_number_LOGIN_SCREEN"),style: TextStyle(
                          fontFamily: FontUtil.regular_fonts,
                          fontSize: 20,
                        ),textAlign: TextAlign.center,)),
                        SizedBox(height: 40),
                      ],
                    ),


                    Column(
                      children: [
                        Container(
                          child: TextField(
                            controller: _controller,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: translate("mobile_number_LOGIN_SCREEN"),
                                hintText: translate("enter_mobile_number_LOGIN_SCREEN")
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        Container(
                          width: double.infinity,
                          color: ColorUtil.buttonColor,
                          child: TextButton(
                            onPressed: (){

                              if(isLoading){return;}

                              AuthModel.validateMobile(mobile: _controller.text,completion: (res){

                                switch(res.state){
                                  case Status.LOADING:
                                    setState(() {
                                      isLoading = true;
                                    });
                                    break;
                                  case Status.COMPLETED:
                                    setState(() {
                                      isLoading = false;
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginOTPScreen()));
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

                            },
                            child: isLoading ? LoadingSmall() : Text(translate("continue_button_LOGIN_SCREEN"),style: TextStyle(
                                color: Colors.white,
                                fontFamily: FontUtil.regular_fonts,
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
