// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

//-----Comment model-----------------//
class Comment {
  late final String date;
  late final String firstName;
  late final String imageUrl;
  late final int like;
  late final bool liked;
  late final int disLike;
  late final List<String> reply;
  late final String message;

  Comment({
    required this.date,
    required this.firstName,
    required this.imageUrl,
    required this.like,
    required this.liked,
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
class Com extends ChangeNotifier {
  List<Comment> comments = [
    Comment(
      date: "3",
      firstName: "Naol Girma",
      imageUrl: "assets/images/p1.jpg",
      like: 5,
      liked: true,
      disLike: 7,
      reply: [],
      message:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis bibendum, odio semper placerat efficitur, augue nibh dictum lectus, at ultricies justo dolor non orci.",
    ),
    Comment(
      date: "7",
      firstName: "Naol Girma",
      imageUrl: "assets/images/p1.jpg",
      like: 6,
      liked: false,
      disLike: 9,
      reply: [],
      message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis.",
    ),
    Comment(
      date: "5",
      firstName: "Naol Girma",
      imageUrl: "assets/images/p1.jpg",
      like: 7,
      liked: true,
      disLike: 0,
      reply: [],
      message:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis bibendum, odio semper placerat efficitur, augue nibh dictum lectus, at ultricies justo dolor non orci.",
    ),
    Comment(
      date: "8",
      firstName: "Naol Girma",
      imageUrl: "assets/images/p1.jpg",
      like: 8,
      liked: true,
      disLike: 1,
      reply: [],
      message:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis bibendum, odio semper placerat efficitur, augue nibh dictum lectus, at ultricies justo dolor non orci.",
    ),
    Comment(
      date: "9",
      firstName: "Naol Girma",
      imageUrl: "assets/images/p1.jpg",
      like: 6,
      liked: false,
      disLike: 9,
      reply: [],
      message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis.",
    ),
    Comment(
      date: "2",
      firstName: "Naol Girma",
      imageUrl: "assets/images/p1.jpg",
      like: 6,
      liked: false,
      disLike: 9,
      reply: [],
      message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis.",
    ),
    Comment(
      date: "1",
      firstName: "Naol Girma",
      imageUrl: "assets/images/p1.jpg",
      like: 1,
      liked: true,
      disLike: 3,
      reply: [],
      message:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis bibendum, odio semper placerat efficitur, augue nibh dictum lectus, at ultricies justo dolor non orci.",
    ),
  ];

  void addComment(Comment com) {
    comments.insert(0, com);
    notifyListeners();
  }

  void addReply(String reply, int index) {
    comments[index].reply.add(reply);
    notifyListeners();
  }

  void likeComment(int index) {
    comments[index].liked = !comments[index].liked;
    notifyListeners();
  }
}

List<Comment> comments = [
  Comment(
    date: "3",
    firstName: "Naol Girma",
    imageUrl: "assets/images/p1.jpg",
    like: 5,
    liked: true,
    disLike: 7,
    reply: [],
    message:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis bibendum, odio semper placerat efficitur, augue nibh dictum lectus, at ultricies justo dolor non orci.",
  ),
  Comment(
    date: "7",
    firstName: "Naol Girma",
    imageUrl: "assets/images/p1.jpg",
    like: 6,
    liked: false,
    disLike: 9,
    reply: [],
    message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis.",
  ),
  Comment(
    date: "5",
    firstName: "Naol Girma",
    imageUrl: "assets/images/p1.jpg",
    like: 7,
    liked: true,
    disLike: 0,
    reply: [],
    message:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis bibendum, odio semper placerat efficitur, augue nibh dictum lectus, at ultricies justo dolor non orci.",
  ),
  Comment(
    date: "8",
    firstName: "Naol Girma",
    imageUrl: "assets/images/p1.jpg",
    like: 8,
    liked: true,
    disLike: 1,
    reply: [],
    message:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis bibendum, odio semper placerat efficitur, augue nibh dictum lectus, at ultricies justo dolor non orci.",
  ),
  Comment(
    date: "9",
    firstName: "Naol Girma",
    imageUrl: "assets/images/p1.jpg",
    like: 6,
    liked: false,
    disLike: 9,
    reply: [],
    message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis.",
  ),
  Comment(
    date: "2",
    firstName: "Naol Girma",
    imageUrl: "assets/images/p1.jpg",
    like: 6,
    liked: false,
    disLike: 9,
    reply: [],
    message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis.",
  ),
  Comment(
    date: "1",
    firstName: "Naol Girma",
    imageUrl: "assets/images/p1.jpg",
    like: 1,
    liked: true,
    disLike: 3,
    reply: [],
    message:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis bibendum, odio semper placerat efficitur, augue nibh dictum lectus, at ultricies justo dolor non orci.",
  ),
];
