import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mp_tubes/home.dart';

class RegistPage extends StatefulWidget {
  RegistPage({Key? key}) : super(key: key);
  @override
  State<RegistPage> createState() => _RegistState();
}

class _RegistState extends State<RegistPage> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController telp = TextEditingController();
  TextEditingController pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    void dialogalert() {
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
                          Icons.warning,
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
                        Text("Username Already Exists\nPlease Try Another One",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 14, color: Colors.black)),
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
                                  borderRadius: new BorderRadius.circular(30.0),
                                )),
                          ),
                        )
                      ]),
                ),
              ));
    }

    Future<void> createUser() async {
      late DatabaseReference ref = FirebaseDatabase.instance.ref("User");
      // Call the Users's CollectionReference to add a new user

      return ref.child(username.text).set({
        "email": email.text,
        "pass": pass.text,
        "telp": telp.text,
        "date": DateTime.now().toString()
      }).then((value) {
        print("User Added");
        username.clear();
        email.clear();
        pass.clear();
        telp.clear();
      }).catchError((error) => dialogalert());
    }

    return Container(
      padding: EdgeInsets.all(80),
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40))),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Text(
            "Create An Account",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: username,
            decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.person,
                  color: Colors.lightGreen,
                ),
                label: Text("Username")),
          ),
          TextField(
            controller: email,
            decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.email,
                  color: Colors.lightGreen,
                ),
                label: Text("Email")),
          ),
          TextField(
            controller: telp,
            decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.phone,
                  color: Colors.lightGreen,
                ),
                label: Text("Phone Number")),
          ),
          TextField(
            controller: pass,
            decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.lock,
                  color: Colors.lightGreen,
                ),
                label: Text("Password")),
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
                    if (username.text.isEmpty ||
                        email.text.isEmpty ||
                        pass.text.isEmpty ||
                        telp.text.isEmpty) {
                      dialogalert();
                    } else {
                      createUser().then((value) => Navigator.pop(context));
                    }
                  },
                  child: Text("Sign Up"))),
        ],
      ),
    );
  }
}
