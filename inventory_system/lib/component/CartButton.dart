import 'package:flutter/material.dart';
import 'package:inventory_system/Screens/CartScreen.dart';
import 'package:inventory_system/services/CartService.dart';
import 'dart:convert';

// class CartBtn extends StatefulWidget {
//   @override
//   _CartBtnState createState() => _CartBtnState();
// }
//
// class _CartBtnState extends State<CartBtn> {
//
//   Stream _stream;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _stream = CartBloc.countStream.stream;
//   }
//   int totalCart = 0;
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<int>(
//       stream: _stream,
//       builder: (context, snapshot) {
//
//         if(snapshot.data != null){
//           totalCart = snapshot.data;
//         }else{
//           totalCart = 0;
//         }
//
//         return Stack(
//           children: [
//             IconButton(
//               icon: Icon(
//                 Icons.shopping_cart,
//                 color: Colors.white,
//               ),
//               onPressed: (){
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
//               },
//             ),
//             totalCart != 0 ? Positioned(top: 0,right: 5,child: Container(decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               color: Colors.black54,),child: Center(child: Text(totalCart <= 9 ? totalCart.toString() : "9+")),),height: 20,width: 20,) : Container()
//           ],
//         );
//       },
//     );
//   }
// }

class CartForAll extends StatelessWidget {
  final totalCart;
  Function callBack;
  CartForAll({this.totalCart,this.callBack});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen())).then((value) {
              callBack();
            });
          },
        ),
        totalCart != 0 ? Positioned(top: 0,right: 5,child: Container(decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black54,),child: Center(child: Text(totalCart <= 9 ? totalCart.toString() : "9+")),),height: 20,width: 20,) : Container()
      ],
    );
  }
}
