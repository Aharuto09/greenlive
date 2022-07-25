import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:mp_tubes/home.dart';
import 'package:mp_tubes/regist.dart';

void dialogalert(BuildContext context, String Title) {
  showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            //title: Text("Registrasi Gagal"),

            content: Container(
              //color: Colors.blue,
              height: 225,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Typicons.warning_empty,
                      size: 50,
                      color: Colors.yellow,
                    ),
                    Spacer(),
                    Text("Opss!",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(Title + "\nPlease Try Again",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: Colors.black)),
                    Spacer(),
                    Container(
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("TRY AGAIN"),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.yellow,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5),
                            )),
                      ),
                    )
                  ]),
            ),
          ));
}

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Future<void> _cekdata(String username, String pass) async {
      late DatabaseReference refUser =
          FirebaseDatabase.instance.ref().child("User");
      final passU = await refUser.child(username).get();
      if (passU.exists) {
        if (((passU.value as dynamic)["pass"]).toString() == pass) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(
                        userSnapshot: passU,
                      )));
        } else {
          dialogalert(context, "Username or Password Not Valid");
        }
      } else {
        dialogalert(context, "Username or Password Not Valid");
      }
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(300),
                  bottomRight: Radius.circular(300),
                ),
                child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            alignment: Alignment.topCenter,
                            image: AssetImage("assets/images/bg1.jpg"),
                            fit: BoxFit.cover))),
              )),
          Container(
            padding: EdgeInsets.all(70),
            child: Column(
              children: [
                Text(
                  "LOGIN",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: username,
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.person), label: Text("Username")),
                ),
                TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.lock), label: Text("Password")),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                        onPressed: () {
                          if (username.text.isNotEmpty &&
                              password.text.isNotEmpty) {
                            _cekdata(username.text, password.text);
                          } else {
                            dialogalert(
                                context, "Username or Password is Empty");
                          }
                        },
                        child: Text("Login"))),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                        onPressed: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return RegistPage();
                              });
                        },
                        child: Text("Sign Up"))),
              ],
            ),
          )
        ],
      ),
    );
  }
}
