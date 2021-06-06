
class ReqUpdateOrderDetails {
  ReqUpdateOrderDetails({
    this.selectedDeliveryType,
    this.subTotal,
    this.deliveryCharge,
    this.finalTotal,
    this.tcsamount,
    this.tcsamountpercentage,
    this.partyid,
    this.orderid,
    this.cartItems,
  });

  int selectedDeliveryType;
  double subTotal;
  double deliveryCharge;
  double finalTotal;
  double tcsamount;
  double tcsamountpercentage;
  int partyid;
  int orderid;
  List<CartItem> cartItems;

  factory ReqUpdateOrderDetails.fromJson(Map<String, dynamic> json) => ReqUpdateOrderDetails(
    selectedDeliveryType: json["selected_delivery_type"],
    subTotal: json["sub_total"],
    deliveryCharge: json["delivery_charge"],
    finalTotal: json["final_total"],
    tcsamount: json["tcsamount"],
    tcsamountpercentage: json["tcsamountpercentage"].toDouble(),
    partyid: json["partyid"],
    orderid: json["orderid"],
    cartItems: List<CartItem>.from(json["cart_items"].map((x) => CartItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "selected_delivery_type": selectedDeliveryType,
    "sub_total": subTotal,
    "delivery_charge": deliveryCharge,
    "final_total": finalTotal,
    "tcsamount": tcsamount,
    "tcsamountpercentage": tcsamountpercentage,
    "partyid": partyid,
    "orderid": orderid,
    "cart_items": List<dynamic>.from(cartItems.map((x) => x.toJson())),
  };
}

class CartItem {
  CartItem({
    this.productid,
    this.categoryid,
    this.subcategoryid,
    this.selectedUnitId,
    this.note,
    this.quantity,
    this.orderitemid,
    this.unitPrise,
    this.itempayable
  });

  int productid;
  int categoryid;
  int subcategoryid;
  int selectedUnitId;
  double unitPrise;
  double itempayable;
  String note;
  int quantity;
  int orderitemid;

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    productid: json["productid"],
    categoryid: json["Categoryid"],
    subcategoryid: json["Subcategoryid"],
    selectedUnitId: json["selected_unitId"],
    // totalPayable: json["totalPayable"],
    note: json["note"],
    quantity: json["quantity"],
    orderitemid: json["orderitemid"],
  );

  Map<String, dynamic> toJson() => {
    "productid": productid,
    "Categoryid": categoryid,
    "Subcategoryid": subcategoryid,
    "selected_unitId": selectedUnitId,
    "note": note,
    "quantity": quantity,
    "orderitemid": orderitemid,
    "itempayable":itempayable,
  };
}
