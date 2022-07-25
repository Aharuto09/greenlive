import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mp_tubes/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDFGBIUrUEdqW1KFr9wbqZH3F_okbxVt_Q",
          authDomain: "greenlive-mobile.firebaseapp.com",
          databaseURL:
              "https://greenlive-mobile-default-rtdb.asia-southeast1.firebasedatabase.app/",
          projectId: "greenlive-mobile",
          storageBucket: "greenlive-mobile.appspot.com",
          messagingSenderId: "664734019644",
          appId: "1:664734019644:web:01b35e57e9e48162039339",
          measurementId: "G-PP5MJGNHLR"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Greenlive',
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: LoginPage(),
    );
  }
}

class Order {
  String Nama;
  int TotalPrice;
  Order({required this.Nama, required this.TotalPrice});
}

List<Order> shoppingchart = [];
