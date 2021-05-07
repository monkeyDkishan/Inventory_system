import 'package:flutter/material.dart';
import 'package:inventory_system/component/NoDataFoundContainer.dart';
import 'package:inventory_system/data/models/res/ResGetBillDetails.dart';

class StatementScreen extends StatefulWidget {

  StatementScreen({this.statementName,this.index,this.res});

  final String statementName;
  final int index;

  final GetBillDetailsList res;

  @override
  _StatementScreenState createState() => _StatementScreenState();
}

class _StatementScreenState extends State<StatementScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Order'),
      ),
      body: buildContainer()
    );
  }

  Widget buildContainer() {

    if(widget.res == null){
      return NoDataFoundContainer();
    }

    final data = widget.res;

    return Container(
      child: Column(
        children: [
          Expanded(child: Container(
            child: buildListView(),
          )),
          Container(
            color: Colors.white,
            width: double.infinity,
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Order Is: '),
                    Text('${data.isOrderPlaced ? 'Placed' : 'Pending'}',style: TextStyle(
                        fontSize: 16,
                        color: data.isOrderPlaced ? Colors.green : Colors.redAccent
                    ),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Payment Is: '),
                    Text('${data.isamountpaid ? 'Paid' : 'Pending'}',style: TextStyle(
                        fontSize: 16,
                      color: data.isamountpaid ? Colors.green : Colors.redAccent
                    ),),
                  ],
                ),
                SizedBox(height: 5),
                Container(height: 1,color: Colors.black.withOpacity(0.4),),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total: '),
                    Text('Rs. ${data.totalpayable}',style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildListView() {
    if (widget.res.orderitems.length == 0){
      return NoDataFoundContainer(errText: 'No Times Found',);
    }
    return ListView.builder(
            itemCount: widget.res.orderitems.length,
            itemBuilder: (context, index) {

              final data = widget.res.orderitems[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${data.productname}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                          ),
                        ),
                        Text('Note: ${data.note}'),
                        Text('Category: ${data.categoryName}'),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                            child: Text('RS. ${data.itempayable}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              );
          },);
  }
}
