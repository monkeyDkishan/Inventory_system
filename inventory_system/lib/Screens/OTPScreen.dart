import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventory_system/AppLocalizations.dart';
import 'package:inventory_system/Screens/HomeScreen.dart';
import 'package:inventory_system/Utilities/ColorUtil.dart';
import 'package:inventory_system/Utilities/FontUtil.dart';
import 'package:inventory_system/Utilities/ImageUtil.dart';

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {

  var otp1 = TextEditingController();
  var otp2 = TextEditingController();
  var otp3 = TextEditingController();
  var otp4 = TextEditingController();

  final FocusNode otp_node_1 = FocusNode();
  final FocusNode otp_node_2 = FocusNode();
  final FocusNode otp_node_3 = FocusNode();
  final FocusNode otp_node_4 = FocusNode();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    otp1.dispose();
    otp2.dispose();
    otp3.dispose();
    otp4.dispose();

    otp_node_1.dispose();
    otp_node_2.dispose();
    otp_node_3.dispose();
    otp_node_4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    String translate(String key) {
      return AppLocalizations.of(context).translate(key) ?? "";
    }

    return Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Container(
            height: size.height,
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.,
                  children: [
                    Column(
                      children: [
                        Center(
                            child: Text(
                          translate("enter_otp_OTP_SCREEN"),
                          style: TextStyle(
                              fontFamily: FontUtil.regular_fonts, fontSize: 30),
                        )),
                        SizedBox(height: 40),
                        Container(child: ImageUtil.app_logo),
                        Center(
                            child: Text(
                          translate("otp_has_been_sent_OTP_SCREEN"),
                          style: TextStyle(
                            fontFamily: FontUtil.regular_fonts,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        )),
                      ],
                    ),
                    SizedBox(height: 40),
                    Column(
                      children: [
                        Container(
                          height: 80,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(child: OTPTextBox(otp1,otp_node_1,otp_node_2)),
                              Expanded(child: OTPTextBox(otp2,otp_node_2,otp_node_3)),
                              Expanded(child: OTPTextBox(otp3,otp_node_3,otp_node_4)),
                              Expanded(child: OTPTextBox(otp4,otp_node_4,FocusNode())),
                            ],
                          ),
                        ),
                        SizedBox(height: 40),
                        Container(
                          width: double.infinity,
                          color: ColorUtil.buttonColor,
                          child: TextButton(
                            onPressed: () {
                              print("OTP is: " + otp1.text+otp2.text+otp3.text+otp4.text);
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
                            },
                            child: Text(
                              translate("submit_OTP_SCREEN"),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: FontUtil.regular_fonts,
                                  fontWeight: FontWeight.bold),
                            ),
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

  Container OTPTextBox(TextEditingController controller,FocusNode node,FocusNode nextNode) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(),
        ),
        margin: EdgeInsets.all(5),
        child: TextFormField(
          controller: controller,
          focusNode: node,
          style: TextStyle(fontSize: 30.0),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          decoration: new InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding:
              EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),),
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
          onChanged: (value){
            if(value.length >= 1){
              node.unfocus();
              if (nextNode != null){
                nextNode.requestFocus();
              }
            }

          },
        ),
      );
}
