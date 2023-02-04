final String tableCourse = 'courses';

class CourseFields {
  static final List<String> values = [
    // add all fileds
    id, name, description, iconName, video, seenCounter, isLastSeen 
  ];

  static final String id = '_id';
  static final String name = 'name';
  static final String description = 'description';
  static final String iconName = 'iconName';
  static final String video = 'video';
  static final String seenCounter = 'seenCounter';
  static final String isLastSeen = 'isLastSeen';
}
class CourseTable {
  final int? id;
  final String name;
  final String description;
  final String iconName;
  final String video;
  final int seenCounter;
  final DateTime isLastSeen;

  const CourseTable({
    this.id,
    required this.name,
    required this.description,
    required this.iconName,
    required this.video,
    required this.seenCounter,
    required this.isLastSeen,
  });

    CourseTable copy({
    int? id,
    String? name,
    String? description,
    String? iconName,
    String? video,
    int? seenCounter,
    DateTime? isLastSeen,
  }) =>
      CourseTable(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        iconName: iconName ?? this.iconName,
        video: video ?? this.video,
        seenCounter: seenCounter ?? this.seenCounter,
        isLastSeen: isLastSeen ?? this.isLastSeen,
      );
  static CourseTable fromJson(Map<String, Object?> json) => CourseTable(
        id: json[CourseFields.id] as int?,
        name: json[CourseFields.name] as String,
        description: json[CourseFields.description] as String,
        iconName: json[CourseFields.iconName] as String,
        video: json[CourseFields.video] as String,
        seenCounter: json[CourseFields.seenCounter] as int,
        isLastSeen: DateTime.parse(json[CourseFields.isLastSeen] as String),

      );

  Map<String, Object?> toJson() => {
        CourseFields.id: id,
        CourseFields.name: name,
        CourseFields.description: description,
        CourseFields.iconName: iconName,
        CourseFields.video: video,
        CourseFields.seenCounter: seenCounter,
        CourseFields.isLastSeen: isLastSeen.toIso8601String(),
      };

}
