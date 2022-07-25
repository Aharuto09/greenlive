import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mp_tubes/item.dart';

class categoryPage extends StatefulWidget {
  categoryPage({Key? key, required this.categoryText}) : super(key: key);
  String categoryText;
  @override
  State<categoryPage> createState() => categoryState();
}

class categoryState extends State<categoryPage> {
  late DatabaseReference productRef =
      FirebaseDatabase.instance.ref().child("Product");
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xfff1f1f1),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        title: Text(
          "Product " + widget.categoryText,
          style: TextStyle(
              fontFamily: "Montserrat_Bold",
              // fontSize: 20,
              color: Colors.lightGreen),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black38,
            )),
      ),
      body: FirebaseAnimatedList(
        query:
            productRef.ref.orderByChild("jenis").equalTo(widget.categoryText),
        padding: EdgeInsets.only(top: 20),
        itemBuilder: (context, snapshot, animation, index) {
          return Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              height: 300,
              child: item(productKey: snapshot.key.toString()));
        },
      ),
    );
  }
}
