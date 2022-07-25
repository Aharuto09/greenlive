import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';

import 'package:mp_tubes/allProduct.dart';
import 'package:mp_tubes/checkOut.dart';
import 'package:mp_tubes/history.dart';

import 'package:mp_tubes/item.dart';
import 'package:mp_tubes/login.dart';
import 'package:mp_tubes/main.dart';
import 'package:mp_tubes/category.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.userSnapshot}) : super(key: key);
  DataSnapshot userSnapshot;
  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> with SingleTickerProviderStateMixin {
  late DatabaseReference highlightRef =
      FirebaseDatabase.instance.ref().child("Highlight");
  late DatabaseReference productRef =
      FirebaseDatabase.instance.ref().child("Product");
  late final TabController _tabController = TabController(
    vsync: this,
    initialIndex: 1,
    length: 3,
  );
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    Future<void> logout() async {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => AlertDialog(
                content: Text("Are you sure ?"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel")),
                  TextButton(
                      onPressed: () {
                        shoppingchart.clear();
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text("Yes")),
                ],
              ));
    }

    Future<bool> cekData(String key) async {
      final cekHighlight = await highlightRef.child(key).get();
      if (cekHighlight.exists) {
        return true;
      } else {
        return false;
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xfff1f1f1),
      drawer: Container(
        width: 300,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.horizontal(right: Radius.circular(20))),
        child: Column(
          children: [
            DrawerHeader(
                child: CircleAvatar(
              maxRadius: 100,
              child: Icon(
                Icons.person,
                size: 70,
                color: Colors.black26,
              ),
            )),
            Text(
              widget.userSnapshot.key.toString(),
              style: TextStyle(fontSize: 24, fontFamily: "Montserrat_Bold"),
            ),
            SizedBox(height: 5),
            Text((widget.userSnapshot.value as dynamic)["email"],
                style:
                    TextStyle(fontSize: 12, fontFamily: "Montserrat_Regular")),
            Spacer(),
            TextButton(
                onPressed: () {
                  logout();
                },
                child: Row(
                  children: [Text("Logout "), Icon(Icons.logout)],
                ))
          ],
        ),
      ),
      appBar: AppBar(
        leading: RawMaterialButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            padding: EdgeInsets.all(5.0),
            shape: CircleBorder(),
            child: Icon(
              Icons.menu,
              color: Colors.black38,
            )),
        //automaticallyImplyLeading: false,
        centerTitle: true,
        shadowColor: Colors.black12,
        backgroundColor: Colors.white,
        title: Text(
          "Greenlive",
          style: TextStyle(
              //fontSize: 24,
              fontFamily: "Montserrat_Bold",
              color: Colors.lightGreen),
        ),
        actions: [
          RawMaterialButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => cekOutPage(
                            userSnapshot: widget.userSnapshot,
                          ))),
              padding: EdgeInsets.all(5.0),
              shape: CircleBorder(),
              child: Icon(
                Icons.shopping_cart,
                color: Colors.black26,
              ))
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          allProduct(),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(blurRadius: 12, color: Colors.black12)
                      ],
                      image: DecorationImage(
                          image: AssetImage("assets/images/gl bg.png"),
                          fit: BoxFit.cover)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Welcome to",
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: "Montserrat_Bold",
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Greenlive Explore",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Montserrat_SemiBold",
                        color: Colors.black45),
                  ),
                ),
                Container(
                  height: 320,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: FirebaseAnimatedList(
                    scrollDirection: Axis.horizontal,
                    query: highlightRef,
                    itemBuilder: (context, snapshot, animation, index) {
                      return item(productKey: snapshot.key.toString());
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Category",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Montserrat_Bold",
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => categoryPage(
                                      categoryText: "Outdoor",
                                    ))),
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            // padding: EdgeInsets.all(30),
                            alignment: Alignment.center,
                            width: 100,
                            height: 50,
                            child: Text(
                              "Outdoor",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "Montserrat_Bold",
                                  color: Colors.lightGreen),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 12, color: Colors.black12)
                                ])),
                      ),
                      SizedBox(width: 20),
                      InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => categoryPage(
                                      categoryText: "Indoor",
                                    ))),
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            // padding: EdgeInsets.all(30),
                            alignment: Alignment.center,
                            width: 100,
                            height: 50,
                            child: Text(
                              "Indoor",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "Montserrat_Bold",
                                  color: Colors.lightGreen),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 12, color: Colors.black12)
                                ])),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          historyPage(usersnapshot: widget.userSnapshot)
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: Duration(milliseconds: 300),
        index: 1,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.lightGreen,
        items: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Entypo.leaf,
              size: 30,
              color: Colors.black45,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.home, size: 30, color: Colors.black45),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.shopping_bag,
              size: 30,
              color: Colors.black45,
            ),
          ),
        ],
        onTap: (index) {
          //Handle button tap
          _tabController.index = index;
        },
      ),
    );
  }
}
