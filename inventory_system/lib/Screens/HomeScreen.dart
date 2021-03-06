import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:inventory_system/Screens/CategoryScreen.dart';
import 'package:inventory_system/Screens/InvoiceListScreen.dart';
import 'package:inventory_system/Screens/ItemDetailScreen.dart';
import 'package:inventory_system/Screens/LoginScreen.dart';
import 'package:inventory_system/Screens/OrderListScreen.dart';
import 'package:inventory_system/Screens/SearchItemScreen.dart';
import 'package:inventory_system/Screens/SideMenuDrawer.dart';
import 'package:inventory_system/Screens/SubCategoryScreen.dart';
import 'package:inventory_system/Utilities/ColorUtil.dart';
import 'package:inventory_system/Utilities/ImageUtil.dart';
import 'package:inventory_system/Utilities/constants.dart';
import 'package:inventory_system/component/CartButton.dart';
import 'package:inventory_system/component/CustomPopup.dart';
import 'package:inventory_system/component/LoadingSmall.dart';
import 'package:inventory_system/component/NoDataFoundContainer.dart';
import 'package:inventory_system/data/models/CategoryModel.dart';
import 'package:inventory_system/data/models/InvoiceModel.dart';
import 'package:inventory_system/data/models/UserModel.dart';
import 'package:inventory_system/data/models/res/ResGetCategoryList.dart';
import 'package:inventory_system/services/CartService.dart';
import 'package:inventory_system/services/userPreferencesService.dart';
import 'package:inventory_system/services/webService.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;

  List<ResGetCategoryList> resList;

  List<ResGetCategoryList> searchedList;

  int totalCartItem;

  updateCount() async {
    var cart = await CartService.getCarts();
    if(cart != null){
      setState(() {
        totalCartItem = cart.cart.length ?? 0;
      });
    }else{
      setState(() {
        totalCartItem = 0;
      });
    }
  }

  double totalOutStandings;

  getInitialData(){
    UserModel.getProfileDetails(completion: (res) async {
    });

    UserModel.updateFCM();

    InvoiceModel.getTotalOutStandings(completion: (res){

      if(res.state == Status.COMPLETED){
        setState(() {
          totalOutStandings = res.data.data.totalOutStanding ?? 0.0;
        });
      }
    });

    CategoryModel.getCategoryList(completion: (res,isAuth) {

      if(!isAuth){
        CustomPopup(context, title: 'Sorry', message: res.msg ?? "Error", primaryBtnTxt: 'Re Try',primaryAction: (){
          UserPreferencesService().removeUser();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => LoginScreen()),
                  (route) => false);
        });
        return;
      }

      switch (res.state) {
        case Status.LOADING:
          setState(() {
            isLoading = true;
          });
          break;
        case Status.COMPLETED:
          setState(() {
            isLoading = false;
            resList = res.data.data.list;
            searchedList = resList;
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
  void initState() {
    // TODO: implement initState
    super.initState();
    updateCount();
    getInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      //Turn this on to stop the android and ios back gesture
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          elevation: 0.0,
          actions: [
              CartForAll(totalCart: totalCartItem ?? 0,callBack: (){
                updateCount();
              },)
          ],
        ),
        drawer: getDrawer(context),
        body: buildContainer(context),
      ),
    );
  }

  Widget buildContainer(BuildContext context) {
    final size = MediaQuery.of(context).size;

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

    if (resList == null || resList.length <= 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NoDataFoundContainer(),
            SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: ColorUtil.primoryColor,width: 1),
                borderRadius: BorderRadius.circular(10)
              ),
              child: InkWell(onTap: (){
                getInitialData();
              }, child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                child: Text('Retry',style: TextStyle(
                  color: ColorUtil.primoryColor
                )),
              )),
            )
          ],
        ),
      );
    }

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => InvoiceListScreen()));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderListScreen()));

            },
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                color: ColorUtil.buttonColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "Total OutStanding (${totalOutStandings ?? 0})",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 15,
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(10.0)
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchItemsScreen(),fullscreenDialog: true)).then((value) {
                        updateCount();
                      });
                    },
                    child: TextField(
                      textInputAction: TextInputAction.search,

                      enabled: false,
                      onSubmitted: (text) async {
                        return;
                        // await CategoryModel.getItemID(completion: (res){
                        //
                        //   if(res.state == Status.COMPLETED){
                        //
                        //     try{
                        //       var data = res.data.data;
                        //
                        //       var first = data.list.first;
                        //
                        //       Navigator.push(context, MaterialPageRoute(builder: (context) => ItemDetailScreen(index: 0,itemDetail: first,))).then((value) {
                        //         print('cool');
                        //         updateCount();
                        //       });
                        //
                        //     }catch(e){
                        //       print(e);
                        //     }
                        //   }
                        //
                        // },text: text);



                      },
                      onChanged: (text) {

                        return;

                        print(text);

                        var cool = resList.where((element) => element.name.toLowerCase().contains(text.toLowerCase())).toList();

                        setState(() {
                          searchedList = cool;
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Search',
                      ),
                    ),
                  ),
                ),
                Icon(Icons.search)
              ],
            ),
          ),
          Expanded(
            flex: 10,
            child: searchedList.length <= 0 ? NoDataFoundContainer() : Container(
                padding: EdgeInsets.all(5),
                child: GridView.count(
                  // Create a grid with 2 columns. If you change the scrollDirection to
                  // horizontal, this produces 2 rows.
                  crossAxisCount: size.width > 500 ? 4 : 2,
                  childAspectRatio: 0.9,
                  // Generate 100 widgets that display their index in the List.
                  children: List.generate(searchedList.length, (index) {
                    final data = searchedList[index];
                    return Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: ColorUtil.primoryColor,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: ColorUtil.primoryColor,width: 1.5)
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoryScreen(
                                        categoryId: data.categoryid,
                                        categoryName: data.name ?? "",
                                      ))).then((value) {
                            updateCount();
                          });
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Expanded(
                                flex:2,
                                child: Container(
                                  width: double.infinity,
                                  color: Colors.white,
                                  child: data.imageUrl == null ? Image.asset('Assets/Images/placeholder.png',fit: BoxFit.cover,) : ImageUtil.fadeInImage( kImgUrl + data.imageUrl ?? "https://socialistmodernism.com/wp-content/uploads/2017/07/placeholder-image.png", 'Assets/Images/placeholder.png'),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Text(data.name ?? "",style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14
                                        ),
                                          maxLines: 2,softWrap: true,),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                )),
          ),
        ],
      ),
    );
  }
}
