import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mp_tubes/item.dart';

class allProduct extends StatelessWidget {
  late DatabaseReference productRef =
      FirebaseDatabase.instance.ref().child("Product");
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
            child: Text(
              "All Product",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Montserrat_Bold",
                  color: Colors.black),
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: 300,
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: FirebaseAnimatedList(
                scrollDirection: Axis.vertical,
                query: productRef,
                itemBuilder: (context, snapshot, animation, index) => Container(
                  height: 300,
                  child: item(
                    productKey: snapshot.key.toString(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
