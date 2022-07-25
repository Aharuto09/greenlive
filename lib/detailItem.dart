import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:mp_tubes/main.dart';

class detailItem extends StatefulWidget {
  detailItem({Key? key, required this.detailSnapshot, required this.storageUrl})
      : super(key: key);
  DataSnapshot detailSnapshot;
  String storageUrl;
  @override
  State<detailItem> createState() => _detailItemState();
}

class _detailItemState extends State<detailItem> {
  int _jml = 1;
  @override
  Widget build(BuildContext context) {
    bool UrlNull = true;
    if (widget.storageUrl == "") {
      UrlNull = true;
    } else {
      UrlNull = false;
    }

    void _incrementCounter() {
      setState(() {
        if (_jml < (widget.detailSnapshot.value as dynamic)["jumlah"]) {
          _jml++;
        }
      });
    }

    void _decrementCounter() {
      setState(() {
        if (_jml > 1) {
          _jml--;
        }
      });
    }

    return Scaffold(
      backgroundColor: Color(0xfff4f6f0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black38,
            )),
        title: Text(
          widget.detailSnapshot.key.toString(),
          style: TextStyle(
              fontFamily: "Montserrat_Bold",
              // fontSize: 20,
              color: Colors.lightGreen),
        ),
        centerTitle: true,
      ),
      //backgroundColor: Color(0xfff1f1f1),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                height: 470,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(blurRadius: 12, color: Colors.black12)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.all(10),
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                            color: Color(0xfff1f1f1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: UrlNull
                              ? Icon(
                                  Icons.image,
                                  size: 70,
                                  color: Colors.black12,
                                )
                              : Image.network(widget.storageUrl)),
                      SizedBox(height: 20),
                      Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.lightGreen,
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(
                            (widget.detailSnapshot.value as dynamic)["jenis"],
                            style: TextStyle(
                                fontFamily: "Montserrat_Regular",
                                fontSize: 12,
                                color: Colors.white),
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                child: Text(
                                  widget.detailSnapshot.key.toString(),
                                  maxLines: 3,
                                  style: TextStyle(
                                      fontFamily: "Montserrat_Bold",
                                      fontSize: 24),
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 30,
                              decoration: BoxDecoration(
                                  //color: Color(0xfff1f1f1),
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      width: 1, color: Colors.lightGreen)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                      onTap: _decrementCounter,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.lightGreen,
                                              borderRadius:
                                                  BorderRadius.horizontal(
                                                      left:
                                                          Radius.circular(50))),
                                          padding: EdgeInsets.all(2),
                                          child: Icon(Icons.remove))),
                                  Spacer(),
                                  Text("$_jml"),
                                  Spacer(),
                                  InkWell(
                                      onTap: _incrementCounter,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.lightGreen,
                                              borderRadius:
                                                  BorderRadius.horizontal(
                                                      right:
                                                          Radius.circular(50))),
                                          padding: EdgeInsets.all(2),
                                          child: Icon(Icons.add))),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Text(
                          "IDR " +
                              ((widget.detailSnapshot.value
                                      as dynamic)["harga"])
                                  .toString(),
                          style: TextStyle(
                              color: Colors.lightGreen,
                              fontFamily: "Montserrat_Bold",
                              fontSize: 16)),
                    ]),
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10, top: 10, bottom: 20),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(blurRadius: 12, color: Colors.black12)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      Iconic.sun_inv,
                      size: 20,
                      color: Colors.lightGreen,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10, top: 10, bottom: 20),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(blurRadius: 12, color: Colors.black12)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      RpgAwesome.water_drop,
                      size: 20,
                      color: Colors.lightGreen,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10, top: 10, bottom: 20),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(blurRadius: 12, color: Colors.black12)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      Typicons.temperatire,
                      size: 20,
                      color: Colors.lightGreen,
                    ),
                  ),
                ],
              ),
              Text(
                "Jumlah Produk : " +
                    ((widget.detailSnapshot.value as dynamic)["jumlah"])
                        .toString(),
                style: TextStyle(fontFamily: "Montserrat_Regular"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Details",
                  style: TextStyle(fontFamily: "Montserrat_Bold", fontSize: 18),
                ),
              ),
              Text(
                (widget.detailSnapshot.value as dynamic)["deskripsi"],
                style: TextStyle(fontFamily: "Montserrat_Regular"),
              ),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
          margin: EdgeInsets.only(left: 30),
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              onPressed: () {
                shoppingchart.add(Order(
                  Nama: widget.detailSnapshot.key.toString() + " x$_jml",
                  TotalPrice:
                      ((widget.detailSnapshot.value as dynamic)["harga"]) *
                          _jml,
                ));
                Navigator.pop(context);
              },
              child: Text("Add to cart"))),
    );
  }
}
