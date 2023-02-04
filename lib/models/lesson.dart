import 'dart:convert';

Lesson lessonFromJson(dynamic str) => Lesson.fromJson(str);

String lessonToJson(Lesson data) => json.encode(data.toJson());

class Lesson {
  int code;
  List<LessonElement?> lessons;

  Lesson({required this.code, required this.lessons});

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        code: json["code"],
        lessons: json["lessons"] == null
            ? []
            : List<LessonElement?>.from(
                json["lessons"]!.map((x) => LessonElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "lessons": lessons == null
            ? []
            : List<dynamic>.from(lessons.map((x) => x!.toJson())),
      };
}

class LessonElement {
  String? slug;
  String? title;
  String? courseSlug;
  String? section;
  List<String?>? content;
  String? commentStatus;
  String? commentCount;
  DateTime? publishedDate;
  DateTime? postModified;

  LessonElement(
      {this.slug,
      this.title,
      this.courseSlug,
      this.section,
      this.content,
      this.commentStatus,
      this.commentCount,
      this.publishedDate,
      this.postModified});

  factory LessonElement.fromJson(Map<String, dynamic> json) => LessonElement(
        slug: json["slug"],
        title: json["title"],
        courseSlug: json["course_slug"],
        section: json["section"],
        content: json["content"] == null
            ? []
            : List<String?>.from(json["content"]!.map((x) => x)),
        commentStatus: json["commentStatus"],
        commentCount: json["comment_count"],
        publishedDate: DateTime.parse(json["published_date"]),
        postModified: DateTime.parse(json["post_modified"]),
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
        "title": title,
        "course_slug": courseSlug,
        "section": section,
        "content":
            content == null ? [] : List<dynamic>.from(content!.map((x) => x)),
        "comment_status": commentStatus,
        "comment_count": commentCount,
        "published_date": publishedDate?.toIso8601String(),
        "post_modified": postModified?.toIso8601String(),
      };
}
