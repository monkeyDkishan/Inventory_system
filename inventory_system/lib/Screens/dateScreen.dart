
import 'package:flutter/material.dart';
import 'package:inventory_system/Screens/StatementListScreen.dart';
import 'package:inventory_system/Utilities/ColorUtil.dart';

class DateScreen extends StatefulWidget {
  @override
  _DateScreenState createState() => _DateScreenState();
}

class _DateScreenState extends State<DateScreen> {

  DateTime startDate = DateTime.now();

  DateTime endDate = DateTime.now();

  Future<void> _selectStartDate(BuildContext context) async {
    print('cool');
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != startDate)
      setState(() {
        startDate = picked;
      });
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: endDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != endDate)
      setState(() {
        endDate = picked;
      });
  }

  String formateDate(DateTime date){
    return "${date.day}/${date.month}/${date.year}";
  }

  String formateDateForNext(DateTime date){
    return "${date.month}/${date.day}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insert Date'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorUtil.primoryColor),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextButton(
                      onPressed: () => _selectStartDate(context),
                      child: Text('Start Date: ${formateDate(startDate)}',
                          style: TextStyle(
                            color: Colors.black
                          ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: ColorUtil.primoryColor),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextButton(
                      onPressed: () => _selectEndDate(context),
                      child: Text('End Date: ${formateDate(endDate)}',
                        style: TextStyle(
                            color: Colors.black
                        ),
                      ),
                    ),
                  ),
                ),
              ],

            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => StatementListScreen(
                fromDate: formateDate(startDate),
                toDate: formateDate(endDate),
              ),));
            },
            child: Container(
              height: 50,
              color: ColorUtil.primoryColor,
              child: Center(
                child: Text(
                  'Go',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
