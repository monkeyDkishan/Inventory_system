import 'package:flutter/material.dart';
import 'package:inventory_system/Utilities/ColorUtil.dart';

class FullScreenDialog extends StatefulWidget {

  FullScreenDialog({this.units, this.completion, this.quantity, this.notes, this.dropdownValue});

  final List<UnitItem> units;

  Function(UnitItem,int,String) completion;

  int quantity = 0;

  String notes = "";

  UnitItem dropdownValue;

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

    _quantityController.text = widget.quantity.toString() ?? "" ;
    _notesController.text = widget.notes ?? "" ;

    setState(() {
      quantity = widget.quantity;
      notes = widget.notes;
      if(widget.dropdownValue != null){
        dropdownValue = widget.dropdownValue;
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
                      });
                    },
                    items: widget.units.map<DropdownMenuItem<UnitItem>>((UnitItem value) {
                      return DropdownMenuItem<UnitItem>(
                        value: value,
                        child: Text(value.unitName ?? ""),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: TextField(
                    controller: _quantityController,
                    onChanged: (value) {
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
                                onPressed: () {
                                  widget.completion(dropdownValue,quantity,notes);
                                  Navigator.pop(context);
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