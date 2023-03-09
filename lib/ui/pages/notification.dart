import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learncoding/theme/config.dart' as config;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/notification.dart';
import '../../theme/box_icons_icons.dart';
import '../../utils/notificationMessage.dart';

class Notification extends StatefulWidget {
  const Notification({super.key});

  @override
  State<Notification> createState() => _NotificationState();
}

enum _MenuValues { All, Unread, Read }

class _NotificationState extends State<Notification> {
  List<NotificationElement> list = [];
  late SharedPreferences sharedPreferences;
  late bool allNotifs;
  late bool readNotifs;
  @override
  void initState() {
    loadSharedPreferencesAndData();
    allNotifs = true;
    readNotifs = false;
    super.initState();
  }

  void loadSharedPreferencesAndData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }

  void loadData() {
    List<dynamic>? listString = sharedPreferences.getStringList('list');
    additems(); //fortesting
    if (listString != null) {
      list = listString.map((item) => notificationFromJson(item)).toList();
      getNotifs();
    }
  }

  onNotifDismissed(NotificationElement item) {
    list.remove(item);
    List<String> stringList =
        list.map((item) => notificationToJson(item)).toList();
    sharedPreferences.setStringList('list', stringList);
    getNotifs();
  }

  List<NotificationElement> today = [], thisWeek = [], older = [];

  getNotifs() {
    today = [];
    thisWeek = [];
    older = [];
    var now = new DateTime.now();
    var now_1d = now.subtract(Duration(days: 1));
    var now_1w = now.subtract(Duration(days: 7));
    for (final e in list) {
      if (allNotifs) {
        if (now_1d.isBefore(e.completeDate)) {
          today.add(e);
        } else if (now_1w.isBefore(e.completeDate)) {
          thisWeek.add(e);
        } else {
          older.add(e);
        }
      } else {
        if (readNotifs) {
          if (now_1d.isBefore(e.completeDate) && e.isComplete == true) {
            today.add(e);
          } else if (now_1w.isBefore(e.completeDate) && e.isComplete == true) {
            thisWeek.add(e);
          } else if (e.isComplete == true) {
            older.add(e);
          }
        } else {
          if (now_1d.isBefore(e.completeDate) && e.isComplete == false) {
            today.add(e);
          } else if (now_1w.isBefore(e.completeDate) && e.isComplete == false) {
            thisWeek.add(e);
          } else if (e.isComplete == false) {
            older.add(e);
          }
        }
      }
    }
    setState(() {});
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Row(
                children: [
                  CupertinoButton(
                    child: const Icon(
                      Icons.chevron_left,
                      color: Colors.black,
                      size: 35,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width - 330),
                    child: const Text(
                      'Notifications',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontFamily: 'Red Hat Display',
                          fontWeight: FontWeight.w500,
                          fontSize: 22),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, bottom: 20),
              child: Row(children: [
                Text.rich(TextSpan(
                    style:
                        TextStyle(color: Colors.redAccent), //apply style to all
                    children: [
                      const TextSpan(
                          text: "You have ",
                          style: TextStyle(color: Colors.grey, fontSize: 15)),
                      readNotifs
                          ? today.length + thisWeek.length + older.length > 0
                              ? TextSpan(
                                  text:
                                      '${today.length + thisWeek.length + older.length} read ',
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 99, 187, 249),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15))
                              : const TextSpan(
                                  text: 'no read ',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15))
                          : today.length + thisWeek.length + older.length > 0
                              ? TextSpan(
                                  text:
                                      '${today.length + thisWeek.length + older.length} new ',
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 99, 187, 249),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15))
                              : const TextSpan(
                                  text: 'no new ',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15)),
                      const TextSpan(
                          text: "notifications",
                          style: TextStyle(color: Colors.grey, fontSize: 15)),
                    ])),
                SizedBox(width: MediaQuery.of(context).size.width * 0.34),
                PopupMenuButton<_MenuValues>(
                  initialValue: _MenuValues.All,
                  position: PopupMenuPosition.under,
                  icon: const Icon(
                    BoxIcons.bx_slider,
                    color: Color.fromARGB(255, 180, 180, 180),
                  ),
                  iconSize: 22,
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem(
                      value: _MenuValues.All,
                      child: Text('All'),
                    ),
                    const PopupMenuItem(
                      value: _MenuValues.Unread,
                      child: Text('Unread'),
                    ),
                    const PopupMenuItem(
                      value: _MenuValues.Read,
                      child: Text('Read'),
                    ),
                  ],
                  onSelected: (value) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    switch (value) {
                      case _MenuValues.All:
                        allNotifs = true;
                        readNotifs = false;
                        getNotifs();
                        break;
                      case _MenuValues.Unread:
                        allNotifs = false;
                        readNotifs = false;
                        getNotifs();
                        break;
                      case _MenuValues.Read:
                        allNotifs = false;
                        readNotifs = true;
                        getNotifs();
                        break;
                    }
                  },
                ),
              ]),
            ),
            Expanded(
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  today.length > 0
                      ? Column(
                          children: [
                            titleText("Today"),
                            buildNotif(today.length, today),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        )
                      : Container(),
                  thisWeek.length > 0
                      ? Column(
                          children: [
                            titleText("This week"),
                            buildNotif(thisWeek.length, thisWeek),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        )
                      : Container(),
                  older.length > 0
                      ? Column(
                          children: [
                            titleText("Older"),
                            buildNotif(older.length, older),
                          ],
                        )
                      : Container()
                ],
              )),
            ),
          ],
        ));
  }

  Widget buildNotif(int length, List listNotif) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.only(bottom: 20),
        itemCount: length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              buildTile(listNotif[index]),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            height: 1,
            color: Color.fromARGB(255, 245, 245, 245),
          );
        });
  }

  Widget titleText(String title) {
    return Container(
      margin: const EdgeInsets.only(left: 20, bottom: 20),
      alignment: Alignment.topLeft,
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: const TextStyle(
            fontSize: 17,
            fontFamily: 'Red Hat Display',
            fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget buildTile(NotificationElement item) {
    return Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.only(left: 20),
        child: Slidable(
          endActionPane: ActionPane(
              motion: const DrawerMotion(),
              extentRatio: 0.185,
              children: [
                SlidableAction(
                  foregroundColor: Colors.red,
                  padding: const EdgeInsets.only(left: 10),
                  icon: BoxIcons.bxs_trash,
                  onPressed: ((context) => onNotifDismissed(item)),
                )
              ]),
          child: Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(children: [
                Container(
                    child: item.isComplete
                        ? const SizedBox(
                            width: 7,
                          )
                        : const CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 7, 141, 251),
                            radius: 3,
                          )),
                Container(
                  margin: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: const CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage("assets/images/logo.png"),
                  ),
                ),
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.78,
                    margin: EdgeInsets.fromLTRB(20, 0, 5, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(item.userProgress.toString(),
                              style: const TextStyle(
                                  color: Color.fromARGB(136, 31, 31, 31))),
                        ),
                        const Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Text(
                              "2 hours ago",
                              style: TextStyle(
                                  color: Color.fromARGB(136, 31, 31, 31)),
                            )),
                      ],
                    ),
                  ),
                )
              ])),
        ));
  }

  void addItem(NotificationElement item) {
    list.insert(0, item);
    List<String> stringList =
        list.map((item) => notificationToJson(item)).toList();
    sharedPreferences.setStringList('list', stringList);
    getNotifs();
  }

