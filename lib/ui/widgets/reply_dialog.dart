import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:learncoding/models/comments_data.dart';

TextEditingController replyController = TextEditingController();

Widget replyDialog(
    {required int commentIndex,
    required Com data,
    required BuildContext context}) {
  return Dialog(
    child: SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            CupertinoTextField(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8)),
              controller: replyController,
              maxLines: 3,
              minLines: 2,
              placeholder: 'Reply',
              placeholderStyle: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        if (kDebugMode) {
                          print(replyController.text);
                        }
                        data.addReply(replyController.text, commentIndex);
                        Navigator.pop(context);
                      },
                      child: const Text("Reply")),
                ))
          ],
        ),
      ),
    ),
  );
}
