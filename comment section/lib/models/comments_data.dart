// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';


//-----Comment model-----------------//
class Comment {
  late final String date;
  late final String firstName;
  late final int like;
  late final int disLike;
  late final String reply;
  late final String message;

  Comment({
    required this.date,
    required this.firstName,
    required this.like,
    required this.disLike,
    required this.reply,
    required this.message,
  });

  // Comment copyWith({
  //   String? date,
  //   String? firstName,
  //   Bool? like,
  //   Bool? disLike,
  //   String? isReply,
  //   String? message,
  // }) {
  //   return Comment(
  //     date: date ?? this.date,
  //     firstName: firstName ?? this.firstName,
  //     like: like ?? this.like,
  //     disLike: disLike ?? this.disLike,
  //     isReply: isReply ?? this.isReply,
  //     message: message ?? this.message,
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'date': date.toMap(),
  //     'firstName': firstName.toMap(),
  //     'like': like.toMap(),
  //     'disLike': disLike.toMap(),
  //     'isReply': isReply.toMap(),
  //     'message': message.toMap(),
  //   };
  // }

  // factory comment.fromMap(Map<String, dynamic> map) {
  //   return comment(
  //     date: late String.fromMap(map['date'] as Map<String,dynamic>),
  //     firstName: late String.fromMap(map['firstName'] as Map<String,dynamic>),
  //     like: late Bool.fromMap(map['like'] as Map<String,dynamic>),
  //     disLike: late Bool.fromMap(map['disLike'] as Map<String,dynamic>),
  //     isReply: late String.fromMap(map['isReply'] as Map<String,dynamic>),
  //     message: late String.fromMap(map['message'] as Map<String,dynamic>),
  //   );
  // }

//   String toJson() => json.encode(toMap());

//   factory comment.fromJson(String source) => comment.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() {
//     return 'comment(date: $date, firstName: $firstName, like: $like, disLike: $disLike, isReply: $isReply, message: $message)';
//   }

//   @override
//   bool operator ==(covariant comment other) {
//     if (identical(this, other)) return true;

//     return
//       other.date == date &&
//       other.firstName == firstName &&
//       other.like == like &&
//       other.disLike == disLike &&
//       other.isReply == isReply &&
//       other.message == message;
//   }

//   @override
//   int get hashCode {
//     return date.hashCode ^
//       firstName.hashCode ^
//       like.hashCode ^
//       disLike.hashCode ^
//       isReply.hashCode ^
//       message.hashCode;
//   }
// }
}

// var comment1 = comm{
//   date: '',
//   'firstName': "Naol",
//   'islike': true,
//   'dislike': false,
//   'isReply': true,
//   'msg': "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis bibendum, odio semper placerat efficitur, augue nibh dictum lectus, at ultricies justo dolor non orci.",
// };

//------------test data--------------------

List<Comment> comments = [
  Comment(
    date: "27/01/2022 at 04:30",
    firstName: "Naol",
    like: 5,
    disLike: 7,
    reply: '5',
    message:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis bibendum, odio semper placerat efficitur, augue nibh dictum lectus, at ultricies justo dolor non orci.",
  ),
  Comment(
    date: "12/06/2020 at 12:30",
    firstName: "Naol",
    like: 6,
    disLike: 9,
    reply: '5',
    message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis.",
  ),
  Comment(
    date: "27/01/2022 at 04:30",
    firstName: "Naol",
    like: 7,
    disLike: 0,
    reply: '5',
    message:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis bibendum, odio semper placerat efficitur, augue nibh dictum lectus, at ultricies justo dolor non orci.",
  ),
  Comment(
    date: "27/01/2022 at 04:30",
    firstName: "Naol",
    like: 8,
    disLike: 1,
    reply: '5',
    message:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis bibendum, odio semper placerat efficitur, augue nibh dictum lectus, at ultricies justo dolor non orci.",
  ),
  Comment(
    date: "12/06/2020 at 12:30",
    firstName: "Naol",
    like: 6,
    disLike: 9,
    reply: '5',
    message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis.",
  ),
  Comment(
    date: "12/06/2020 at 12:30",
    firstName: "Naol",
    like: 6,
    disLike: 9,
    reply: '5',
    message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis.",
  ),
  Comment(
    date: "27/01/2022 at 04:30",
    firstName: "Naol",
    like: 1,
    disLike: 3,
    reply: '5',
    message:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis bibendum, odio semper placerat efficitur, augue nibh dictum lectus, at ultricies justo dolor non orci.",
  ),
];
