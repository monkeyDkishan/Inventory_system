import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:inventory_system/Utilities/ColorUtil.dart';

class CustomPopup {

  final String title;
  final String message;
  final String primaryBtnTxt;
  final String secondaryBtnTxt;
  final Function primaryAction;
  final Function secondaryAction;

  CustomPopup(BuildContext context, {@required this.title,@required this.message,@required this.primaryBtnTxt, this.secondaryBtnTxt, this.primaryAction, this.secondaryAction}){
    final size = MediaQuery.of(context).size;

    showDialog(context: context,
        builder: (context){
          return Scaffold(
            backgroundColor: Colors.black.withOpacity(0.3),
            body: Center(
              child: Container(
                constraints: BoxConstraints(minWidth: 100, maxWidth: size.width * 0.9,minHeight: 100,maxHeight: size.height * 0.9),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Icon(Icons.close,color: Colors.transparent,),
                          Expanded(
                            child: Text(title,style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            ),textAlign: TextAlign.center,),
                          ),
                          // IconButton(icon: Icon(Icons.close), onPressed: (){
                          //   Navigator.of(context).pop();
                          // })
                        ],
                      ),
                    ),
                    // SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Text(message,style: TextStyle(
                          fontSize: 16
                      ),textAlign: TextAlign.center,),
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          if(secondaryBtnTxt != null)
                            Expanded(
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: ColorUtil.primoryColor),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: TextButton(
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                    if(secondaryAction != null ){
                                      secondaryAction();
                                    }
                                  },
                                  child: Text(secondaryBtnTxt  ,style: TextStyle(
                                      color: ColorUtil.primoryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),),
                                ),
                              ),
                            ),
                          if(secondaryBtnTxt != null)
                            SizedBox(width: 10,),
                          Expanded(
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  color: ColorUtil.primoryColor,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: TextButton(
                                onPressed: (){
                                  Navigator.of(context).pop();
                                  if(primaryAction != null){
                                    primaryAction();
                                  }
                                },
                                child: Text(primaryBtnTxt,style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
