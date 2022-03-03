import 'package:flutter/material.dart';
import 'package:flutter_chat/screens/login_screen.dart';
import 'package:flutter_chat/screens/padd.dart';
import 'package:flutter_chat/screens/registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = '1';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? animate;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      upperBound: 80,
    );

    controller!.forward();
    controller!.addListener(() {
      setState(() {});
      print(controller!.value);
    });
  }

  void dispose() {
    controller!.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: "logo",
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: controller!.value,
                  ),
                ),
                Flexible(
                  child: TypewriterAnimatedTextKit(
                    text: [
                      'Flash Chat',
                    ],
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            padding(
                colors: Colors.blue,
                text: 'Log In',
                pressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                }),
            padding(
                colors: Colors.blueAccent,
                text: 'Register',
                pressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                })
          ],
        ),
      ),
    );
  }
}
