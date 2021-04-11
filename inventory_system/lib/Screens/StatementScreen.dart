import 'package:flutter/material.dart';

class StatementScreen extends StatefulWidget {

  StatementScreen({this.statementName,this.index});

  final String statementName;
  final int index;

  @override
  _StatementScreenState createState() => _StatementScreenState();
}

class _StatementScreenState extends State<StatementScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.statementName),
      ),
      body: Container()
    );
  }
}
