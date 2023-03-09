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
  List<notification> list = [];
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
    List<String>? listString = sharedPreferences.getStringList('list');
    if (listString != null) {
      list = listString
          .map((item) => notification.fromMap(json.decode(item)))
          .toList();
      getNotifs();
    }
  }

  onNotifDismissed(notification item) {
    list.remove(item);
    List<String> stringList =
        list.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences.setStringList('list', stringList);
    getNotifs();
  }

  List<notification> today = [], thiss = [], older = [];

  getNotifs() {
    today = [];
    thiss = [];
    older = [];
    for (final e in list) {
      if (allNotifs) {
        if (e.date == "Today") {
          today.add(e);
        } else if (e.date == "This") {
          thiss.add(e);
        } else if (e.date == "Older") {
          older.add(e);
        }
      } else {
        if (readNotifs) {
          if (e.date == "Today" && e.read == true) {
            today.add(e);
          } else if (e.date == "This" && e.read == true) {
            thiss.add(e);
          } else if (e.date == "Older" && e.read == true) {
            older.add(e);
          }
        } else {
          if (e.date == "Today" && e.read == false) {
            today.add(e);
          } else if (e.date == "This" && e.read == false) {
            thiss.add(e);
          } else if (e.date == "Older" && e.read == false) {
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
                          ? today.length + thiss.length + older.length > 1
                              ? TextSpan(
                                  text:
                                      '${today.length + thiss.length + older.length} read ',
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 99, 187, 249),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15))
                              : const TextSpan(
                                  text: 'no read ',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15))
                          : today.length + thiss.length + older.length > 1
                              ? TextSpan(
                                  text:
                                      '${today.length + thiss.length + older.length} new ',
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
                SizedBox(width: MediaQuery.of(context).size.width * 0.36),
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
                child: Column(
              children: [
                today.length > 0
                    ? Column(
                        children: [
                          titleText("Today"),
                          buildNotif(today.length, today),
                        ],
                      )
                    : Container(),
                thiss.length > 0
                    ? Column(
                        children: [
                          titleText("Last "),
                          buildNotif(thiss.length, thiss),
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
      margin: const EdgeInsets.only(left: 20, bottom: 10),
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

  Widget buildTile(notification item) {
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
                    child: item.read
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
                          child: Text(item.message.toString(),
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

  void addItem(notification item) {
    list.insert(0, item);
    List<String> stringList =
        list.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences.setStringList('list', stringList);
  }

//testing
  // additems() {
  //additems
  // addItem(notification(
  //     date: "Today", message: notifMessages[0].message, read: false));
  // addItem(notification(
  //     date: "Today", message: notifMessages[1].message, read: false));
  // addItem(notification(
  //     date: "Today", message: notifMessages[2].message, read: true));
  // addItem(notification(date: "Older", message: "older", read: false));
  // addItem(notification(date: "Older", message: "older", read: true));

  //printlength
  // print(list.length);

  //deleteitems
  // for (var e in list) {
  //   // if (e.date == date && e.message == message) {
  //   list.remove(e);
  //   // }
  // }
  // }
}
