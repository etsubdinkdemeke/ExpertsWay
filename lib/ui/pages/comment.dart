import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:learncoding/models/comments_data.dart';

class CommentSection extends StatefulWidget {
  const CommentSection({super.key});

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final comment = comments;

  Future<List<Comment>>? _commentsFuture;

  @override
  void initState() {
    super.initState();
    _commentsFuture = _loadComments();
  }

  Future<List<Comment>> _loadComments() async {
    // Simulate a network request by delaying the execution
    await Future.delayed(Duration(seconds: 2));
    return comment;
    //return comment.commentss;
  }

  //its still under development

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.white,
        leading: CupertinoButton(
          child: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Color.fromARGB(255, 83, 83, 83),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        middle: const Text(
          'Comments',
          style: TextStyle(
            color: Color.fromARGB(255, 83, 83, 83),
            fontFamily: 'Red Hat Display',
            fontSize: 20,
          ),
        ),
      ),
      // child: Container(
      //   color: Colors.amberAccent,
      // ),
      child: SingleChildScrollView(
        //color: Colors.white,
        child: FutureBuilder<List<Comment>>(
            future: _commentsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('An error occurred: ${snapshot.error}'),
                  );
                } else {
                  //if(snapshot.hasData)
                  return Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          final _comm = comments[index];

                          return Expanded(
                            // padding: EdgeInsets.all(16),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                                left: 20,
                                right: 10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '${_comm.date}  -  ',
                                        style: TextStyle(
                                            fontFamily: 'Red Hat Display',
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black54),
                                      ),
                                      Text(
                                        _comm.firstName,
                                        style: TextStyle(
                                          fontFamily: 'Red Hat Display',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Container(
                                      child: Text(
                                        _comm.message,
                                        style: TextStyle(
                                          fontFamily: 'Red Hat Display',
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),

                  //----------------------like , dislike section
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            GestureDetector(
                                              child: Image.asset(
                                                "assets/images/like.png",
                                                scale: 20,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              _comm.like.toString(),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              child: Image.asset(
                                                "assets/images/dislike.png",
                                                scale: 20,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              _comm.disLike.toString(),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              child: Image.asset(
                                                "assets/images/chat.png",
                                                scale: 20,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              _comm.reply.toString(),
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Image.asset(
                                            "assets/images/caution.png",
                                            scale: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                      //--------------------end-----------------------------//
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                     
                    ],
                  );
                }
              } else
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.blueAccent,
                  ),
                );
            }),
      ),
    );
  }
}
//Widget 
