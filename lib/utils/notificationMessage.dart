import 'package:flutter/cupertino.dart';

class Message {
  String name;
  String message;
  Message({required this.name, required this.message});
}

String finishedCourse = "Congratualtions, You have finished";
String questionReply = "has replied to your question on the forum";
String quiz = "You have a quiz on";
String newCourse = "New course has been launched";

List<Message> notifMessages = [
  Message(
      name: "finishedCourse", message: "Congratualtions, You have finished"),
  Message(
      name: "questionReply",
      message: "has replied to your question on the forum"),
  Message(name: "quiz", message: "You have a quiz on"),
  Message(name: "newCourse", message: "New course has been launched"),
];
