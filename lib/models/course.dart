import 'dart:convert';

Course courseFromJson(dynamic str) => Course.fromJson(str);

String courseToJson(Course data) => json.encode(data.toJson());

class Course {
  Course({
    required this.code,
    required this.courses,
  });

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

class CourseElement {
  CourseElement({
    required this.slug,
    required this.name,
    required this.description,
    required this.icon,
    required this.shortVideo,
    required this.color,
    required this.lastUpdated,
    required this.sections,
    this.prerequests,
    required this.enabled,
  });

  String slug;
  String name;
  String description;
  String icon;
  String shortVideo;
  String color;
  DateTime lastUpdated;
  List<Section> sections;
  String? prerequests;
  String enabled;

  factory CourseElement.fromJson(Map<String, dynamic> json) => CourseElement(
        slug: json["slug"],
        name: json["name"],
        description: json["description"],
        icon: json["icon"],
        shortVideo: json["short_video"],
        color: json["color"],
        lastUpdated: DateTime.parse(json["last_updated"]),
        sections: List<Section>.from(
            json["sections"].map((x) => Section.fromJson(x))),
        prerequests: json["prerequests"],
        enabled: json["enabled"],
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
        "name": name,
        "description": description,
        "icon": icon,
        "short_video": shortVideo,
        "color": color,
        "last_updated": lastUpdated.toIso8601String(),
        "sections": List<dynamic>.from(sections.map((x) => x.toJson())),
        "prerequests": prerequests,
        "enabled": enabled,
      };
}

class Section {
  Section({
    required this.section,
    required this.level,
  });

  String section;
  String level;

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        section: json["section"],
        level: json["level"],
      );

  Map<String, dynamic> toJson() => {
        "section": section,
        "level": level,
      };
}
