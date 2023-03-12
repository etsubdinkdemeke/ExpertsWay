import 'dart:convert';

// course finished

// replay

// quiz

// new course
class NotificationFields {
  static List<dynamic> value = [
    id,
    heighlightText,
    type,
    imgUrl, 
    createdDate,
  ];
  static final String id = '_id';
  static final String heighlightText = 'heighlightText';
  static final String type = 'type';
  static final String imgUrl = 'imgUrl';
  static final String createdDate = 'createdDate';
}

NotificationElement notificationFromJson(dynamic str) =>
    NotificationElement.fromJson(str);

String notificationToJson(NotificationElement data) =>
    json.encode(data.tojson());

class NotificationElement {
  final int? id;
  final String heighlightText;
  final String type;
  final String? imgUrl;
  final DateTime createdDate;
  NotificationElement({
    this.id,
    required this.heighlightText,
    required this.type,
    required this.imgUrl,
    required this.createdDate,
  });

  NotificationElement copy({
    final int? id,
    final String? heighlightText,
    final String? type,
    final String? imgUrl,
    final DateTime? createdDate,
  }) =>
      NotificationElement(
        id: id ?? this.id,
        heighlightText: heighlightText ?? this.heighlightText,
        type: type ?? this.type,
        imgUrl: imgUrl ?? this.imgUrl,
        createdDate: createdDate ?? this.createdDate,
      );

  factory NotificationElement.fromJson(Map<String, dynamic> json) =>
      NotificationElement(
        id: json[NotificationFields.id] as int,
        heighlightText: json[NotificationFields.heighlightText] as String,
        type: json[NotificationFields.type] as String,
        imgUrl: json[NotificationFields.imgUrl] as String,
        createdDate:
            DateTime.parse(json[NotificationFields.createdDate] as String),
      );

  Map<String, dynamic> tojson() => {
        NotificationFields.id: id,
        NotificationFields.heighlightText: heighlightText,
        NotificationFields.type: type,
        NotificationFields.imgUrl: imgUrl,
        NotificationFields.createdDate: createdDate.toIso8601String(),
      };
}
