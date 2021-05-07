// class ReqAddOrderDetails {
//   ReqAddOrderDetails({
//     this.selectedDeliveryType,
//     this.subTotal,
//     this.deliveryCharge,
//     this.finalTotal,
//     this.tcsamount,
//     this.tcsamountpercentage,
//     this.partyid,
//     this.cartItems,
//   });
//
//   int selectedDeliveryType;
//   double subTotal;
//   double deliveryCharge;
//   double finalTotal;
//   double tcsamount;
//   double tcsamountpercentage;
//   int partyid;
//   List<ReqCartItemAddOrderDetails> cartItems;
//
//   factory ReqAddOrderDetails.fromJson(Map<String, dynamic> json) => ReqAddOrderDetails(
//     selectedDeliveryType: json["selected_delivery_type"],
//     subTotal: json["sub_total"],
//     deliveryCharge: json["delivery_charge"],
//     finalTotal: json["final_total"],
//     tcsamount: json["tcsamount"],
//     tcsamountpercentage: json["tcsamountpercentage"].toDouble(),
//     partyid: json["partyid"],
//     cartItems: List<ReqCartItemAddOrderDetails>.from(json["cart_items"].map((x) => ReqCartItemAddOrderDetails.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "selected_delivery_type": selectedDeliveryType.toString(),
//     "sub_total": subTotal.toString(),
//     "delivery_charge": deliveryCharge.toString(),
//     "final_total": finalTotal.toString(),
//     "tcsamount": tcsamount.toString(),
//     "tcsamountpercentage": tcsamountpercentage.toString(),
//     "partyid": partyid.toString(),
//     "cart_items": List<dynamic>.from(cartItems.map((x) => x.toJson())).toString(),
//   };
// }
//
// class ReqCartItemAddOrderDetails {
//   ReqCartItemAddOrderDetails({
//     this.productid,
//     this.categoryid,
//     this.subcategoryid,
//     this.selectedUnitId,
//     this.note,
//     this.quantity,
//   });
//
//   int productid;
//   int categoryid;
//   int subcategoryid;
//   int selectedUnitId;
//   String note;
//   int quantity;
//
//   factory ReqCartItemAddOrderDetails.fromJson(Map<String, dynamic> json) => ReqCartItemAddOrderDetails(
//     productid: json["productid"],
//     categoryid: json["Categoryid"],
//     subcategoryid: json["Subcategoryid"],
//     selectedUnitId: json["selected_unitId"],
//     note: json["note"],
//     quantity: json["quantity"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "productid": productid,
//     "Categoryid": categoryid,
//     "Subcategoryid": subcategoryid,
//     "selected_unitId": selectedUnitId,
//     "note": note,
//     "quantity": quantity,
//   };
// }

class ReqAddOrderDetails {
  ReqAddOrderDetails({
    this.selectedDeliveryType,
    this.subTotal,
    this.deliveryCharge,
    this.finalTotal,
    this.tcsamount,
    this.tcsamountpercentage,
    this.partyid,
    this.cartItems,
  });

  int selectedDeliveryType;
  double subTotal;
  double deliveryCharge;
  double finalTotal;
  double tcsamount;
  double tcsamountpercentage;
  int partyid;
  List<ReqCartItemAddOrderDetails> cartItems;

  factory ReqAddOrderDetails.fromJson(Map<String, dynamic> json) => ReqAddOrderDetails(
    selectedDeliveryType: json["selected_delivery_type"],
    subTotal: json["sub_total"],
    deliveryCharge: json["delivery_charge"],
    finalTotal: json["final_total"],
    tcsamount: json["tcsamount"].toDouble(),
    tcsamountpercentage: json["tcsamountpercentage"].toDouble(),
    partyid: json["partyid"],
    cartItems: List<ReqCartItemAddOrderDetails>.from(json["cart_items"].map((x) => ReqCartItemAddOrderDetails.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "selected_delivery_type": selectedDeliveryType.toString(),
    "sub_total": subTotal.toString(),
    "delivery_charge": deliveryCharge.toString(),
    "final_total": finalTotal.toString(),
    "tcsamount": tcsamount.toString(),
    "tcsamountpercentage": tcsamountpercentage.toString(),
    "partyid": partyid.toString(),
    "cart_items": List<dynamic>.from(cartItems.map((x) => x.toJson())),
  };
}

class ReqCartItemAddOrderDetails {
  ReqCartItemAddOrderDetails({
    this.productid,
    this.categoryid,
    this.subcategoryid,
    this.selectedUnitId,
    this.note,
    this.quantity,
  });

  int productid;
  int categoryid;
  int subcategoryid;
  int selectedUnitId;
  String note;
  int quantity;

  factory ReqCartItemAddOrderDetails.fromJson(Map<String, dynamic> json) => ReqCartItemAddOrderDetails(
    productid: json["productid"],
    categoryid: json["Categoryid"],
    subcategoryid: json["Subcategoryid"],
    selectedUnitId: json["selected_unitId"],
    note: json["note"],
    quantity: json["quantity"],
  );

  Map<String, String> toJson() => {
    "productid": productid.toString(),
    "Categoryid": categoryid.toString(),
    "Subcategoryid": subcategoryid.toString(),
    "selected_unitId": selectedUnitId.toString(),
    "note": note,
    "quantity": quantity.toString(),
  };
}
