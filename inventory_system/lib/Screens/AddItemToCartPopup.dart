import 'package:flutter/material.dart';
import 'package:inventory_system/Utilities/ColorUtil.dart';

class FullScreenDialog extends StatefulWidget {

  FullScreenDialog({this.units});

  final List<String> units;

  @override
  FullScreenDialogState createState() => new FullScreenDialogState();
}

class FullScreenDialogState extends State<FullScreenDialog> {
  TextEditingController _skillOneController = new TextEditingController();
  TextEditingController _skillTwoController = new TextEditingController();

  TextEditingController _skillThreeController = new TextEditingController();

  String dropdownValue;

  FullScreenDialogState();

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
                  child: DropdownButton<String>(
                    hint: Text('Please Select'),
                    isExpanded: true,
                    value: dropdownValue,
                    icon: Icon(Icons.keyboard_arrow_down),
                    iconSize: 24,
                    elevation: 16,
                    underline: Container(),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: widget.units.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: TextField(
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
