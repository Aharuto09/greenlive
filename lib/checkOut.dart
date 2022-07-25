import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:mp_tubes/main.dart';

class cekOutPage extends StatefulWidget {
  cekOutPage({Key? key, required this.userSnapshot}) : super(key: key);
  DataSnapshot userSnapshot;
  @override
  State<cekOutPage> createState() => _cekOutState();
}

class _cekOutState extends State<cekOutPage> {
  final animatedListKey = GlobalKey<AnimatedListState>();
  TextEditingController address = TextEditingController();
  @override
  Widget build(BuildContext context) {
    int totalPrice = 0;
    for (var i = 0; i < shoppingchart.length; i++) {
      totalPrice += shoppingchart[i].TotalPrice;
    }
    void showSnackbar(String title) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 2),
          backgroundColor: Colors.lightGreen,
          content: Text(
            title,
            style: TextStyle(color: Colors.black),
          )));
    }

    Future<void> addOrder(BuildContext context) async {
      // String orderlenght =
      //     widget.userSnapshot.child("Order").children.length.toString();
      // print(orderlenght);
      String detailOrder = "";
      for (var element in shoppingchart) {
        detailOrder += element.Nama + ", ";
      }
      final day = DateTime.now().day;
      final mon = DateTime.now().month;
      final hour = DateTime.now().hour;
      final minute = DateTime.now().minute;
      final second = DateTime.now().second;
      return widget.userSnapshot.ref
          .child("Order")
          .child("$day" + "-" + "$mon" + "-" + "$hour" + "$minute" + "$second")
          .set({
        "address": address.text,
        "detail": detailOrder,
        "total harga": totalPrice,
        "status": "On Process"
      }).then((value) {
        print("Order Added");
        Navigator.pop(context);
        shoppingchart.clear();
        Navigator.pop(context);
      });
    }

    return Scaffold(
      backgroundColor: Color(0xfff4f6f0),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        title: Text(
          "Shopping Cart",
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
      body: Container(
          margin: EdgeInsets.only(top: 20),
          child: AnimatedList(
              key: animatedListKey,
              initialItemCount: shoppingchart.length,
              itemBuilder: (context, index, animation) => Container(
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
                                    shoppingchart[index].Nama,
                                    maxLines: 3,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Montserrat_Bold",
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                      "IDR " +
                                          shoppingchart[index]
                                              .TotalPrice
                                              .toString(),
                                      style: TextStyle(
                                        fontFamily: "Montserrat_Regular",
                                        color: Colors.lightGreen,
                                      )),
                                ]),
                          ),
                        ),
                        IconButton(
                            color: Colors.lightGreen,
                            onPressed: () {
                              shoppingchart.removeAt(index);
                              setState(() {
                                for (var i = 0; i < shoppingchart.length; i++) {
                                  totalPrice += shoppingchart[i].TotalPrice;
                                }
                              });
                              animatedListKey.currentState?.removeItem(index,
                                  (context, animation) {
                                return SlideTransition(
                                    position: Tween<Offset>(
                                  begin: const Offset(-1, 0),
                                  end: Offset(0, 0),
                                ).animate(animation));
                              });
                            },
                            icon: Icon(Icons.remove)),
                        SizedBox(width: 15),
                      ])))),
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Text(
                  "Total : ",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Montserrat_Bold",
                  ),
                ),
                Spacer(),
                Text(
                  totalPrice.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Montserrat_Bold",
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onPressed: () {
                      if (shoppingchart.isEmpty) {
                        showSnackbar("Your Shopping Cart is Empty");
                      } else {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return Container(
                                padding: EdgeInsets.all(20),
                                height: 200,
                                width: double.infinity,
                                color: Colors.white,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Add Your Address",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextField(
                                        controller: address,
                                        decoration: InputDecoration(
                                            suffixIcon: Icon(Icons.person),
                                            label: Text("Address")),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                          width: double.infinity,
                                          height: 50,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30))),
                                            onPressed: () {
                                              if (address.text.isNotEmpty) {
                                                addOrder(context);
                                              } else {
                                                Navigator.pop(context);
                                                showSnackbar(
                                                    "Please Add Your Address");
                                              }
                                            },
                                            child: Text("Order Now"),
                                          ))
                                    ]),
                              );
                            });
                      }
                    },
                    child: Text("Order Now"))),
          ],
        ),
      ),
    );
  }
}
