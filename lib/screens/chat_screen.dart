import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat/templates/textstyle.dart';

class ChatScreen extends StatefulWidget {
  static const String id = '2';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

User? loggedinuser;
final _clod = FirebaseFirestore.instance;

class _ChatScreenState extends State<ChatScreen> {
  final control = TextEditingController();
  String? message;
  final _aut = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    getcurrentuser();
  }

  void getcurrentuser() async {
    try {
      final user = await _aut.currentUser;
      if (user != null) {
        loggedinuser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.power_settings_new_rounded),
              onPressed: () async {
                await _aut.signOut();
                Navigator.pop(context);
                //Implement logout functionality
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            stremmessage(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: control,
                      style: TextStyle(color: Colors.black),
                      onChanged: (value) {
                        message = value;
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      control.clear();
                      _clod.collection('message').add({
                        'text': message,
                        'sender': loggedinuser!.email,
                        'time': DateTime.now()
                      });

                      //Implement send functionality.
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class stremmessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _clod.collection("message").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          final messages = snapshot.data!.docs;
          List<messagebubble> messagewidgets = [];
          for (var message in messages) {
            final messagetext = message.get("text");
            final sender = message.get('sender');
            final messageTime = message.get('time');
            final currentuser = loggedinuser!.email;

            final messagewidget = messagebubble(
                message: messagetext,
                sender: sender,
                isme: currentuser == sender,
                time: messageTime);
            messagewidgets.add(messagewidget);
            messagewidgets.sort((a, b) => b.time!.compareTo(a.time!));
          }

          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: messagewidgets,
            ),
          );
        });
  }
}
