import 'package:flutter/material.dart';

class NotificationList extends StatefulWidget {
  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
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
                      child: Text("Notification $index"),
                    ),
                  ),
                  onTap: (){

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