//testing
  additems() {
    addItem(NotificationElement(
        completeDate: DateTime.parse("2023-03-09 18:45:45.201920"),
        imgUrl: 'dkski',
        isComplete: false,
        courseId: '33',
        userProgress: notifMessages[0].message));
    addItem(NotificationElement(
        completeDate: DateTime.parse("2023-03-09 18:45:45.201920"),
        imgUrl: 'dkski',
        isComplete: false,
        courseId: '33',
        userProgress: notifMessages[1].message));
    addItem(NotificationElement(
        completeDate: DateTime.parse("2023-03-09 18:45:45.201920"),
        imgUrl: 'dkski',
        isComplete: false,
        courseId: '33',
        userProgress: notifMessages[2].message));
    addItem(NotificationElement(
        completeDate: DateTime.parse("2023-03-07 18:45:45.201920"),
        imgUrl: 'dkski',
        isComplete: false,
        courseId: '33',
        userProgress: notifMessages[0].message));
    addItem(NotificationElement(
        completeDate: DateTime.parse("2023-03-01 18:45:45.201920"),
        imgUrl: 'dkski',
        isComplete: true,
        courseId: '33',
        userProgress: notifMessages[1].message));

    // printlengthfortesting
    // print(list.length);

    //deleteitemsfortesting
    // for (var e in list) {
    //   // if (e.date == date && e.message == message) {
    //   list.remove(e);
    //   // }
  }
  // }
}
