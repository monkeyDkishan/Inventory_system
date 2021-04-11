import 'package:flutter/material.dart';
import 'package:inventory_system/Screens/StatementScreen.dart';

class StatementListScreen extends StatefulWidget {
  @override
  _StatementListScreenState createState() => _StatementListScreenState();
}

class _StatementListScreenState extends State<StatementListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Statements"),
      ),
      body: Container(
        child: SafeArea(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index){
              return Container(
                margin: EdgeInsets.all(5),
                child: GestureDetector(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text("Statement $index"),
                    ),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => StatementScreen(index: index,statementName: "Statement $index")));
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
