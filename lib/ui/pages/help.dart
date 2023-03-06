import 'package:learncoding/theme/config.dart' as config;
import 'package:learncoding/theme/box_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  Widget _container(String title, String description) {
    return Material(
      color: config.Colors().secondColor(1),
      child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                spreadRadius: 5,
                blurRadius: 3,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              iconTheme: const IconThemeData(
                size: 35,
              ),
            ),
            child: ExpansionTile(
              title: Row(
                children: [
                  const Icon(BoxIcons.bx_help_circle,
                      color: Color.fromARGB(255, 193, 193, 194), size: 25),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 193, 193, 194), //cahnge?
                      ),
                    ),
                  ),
                ],
              ),
              collapsedIconColor: Colors.lightBlue, //c
              children: <Widget>[
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                    child: Text(
                      description,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 193, 193, 194),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        trailing: CupertinoButton(
            child: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: null),
        backgroundColor: Colors.white,
        leading: CupertinoButton(
          child: Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        middle: Text(
          'Help',
          style: TextStyle(
              color: Colors.black, fontSize: 24),
        ),
      ),
      backgroundColor: config.Colors().secondColor(1),
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Center(
                child: Image(
                    image: ResizeImage(
                  AssetImage('assets/images/helpbackground.PNG'),
                  width: 300,
                  height: 200,
                )),
              ),
              SizedBox(height: 20),
              Text(
                "Success leaves clues.",
                style: TextStyle(
                  color: Color.fromARGB(255, 193, 193, 194), //cahnge?
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Study People you admire or want to be like.",
                style: TextStyle(
                  color: Color.fromARGB(255, 193, 193, 194),
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: Column(
              children: <Widget>[
                _container('How you earn coins ? ',
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
                _container('How you earn coins ? ',
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
                _container('How you earn coins ? ',
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
                _container('How you earn coins ? ',
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
                _container('How you earn coins ? ',
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
