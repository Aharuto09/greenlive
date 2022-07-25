import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mp_tubes/detailItem.dart';

class item extends StatefulWidget {
  item({Key? key, required this.productKey}) : super(key: key);
  String productKey;
  @override
  State<item> createState() => _itemState();
}

class _itemState extends State<item> {
  late DatabaseReference productRef =
      FirebaseDatabase.instance.ref().child("Product");
  final storageRef = FirebaseStorage.instance.ref();

  @override
  Widget build(BuildContext context) {
    String storageUrl = "";
    Future<void> getImage() async {
      final imageUrl =
          await storageRef.child(widget.productKey).getDownloadURL();
    }

    return Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        width: 220,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12)]),
        child: FutureBuilder(
          future: productRef.child(widget.productKey).get(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => detailItem(
                                detailSnapshot: snapshot.data,
                                storageUrl: storageUrl,
                              )));
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(blurRadius: 12, color: Colors.black12)
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 200,
                          margin: EdgeInsets.all(12),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color(0xfff1f1f1)),
                          child: FutureBuilder(
                              future: storageRef
                                  .child("Image/${widget.productKey}.png")
                                  .getDownloadURL(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  storageUrl = snapshot.data.toString();
                                  return Image.network(
                                    snapshot.data.toString(),
                                  );
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                return Image.asset(
                                  "assets/images/plant1.png",
                                );
                              }),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                    child: Text(
                                  snapshot.data.key.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: "Montserrat_Bold",
                                  ),
                                )),
                              ),
                              Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.lightGreen,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Text(
                                    (snapshot.data.value as dynamic)["jenis"],
                                    style: TextStyle(
                                        fontFamily: "Montserrat_Regular",
                                        fontSize: 10,
                                        color: Colors.white),
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(height: 2),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                              "IDR " +
                                  ((snapshot.data.value as dynamic)["harga"])
                                      .toString(),
                              style: TextStyle(
                                fontFamily: "Montserrat_Regular",
                                color: Colors.lightGreen,
                              )),
                        )
                      ],
                    )),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return Center(child: Text("Error"));
          },
        ));
  }
}
