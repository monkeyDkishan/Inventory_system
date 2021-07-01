import 'package:flutter/material.dart';
import 'package:inventory_system/Utilities/ColorUtil.dart';
import 'package:inventory_system/component/CustomPopup.dart';
import 'package:inventory_system/data/models/CartModel.dart';

class FullScreenDialog extends StatefulWidget {

  FullScreenDialog({@required this.productID ,this.units, this.completion, this.quantity, this.notes, this.dropdownValue, this.index});

  final List<UnitItem> units;

  Function(UnitItem,int,String,int) completion;

  int quantity = 0;

  final int productID;

  String notes = "";

  UnitItem dropdownValue;

  int index = 0;

  @override
  FullScreenDialogState createState() => new FullScreenDialogState();
}

class FullScreenDialogState extends State<FullScreenDialog> {
  TextEditingController _quantityController = new TextEditingController();
  TextEditingController _notesController = new TextEditingController();

  // TextEditingController _skillThreeController = new TextEditingController();

  int quantity = 0;

  String notes = "";

  UnitItem dropdownValue;

  FullScreenDialogState();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _quantityController.text = (widget.quantity ?? 0).toString() ;
    _notesController.text = widget.notes ?? "" ;

    setState(() {
      quantity = widget.quantity ?? 0;
      notes = widget.notes;
      if(widget.dropdownValue != null){
        dropdownValue = widget.units[widget.index ?? 0];
      }
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Container(
                  height: 44,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all()),
                  child: DropdownButton<UnitItem>(
                    hint: Text('Please Select'),
                    isExpanded: true,
                    value: dropdownValue,
                    icon: Icon(Icons.keyboard_arrow_down),
                    iconSize: 24,
                    elevation: 16,
                    underline: Container(),
                    onChanged: (UnitItem newValue) {
                      setState(() {
                        dropdownValue = newValue;

                        widget.units.asMap().forEach((index, value) {

                          if(value.unitId == newValue.unitId){
                            widget.index = index;
                          }

                        });

                      });
                    },
                    items: widget.units.map<DropdownMenuItem<UnitItem>>((UnitItem value) {
                      return DropdownMenuItem<UnitItem>(
                        value: value,
                        child: Text('${(value.unitName ?? "")} for Rs. ${(value.unitPrice ?? 0.0)}'),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: TextField(
                    controller: _quantityController,
                    onChanged: (value) {
                      print(value);
                      quantity = int.parse(value);
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Quantity",
                        hintText: "Enter Quantity"
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: TextField(
                    controller: _notesController,
                    onChanged: (value) {
                      notes = value;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Note",
                        hintText: "Enter Note"
                    ),
                    maxLines: 5,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: ColorUtil.buttonColor,
                            ),
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.white,fontSize: 15),
                                ))),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: ColorUtil.buttonColor,
                            ),
                            child: TextButton(
                                onPressed: () async {

                                  if(dropdownValue == null){
                                    CustomPopup(context, title: 'Validate', message: 'Please select unit', primaryBtnTxt: 'OK');
                                    return;
                                  }

                                  if(_quantityController.text.isEmpty){
                                    CustomPopup(context, title: 'Validate', message: 'Please enter quantity', primaryBtnTxt: 'OK');
                                    return;
                                  }

                                  final quantity = int.parse(_quantityController.text);

                                  if(quantity == 0){
                                    CustomPopup(context, title: 'Validate', message: 'Please enter quantity', primaryBtnTxt: 'OK');
                                    return;
                                  }

                                  // if(_notesController.text.isEmpty){
                                  //   CustomPopup(context, title: 'Validate', message: 'Please enter notes', primaryBtnTxt: 'OK');
                                  //   return;
                                  // }

                                  final isAvailable = await CartModel().isInStock(productID: widget.productID,Quntity: quantity,Unitid: dropdownValue.unitId ?? 0);

                                  if (isAvailable){
                                    widget.completion(dropdownValue,quantity,notes,widget.index);
                                    Navigator.pop(context);
                                  }else{
                                    CustomPopup(context, title: 'Not Available', message: 'This much item is not in stock', primaryBtnTxt: 'OK');
                                  }
                                },
                                child: Text(
                                  "Add",
                                  style: TextStyle(color: Colors.white,fontSize: 15),
                                ))),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class UnitItem{
  final String unitName;
  final int unitId;
  final double unitPrice;

  UnitItem({this.unitName, this.unitId, this.unitPrice});
}