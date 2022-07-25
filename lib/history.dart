import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';

class historyPage extends StatefulWidget {
  historyPage({Key? key, required this.usersnapshot}) : super(key: key);
  DataSnapshot usersnapshot;
  @override
  State<historyPage> createState() => historyState();
}

class historyState extends State<historyPage> {
  late DatabaseReference userRef =
      FirebaseDatabase.instance.ref().child("User");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1f1f1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Order History",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Montserrat_Bold",
                  color: Colors.black),
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            child: Container(
              child: FirebaseAnimatedList(
                  query: userRef
                      .child(widget.usersnapshot.key.toString() + "/Order"),
                  itemBuilder: (context, snapshot, animation, index) {
                    // print(snapshot.value.toString());
                    return Container(
                      width: double.infinity,
                      height: 100,
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(blurRadius: 12, color: Colors.black12)
                          ]),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                margin: EdgeInsets.all(10),
                                height: double.infinity,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Color(0xfff1f1f1)),
                                child: Icon(
                                  Entypo.leaf,
                                  size: 30,
                                  color: Colors.lightGreen,
                                )),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ((snapshot.value as dynamic)["detail"]),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Montserrat_Bold",
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                        "IDR " +
                                            ((snapshot.value
                                                    as dynamic)["total harga"])
                                                .toString(),
                                        style: TextStyle(
                                          fontFamily: "Montserrat_Regular",
                                          fontSize: 16,
                                          color: Colors.lightGreen,
                                        )),
                                    SizedBox(height: 5),
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 3, horizontal: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.lightGreen,
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Text(
                                          (snapshot.value as dynamic)["status"],
                                          style: TextStyle(
                                              fontFamily: "Montserrat_Regular",
                                              fontSize: 12,
                                              color: Colors.white),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 10)
                          ]),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
