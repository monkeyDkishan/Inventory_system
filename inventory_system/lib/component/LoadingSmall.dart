import 'package:flutter/material.dart';

class LoadingSmall extends StatelessWidget {

  final double size;

  final Color color;

  LoadingSmall({this.size,this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: size ?? 20,
        child: AspectRatio(
            aspectRatio: 1,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(color ?? Colors.white),
            )
        ),
      ),
    );
  }
}
