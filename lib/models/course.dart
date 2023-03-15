import 'dart:convert';

Course courseFromJson(dynamic str) => Course.fromJson(str);

String courseToJson(Course data) => json.encode(data.toJson());

class CourseFilds {
  static final List<dynamic> values = [
    // add all fileds
    code,
  ];
  static final String code = 'code';
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

  static final String course_id = '_id';
  static final String name = 'name';
  static final String slug = 'slug';
  static final String description = 'description';
  static final String color = 'color';
  static final String icon = 'icon';
  static final String banner = 'banner';
  static final String shortVideo = 'short_video';
  static final String lastUpdated = 'last_updated';
  static final String eneabled = 'enabled';
  static final String isLastSeen = 'is_last_seen';
  static final String seenCounter = 'seen_counter';
}

class CourseElement {
  CourseElement({
    this.course_id,
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
    int? course_id,
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
        course_id: course_id ?? this.course_id,
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

  final int? course_id;
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
        course_id: json[CourseElementFields.course_id] as int?,
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
        CourseElementFields.course_id: course_id,
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
  static final List<String> sec_values = [sec_id, course_id, sections, level];
  static final String sec_id = '_id';
  static final String course_id = 'course_id';
  static final String sections = 'sections';
  static final String level = 'level';
}

class Section {
  Section({
    this.sec_id,
    this.course_id,
    this.section,
    this.level,
  });

  String? sec_id;
  String? course_id;
  String? section;
  String? level;

  Section copy({
    String? sec_id,
    String? course_id,
    String? section,
    String? level,
  }) =>
      Section(
        sec_id: sec_id ?? this.sec_id,
        course_id: course_id ?? this.course_id,
        section: section ?? this.section,
        level: level ?? this.level,
      );

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        sec_id: json[SectionFields.sec_id] as String?,
        course_id: json[SectionFields.course_id] as String?,
        section: json[SectionFields.sections] as String,
        level: json[SectionFields.level] as String?,
      );

  Map<String, dynamic> toJson() => {
        SectionFields.sec_id: sec_id ?? '',
        SectionFields.course_id: course_id ?? '',
        SectionFields.sections: section ?? '',
        SectionFields.level: level ?? '',
      };
}
