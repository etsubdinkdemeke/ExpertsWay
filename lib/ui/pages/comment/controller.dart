import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/comments_data.dart';

class CommentController extends GetxController {
  final _comment = ''.obs;
  final _commentReplay = ''.obs;

  String get comment => _comment.value;
  String get commentReplay => _commentReplay.value;

  String? profileName = '';
  String? profileImage = '';

  final TextEditingController textEditingcontroller = TextEditingController();

  final _scrollController = Rx<ScrollController>(ScrollController());
  ScrollController get scrollController => _scrollController.value;

  //test field focus
  final _focusNode = Rx<FocusNode?>(FocusNode());
  FocusNode? get focusNode => _focusNode.value;

  //bulk data for comment section
  final comments = [
    Comment(
      date: "3",
      firstName: "Naol Girma ",
      imageUrl: "assets/images/p1.jpg",
      like: 5,
      liked: true,
      disLike: 7,
      reply: [
        Comment(
          date: "3",
          firstName: "Naol Girma nest",
          imageUrl: "assets/images/p1.jpg",
          like: 5,
          liked: true,
          disLike: 7,
          reply: [],
          message:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis bibendum, odio semper placerat efficitur, augue nibh dictum lectus, at ultricies justo dolor non orci.",
        ),
      ],
      message:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis bibendum, odio semper placerat efficitur, augue nibh dictum lectus, at ultricies justo dolor non orci.",
    ),
    Comment(
      date: "7",
      firstName: "Naol Girma trial",
      imageUrl: "assets/images/p1.jpg",
      like: 6,
      liked: false,
      disLike: 9,
      reply: [],
      message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis.",
    ),
    // Comment(
    //   date: "5",
    //   firstName: "Naol Girma",
    //   imageUrl: "assets/images/p1.jpg",
    //   like: 7,
    //   liked: true,
    //   disLike: 0,
    //   reply: [],
    //   message:
    //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis bibendum, odio semper placerat efficitur, augue nibh dictum lectus, at ultricies justo dolor non orci.",
    // ),
    // Comment(
    //   date: "8",
    //   firstName: "Naol Girma",
    //   imageUrl: "assets/images/p1.jpg",
    //   like: 8,
    //   liked: true,
    //   disLike: 1,
    //   reply: [],
    //   message:
    //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis bibendum, odio semper placerat efficitur, augue nibh dictum lectus, at ultricies justo dolor non orci.",
    // ),
    // Comment(
    //   date: "9",
    //   firstName: "Naol Girma",
    //   imageUrl: "assets/images/p1.jpg",
    //   like: 6,
    //   liked: false,
    //   disLike: 9,
    //   reply: [],
    //   message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis.",
    // ),
    // Comment(
    //   date: "2",
    //   firstName: "Naol Girma",
    //   imageUrl: "assets/images/p1.jpg",
    //   like: 6,
    //   liked: false,
    //   disLike: 9,
    //   reply: [],
    //   message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis.",
    // ),
    // Comment(
    //   date: "1",
    //   firstName: "Naol Girma",
    //   imageUrl: "assets/images/p1.jpg",
    //   like: 1,
    //   liked: true,
    //   disLike: 3,
    //   reply: [],
    //   message:
    //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis bibendum, odio semper placerat efficitur, augue nibh dictum lectus, at ultricies justo dolor non orci.",
    // ),
  ].obs;

  @override
  void onReady() {
    _scrollController.value.animateTo(
      _scrollController.value.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    super.onReady();
  }

  @override
  void onInit() {
    getProfileDetails();
    _focusNode.value?.unfocus();

    super.onInit();
  }

  onChangeCommentText(String text) {
    _comment.value = text;
  }

  onChangeCommentReplayText(String text) {
    _commentReplay.value = text;
  }

  onDeleteComment() {}

  onClickPost() async {
    textEditingcontroller.text = '';
    comments.add(
      Comment(
        date: "1",
        firstName: "Comment guy",
        imageUrl: "assets/images/p1.jpg",
        like: 1,
        liked: true,
        disLike: 3,
        reply: [],
        message: comment,
      ),
    );
    _focusNode.value?.unfocus();

    _comment.value = '';

    await Future.delayed(const Duration(milliseconds: 100));
    _scrollController.value.animateTo(
      _scrollController.value.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    update();
  }

  onClickReply(Comment comment) async {
    comment.reply.add(
      Comment(
        date: "1",
        firstName: "Replay guy",
        imageUrl: "assets/images/p1.jpg",
        like: 1,
        liked: true,
        disLike: 3,
        reply: [],
        message: commentReplay,
      ),
    );

    _commentReplay.value = '';
    update();

    print(comment.reply.length);

    Get.back();
  }

  Future getProfileDetails() async {
    final result = await SharedPreferences.getInstance();
    profileName = result.getString('name');
    profileImage = result.getString('image');
  }

  @override
  void onClose() {
    _focusNode.value?.unfocus();
    super.onClose();
  }

  @override
  void dispose() {
    textEditingcontroller.dispose();
    super.dispose();
  }
}
