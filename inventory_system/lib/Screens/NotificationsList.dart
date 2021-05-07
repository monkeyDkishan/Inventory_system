import 'package:flutter/material.dart';
import 'package:inventory_system/Utilities/ColorUtil.dart';
import 'package:inventory_system/component/CustomPopup.dart';
import 'package:inventory_system/component/LoadingSmall.dart';
import 'package:inventory_system/component/NoDataFoundContainer.dart';
import 'package:inventory_system/data/models/NotificationModel.dart';
import 'package:inventory_system/data/models/res/ResGetMobileNotification.dart';
import 'package:inventory_system/services/webService.dart';

class NotificationList extends StatefulWidget {
  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  bool isLoading = false;

  List<ResGetMobileNotificationList> list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    NotificationModel.getNotification(completion: (res) {
      switch (res.state) {
        case Status.LOADING:
          setState(() {
            isLoading = true;
          });
          break;
        case Status.COMPLETED:
          setState(() {
            isLoading = false;
            list = res.data.data.list;
          });
          break;
        case Status.ERROR:
          setState(() {
            isLoading = false;
          });
          CustomPopup(context,
              title: 'Sorry', message: res.msg ?? "Error", primaryBtnTxt: 'OK');
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: Container(
        child: SafeArea(
          child: buildListView(),
        ),
      ),
    );
  }

  Widget buildListView() {
    if (isLoading) {
      return Container(
        child: Center(
          child: Container(
            width: 22,
            height: 22,
            child: LoadingSmall(
              color: ColorUtil.primoryColor,
            ),
          ),
        ),
      );
    }

    if (list == null || list.length <= 0) {
      return NoDataFoundContainer();
    }

    return ListView.builder(
      itemCount: list.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        final data = list[index];
        return Container(
          margin: EdgeInsets.all(5),
          child: GestureDetector(
            child: Card(
              child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${data.notificationTitle}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                         fontSize: 16
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '${data.notificationDesc}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  )),
            ),
            onTap: () {},
          ),
        );
      },
    );
  }
}
