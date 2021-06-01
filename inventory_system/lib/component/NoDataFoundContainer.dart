import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoDataFoundContainer extends StatelessWidget {

  final String errText;
  final Color txtColor;

  const NoDataFoundContainer({this.errText,this.txtColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(errText ?? "No Data Found",style: TextStyle(
        color: txtColor ?? Colors.black.withOpacity(0.3)
      ),),
    );
  }
}
