import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expertsway/theme/box_icons_icons.dart';
import 'package:expertsway/ui/pages/comment/controller.dart';
import 'package:expertsway/ui/widgets/gradient_button.dart';

import '../../../models/comments_data.dart';

class MyWidgetComment extends GetView<CommentController> {
  const MyWidgetComment({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CommentController());
    final theme = Theme.of(context);
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Comments',
                      style: theme.textTheme.titleMedium
                          ?.copyWith(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      maxRadius: 24,
                      foregroundImage: AssetImage(
                        'assets/images/p1.jpg',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: TextField(
                          focusNode: controller.focusNode,
                          controller: controller.textEditingcontroller,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(14),
                            hintStyle: TextStyle(
                                color: Color.fromARGB(90, 166, 165, 165),
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                            hintText: 'Share something user',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.black,
                              width: 12,
                            )),
                          ),
                          onChanged: (val) {
                            controller.onChangeCommentText(val);
                          },
                        ),
                      ),
                    )
                  ],
                ),
                Obx(() {
                  return Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: GradientBtn(
                        onPressed: controller.comment == ''
                            ? null
                            : controller.onClickPost,
                        btnName: 'Post',
                        defaultBtn: true,
                        isPcked: false,
                        width: 65,
                      ),
                    ),
                  );
                }),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    controller: controller.scrollController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.comments.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          _CommentSectionView(
                            controller: controller,
                            comment: controller.comments[index],
                            isSubComment: false,
                          ),
                          if (controller.comments[index].reply.isNotEmpty)
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    controller.comments[index].reply.length,
                                itemBuilder: (context, index) {
                                  return _CommentSectionView(
                                      controller: controller,
                                      isSubComment: true,
                                      comment: controller
                                          .comments[index].reply[index]);
                                }),
                          const Divider(),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CommentSectionView extends StatelessWidget {
  final bool isSubComment;
  final Comment comment;
  final CommentController controller;
  const _CommentSectionView(
      {required this.isSubComment,
      required this.comment,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        // if (isSubComment)
        //   const Padding(
        //     padding: EdgeInsets.only(left: 10),
        //     child: VerticalDivider(
        //       width: 20,
        //       thickness: 1,
        //       indent: 20,
        //       endIndent: 5,
        //       color: Colors.grey,
        //     ),
        //   ),
        Expanded(
          child: Padding(
            padding: isSubComment
                ? const EdgeInsets.only(left: 24)
                : const EdgeInsets.all(0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isSubComment) const SizedBox(height: 4),
                Row(
                  children: [
                    CircleAvatar(
                      maxRadius: 24,
                      foregroundImage: AssetImage(
                        comment.imageUrl,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      comment.firstName,
                      style: theme.textTheme.titleLarge
                          ?.copyWith(color: const Color(0xff2E2E2E)),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '9 Month ago',
                      style: theme.textTheme.titleLarge?.copyWith(
                          color: const Color.fromARGB(126, 46, 46, 46)),
                    )
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  comment.message,
                  style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                      ),
                      child: const Icon(Icons.thumb_up_alt_outlined),
                    ),
                    if (!isSubComment)
                      TextButton(
                          onPressed: () {
                            Get.dialog(Dialog(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    onChanged: (value) => controller
                                        .onChangeCommentReplayText(value),
                                  ),
                                  TextButton(
                                      onPressed: () =>
                                          controller.onClickReply(comment),
                                      child: const Text('Replay'))
                                ],
                              ),
                            ));
                          },
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                          ),
                          child: const Text(
                            'Replay',
                            style: TextStyle(
                                color: Color.fromARGB(126, 46, 46, 46)),
                          )),
                    TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                        ),
                        child: const Text(
                          'Report',
                          style:
                              TextStyle(color: Color.fromARGB(126, 46, 46, 46)),
                        )),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                      ),
                      child: const Icon(
                        BoxIcons.bx_trash,
                        color: Colors.red,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                      ),
                      child: const Icon(Icons.edit),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
