import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class messagebubble extends StatelessWidget {
  final message;
  final sender;
  final bool isme;
  final Timestamp? time;
  messagebubble({this.message, this.sender, required this.isme, this.time});

  @override
  Widget build(BuildContext context) {
    var date =
        DateTime.fromMillisecondsSinceEpoch(time!.millisecondsSinceEpoch);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            "$sender",
            style: TextStyle(color: Colors.black54, fontSize: 12),
          ),
          Material(
            borderRadius: isme
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
            elevation: 5,
            color: isme ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                message,
                style: TextStyle(
                    fontSize: 15, color: isme ? Colors.white : Colors.black),
              ),
            ),
          )
        ],
      ),
    );
  }
}
