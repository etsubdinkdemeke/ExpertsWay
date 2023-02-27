import 'dart:convert';
import 'dart:ffi';

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

/// ****************** */
class LessonsElementFields {
  static final List<String> values = [
    lesson_id,
    slug,
    title,
    section,
    publishedDate,
  ];

  static final String lesson_id = 'lesson_id';
  static final String slug = 'slug';
  static final String title = 'title';
  static final String section = 'section';
  static final String courseSlug = 'course_slug';
  static final String publishedDate = 'published_date';
}

class LessonElement {
  int lessonId;
  String slug;
  String title;
  String section;
  String courseSlug;
  List<String> content;
  String? commentStatus;
  String? commentCount;
  DateTime? postModified;
  DateTime? publishedDate;

  LessonElement({
    required this.lessonId,
    required this.slug,
    required this.title,
    required this.section,
    required this.courseSlug,
    required this.content,
    this.commentStatus,
    this.commentCount,
    this.postModified,
    this.publishedDate,
  });

  LessonElement copy({
    int? lessonId,
    String? slug,
    String? title,
    String? section,
    String? courseSlug,
    List<String>? content,
    DateTime? publishedDate,
  }) =>
      LessonElement(
        lessonId: lessonId ?? this.lessonId,
        slug: slug ?? this.slug,
        title: title ?? this.title,
        section: section ?? this.section,
        courseSlug: courseSlug ?? this.courseSlug,
        content: content ?? this.content,
        publishedDate: publishedDate ?? publishedDate,
      );

  
  factory LessonElement.fromJson(Map<String, dynamic> json) => LessonElement(
        lessonId: json[LessonsElementFields.lesson_id] as int,
        slug: json[LessonsElementFields.slug] as String? ?? '',
        title: json[LessonsElementFields.title] as String? ?? '',
        section: json[LessonsElementFields.section] as String? ?? '',
        courseSlug: json[LessonsElementFields.courseSlug] as String? ?? '',
        content: json["content"] == null
            ? []
            : List<String>.from(json["content"].map((x) => x)),
        commentStatus: json['comment_status'] as String? ?? '',
        commentCount: json['comment_count'] as String? ?? '',
        postModified: json['post_modified'] == null
            ? null
            : DateTime.parse(json['post_modified'] as String),
        publishedDate: json[LessonsElementFields.publishedDate] == null
            ? null
            : DateTime.parse(
                json[LessonsElementFields.publishedDate] as String),
      );

  Map<String, Object?> toJson() => {
        LessonsElementFields.lesson_id: lessonId,
        LessonsElementFields.slug: slug,
        LessonsElementFields.title: title,
        LessonsElementFields.section: section,
        LessonsElementFields.courseSlug: courseSlug,
        LessonsElementFields.publishedDate: publishedDate!.toIso8601String(),
      };
}

/// ****************** */
class LessonsContentFields {
  static List<String> lessonsvalue = [
    id,
    lessonId,
    content,
  ];
  static final String id = '_id';
  static final String lessonId = 'lessonId';
  static final String content = 'content';
}

class LessonContent {
  final int? id;
  final String lessonId;
  final String content;
  LessonContent({
    this.id,
    required this.lessonId,
    required this.content,
  });

  LessonContent copy({
    int? id,
    String? lessonId,
    String? content,
  }) =>
      LessonContent(
          id: id ?? this.id,
          lessonId: lessonId ?? this.lessonId,
          content: content ?? this.content);
  factory LessonContent.fromJson(Map<String, dynamic> json) => LessonContent(
        id: json[LessonsContentFields.id] as int,
        lessonId: json[LessonsContentFields.lessonId] as String,
        content: json[LessonsContentFields.content] as String,
      );

  Map<String, dynamic> toJson() => {
        LessonsContentFields.id: id,
        LessonsContentFields.lessonId: lessonId,
        LessonsContentFields.content: content,
      };
}
