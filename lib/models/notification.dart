
class NotificationFields {
  static List<String> value = [
    id,
    courseId,
    userProgress,
    imgUrl,
    isComplete,
    completeDate,
  ];
  static final String id = '_id';
  static final String courseId = 'courseId';
  static final String userProgress = 'userProgress';
  static final String imgUrl = 'imgUrl';
  static final String isComplete = 'isComplete';
  static final String completeDate = 'completeDate';
}

class NotificationElement {
  final int? id;
  final String courseId;
  final String userProgress;
  final String imgUrl;
  final bool isComplete;
  final DateTime completeDate;
  NotificationElement({
    this.id,
    required this.courseId,
    required this.userProgress,
    required this.imgUrl,
    required this.isComplete,
    required this.completeDate,
  });

  NotificationElement copy({
    final int? id,
    final String? courseId,
    final String? userProgress,
    final String? imgUrl,
    final bool? isComplete,
    final DateTime? completeDate,
  }) =>
      NotificationElement(
        id: id ?? this.id,
        courseId: courseId ?? this.courseId,
        userProgress: userProgress ?? this.userProgress,
        imgUrl: imgUrl ?? this.imgUrl,
        isComplete: isComplete ?? this.isComplete,
        completeDate: completeDate ?? this.completeDate,
      );

  static NotificationElement fromJson(Map<String, dynamic> json) =>
      NotificationElement(
        id: json[NotificationFields.id] as int ,
        courseId: json[NotificationFields.courseId] as String,
        userProgress: json[NotificationFields.userProgress] as String,
        imgUrl: json[NotificationFields.imgUrl] as String,
        isComplete: json[NotificationFields.isComplete] == 0,
        completeDate:
            DateTime.parse(json[NotificationFields.completeDate] as String),
      );

  Map<String, dynamic?> tojson() => {
        NotificationFields.id: id,
        NotificationFields.courseId: courseId,
        NotificationFields.userProgress: userProgress,
        NotificationFields.imgUrl: imgUrl,
        NotificationFields.isComplete: isComplete ? 1 : 0,
        NotificationFields.completeDate: completeDate.toIso8601String(),
      };
}
