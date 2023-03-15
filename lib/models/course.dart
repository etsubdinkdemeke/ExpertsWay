// ignore_for_file: constant_identifier_names

import 'dart:convert';

Course courseFromJson(dynamic str) => Course.fromJson(str);

String courseToJson(Course data) => json.encode(data.toJson());

class CourseFilds {
  static final List<dynamic> values = [
    // add all fileds
    code,
  ];
  static const String code = 'code';
}

class Course {
  Course({
    required this.code,
    required this.courses,
  });

  Course copy({
    int? code,
    List<CourseElement>? courses,
  }) =>
      Course(
        code: code ?? this.code,
        courses: courses ?? this.courses,
      );

  int code;
  List<CourseElement> courses;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        code: json["code"],
        courses: List<CourseElement>.from(
            json["courses"].map((x) => CourseElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "courses": List<dynamic>.from(courses.map((x) => x.toJson())),
      };
}

class CourseElementFields {
  static final List<String> values = [
    // add all fileds
    course_id, name, slug, description, color, icon, banner, shortVideo,
    lastUpdated, eneabled
  ];

  static const String course_id = '_id';
  static const String name = 'name';
  static const String slug = 'slug';
  static const String description = 'description';
  static const String color = 'color';
  static const String icon = 'icon';
  static const String banner = 'banner';
  static const String shortVideo = 'short_video';
  static const String lastUpdated = 'last_updated';
  static const String eneabled = 'enabled';
  static const String isLastSeen = 'is_last_seen';
  static const String seenCounter = 'seen_counter';
}

class CourseElement {
  CourseElement({
    this.courseId,
    required this.name,
    required this.slug,
    required this.description,
    required this.color,
    required this.icon,
    required this.banner,
    required this.shortVideo,
    this.lastUpdated,
    required this.enabled,
    this.seenCounter,
    this.isLastSeen,
  });

  CourseElement copy({
    int? courseId,
    String? name,
    String? slug,
    String? description,
    String? color,
    String? icon,
    String? banner,
    String? shortVideo,
    DateTime? lastUpdated,
    bool? enabled,
    int? isLastSeen,
    int? seenCounter,
  }) =>
      CourseElement(
        courseId: courseId ?? this.courseId,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        description: description ?? this.description,
        color: color ?? this.color,
        icon: icon ?? this.icon,
        banner: banner ?? this.banner,
        shortVideo: shortVideo ?? this.shortVideo,
        lastUpdated: lastUpdated ?? this.lastUpdated,
        enabled: enabled ?? this.enabled,
        isLastSeen: isLastSeen ?? this.isLastSeen,
        seenCounter: seenCounter ?? this.seenCounter,
      );

  final int? courseId;
  String name;
  String slug;
  String description;
  String color;
  String icon;
  String banner;
  String shortVideo;
  DateTime? lastUpdated;
  bool enabled;
  int? seenCounter;
  int? isLastSeen;

  factory CourseElement.fromJson(Map<String, dynamic> json) => CourseElement(
        courseId: json[CourseElementFields.course_id] as int?,
        name: json[CourseElementFields.name] ?? '',
        slug: json[CourseElementFields.slug] ?? '',
        description: json[CourseElementFields.description] ?? '',
        color: json[CourseElementFields.color] ?? '',
        icon: json[CourseElementFields.icon] ?? '',
        banner: json[CourseElementFields.banner] ?? '',
        shortVideo: json[CourseElementFields.shortVideo] ?? '',
        lastUpdated: json[CourseElementFields.lastUpdated] == null
            ? null
            : DateTime.parse(json[CourseElementFields.lastUpdated]),
        enabled: json[CourseElementFields.eneabled] == 1,
        isLastSeen: json[CourseElementFields.isLastSeen] as int?,
        seenCounter: json[CourseElementFields.seenCounter] as int?,
      );

  Map<String, Object?> toJson() => {
        CourseElementFields.course_id: courseId,
        CourseElementFields.name: name,
        CourseElementFields.slug: slug,
        CourseElementFields.description: description,
        CourseElementFields.color: color,
        CourseElementFields.icon: icon,
        CourseElementFields.banner: banner,
        CourseElementFields.shortVideo: shortVideo,
        CourseElementFields.lastUpdated: lastUpdated!.toIso8601String(),
        CourseElementFields.eneabled: enabled ? 1 : 0,
        CourseElementFields.isLastSeen: isLastSeen,
        CourseElementFields.seenCounter: seenCounter,
      };
}

class SectionFields {
  static final List<String> secValues = [secId, courseId, sections, level];
  static const String secId = '_id';
  static const String courseId = 'course_id';
  static const String sections = 'sections';
  static const String level = 'level';
}

class Section {
  Section({
    this.secId,
    this.courseId,
    this.section,
    this.level,
  });

  String? secId;
  String? courseId;
  String? section;
  String? level;

  Section copy({
    String? secId,
    String? courseId,
    String? section,
    String? level,
  }) =>
      Section(
        secId: secId ?? this.secId,
        courseId: courseId ?? this.courseId,
        section: section ?? this.section,
        level: level ?? this.level,
      );

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        secId: json[SectionFields.secId] as String?,
        courseId: json[SectionFields.courseId] as String?,
        section: json[SectionFields.sections] as String,
        level: json[SectionFields.level] as String?,
      );

  Map<String, dynamic> toJson() => {
        SectionFields.secId: secId ?? '',
        SectionFields.courseId: courseId ?? '',
        SectionFields.sections: section ?? '',
        SectionFields.level: level ?? '',
      };
}
