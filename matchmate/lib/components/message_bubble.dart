import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({
    required this.sender,
    required this.text,
    required this.isMe,
    required this.messageId,
    required this.deleteMessage,
  });

  late final String sender;
  late final String text;
  late final bool isMe;
  final String messageId;
  final VoidCallback deleteMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onLongPress: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    title: Center(
                      child: Text(
                        'Delete Message',
                        style: TextStyle(color: kColor2),
                      ),
                    ),
                    content: Text(
                      "Are you sure you want to delete this message?",
                      style: textStyle,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: kColor1, fontSize: 15),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          deleteMessage();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Delete",
                          style: TextStyle(color: kColor1, fontSize: 15),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            child: Material(
              borderRadius: isMe
                  ? BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))
                  : BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
              elevation: 5.0,
              color: isMe ? kColor4 : kColor5,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: text.contains(
                        'https://firebasestorage.googleapis.com/v0/b/matchmate-cpbio8292.appspot.com')
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          text,
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.width * 0.5,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Text(
                        text,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
