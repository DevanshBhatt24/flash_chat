import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/constants.dart';
import 'package:flutter_chat/screens/chat_screen.dart';
import 'package:flutter_chat/screens/padd.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '4';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String? email;
  String? pass;
  bool spinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 100,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                  style: TextStyle(color: Colors.black),
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                    //Do something with the user input.
                  },
                  decoration:
                      ktextdecotation.copyWith(hintText: "Enter your email")),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  style: TextStyle(color: Colors.black),
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    pass = value;
                    //Do something with the user input.
                  },
                  decoration: ktextdecotation.copyWith(
                    hintText: "Enter your password",
                  )),
              SizedBox(
                height: 24.0,
              ),
              padding(
                  colors: Colors.blue,
                  text: 'Login',
                  pressed: () async {
                    setState(() {
                      spinner = true;
                    });
                    try {
                      final existinguser =
                          await _auth.signInWithEmailAndPassword(
                              email: email!, password: pass!);
                      if (existinguser != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                      setState(() {
                        spinner = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
