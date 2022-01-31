import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_system/Screens/AddItemToCartPopup.dart';
import 'package:inventory_system/Screens/ItemDetailScreen.dart';
import 'package:inventory_system/Screens/SubCategoryScreen.dart';
import 'package:inventory_system/Utilities/ColorUtil.dart';
import 'package:inventory_system/Utilities/ImageUtil.dart';
import 'package:inventory_system/Utilities/constants.dart';
import 'package:inventory_system/component/LoadingSmall.dart';
import 'package:inventory_system/component/NoDataFoundContainer.dart';
import 'package:inventory_system/data/models/CategoryModel.dart';
import 'package:inventory_system/data/models/res/ResGetItemID.dart';
import 'package:inventory_system/data/models/res/ResGetItemList.dart';
import 'package:inventory_system/services/webService.dart';

class SearchItemsScreen extends StatefulWidget {
  const SearchItemsScreen({Key key}) : super(key: key);

  @override
  _SearchItemsScreenState createState() => _SearchItemsScreenState();
}

class _SearchItemsScreenState extends State<SearchItemsScreen> {

  bool isLoading = false;

  List<ListElement> resList = [];

  List<UnitItem> units;

  ScrollController controller;

  int page = 1;

  int totalPage = 1;

  String searchedText = '';

  _scrollListener() {
    // final isLoading = Provider.of<WallProvider>(context).wallImageList.state == Status.LOADING;

    print(controller.position.extentAfter);
    if (controller.position.extentAfter <= 0 && !isLoading) {
      getData();
    }
  }


  getData() async {
    setState(() {
      isLoading = true;
    });

    if (totalPage < page) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    await CategoryModel.getItemID(page: page,completion: (res){

      if(res.state == Status.COMPLETED){

        try{

          if(res.data.status == 1){
            var data = res.data.data;

            totalPage = data.pageSize ?? 0;

            page += 1;

            setState(() {
              resList.addAll(data.list);
            });
          }else{
            // setState(() {
            //   resList = [];
            // });
          }

        }catch(e){
          print(e);
        }
      }

    },text: searchedText);

    setState(() {
      isLoading = false;
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = new ScrollController()..addListener(_scrollListener);

    // CategoryModel.getItemList(productId: widget.productId,catId: widget.categoryId,subCatId: widget.subCategoryId,completion: (res) {
    //   switch (res.state) {
    //     case Status.LOADING:
    //       setState(() {
    //         isLoading = true;
    //       });
    //       break;
    //     case Status.COMPLETED:
    //       setState(() {
    //         isLoading = false;
    //         resList = res.data.data.list;
    //
    //       });
    //       break;
    //     case Status.ERROR:
    //       setState(() {
    //         isLoading = false;
    //       });
    //       CustomPopup(context,
    //           title: 'Sorry', message: res.msg ?? "Error", primaryBtnTxt: 'OK');
    //       break;
    //   }
    // });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        color: ColorUtil.primoryColor,
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: 44,
                color: ColorUtil.primoryColor,
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 35,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(44)
                        ),
                        child: TextField(
                          onChanged: (text)async {

                            if(text.length > 3){

                              searchedText = text;

                              page = 1;

                              totalPage = 1;

                              resList = [];

                              getData();

                              // await CategoryModel.getItemID(page: page,completion: (res){
                              //
                              //   if(res.state == Status.COMPLETED){
                              //
                              //     try{
                              //
                              //       if(res.data.status == 1){
                              //         var data = res.data.data;
                              //
                              //         setState(() {
                              //           resList = data.list;
                              //         });
                              //       }else{
                              //         setState(() {
                              //           resList = [];
                              //         });
                              //       }
                              //
                              //     }catch(e){
                              //       setState(() {
                              //         resList = [];
                              //       });
                              //       print(e);
                              //     }
                              //   }
                              //
                              // },text: text);

                            }

                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search',
                              contentPadding: EdgeInsets.only(left: 15,bottom: 15)
                          ),
                        ),
                      ),
                    ),
                    IconButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, icon: Icon(Icons.close,color: Colors.white,))
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                    child: buildListView()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  cool(){

  }

  Widget buildListView() {

    // if(isLoading){
    //   return LoadingSmall(color: ColorUtil.primoryColor,size: 22,);
    // }

    if(resList == null || resList.length <= 0){
      return NoDataFoundContainer();
    }

    return ListView.builder(
      controller: controller,
      itemCount: resList.length,
      itemBuilder: (BuildContext context, int index) {

        final res = resList[index];


        return Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: GestureDetector(
            onTap: (){

              Navigator.push(context, MaterialPageRoute(builder: (context) => SubCategoryScreen(subCategoryName: res.code,productId: res.itemId))).then((value) {

              });

              // Navigator.push(context, MaterialPageRoute(builder: (context) => ItemDetailScreen(index: index,itemDetail: res,))).then((value) {
              //   print('cool');
              // });
            },
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(res.code ?? ''),
                                  Text(res.itemId.toString() ?? '', maxLines: 2),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(child: Container(),),
                                  SizedBox(height: 10),
                                ],
                              ),

                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
