import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Message {
  final String text;
  final bool isFile;
  final String? filePath;

  Message({required this.text, this.isFile = false, this.filePath});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var string1 = "Test!!";
  List<Message> notes = [];
  final TextEditingController txtController = TextEditingController();

  void toast(String a) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("$a"), duration: Duration(milliseconds: 400)),
    );
  }

  void push_data() {
    setState(() {
      if (txtController.text.isNotEmpty) {
        notes.add(
          Message(text: txtController.text, isFile: false, filePath: null),
        );
        txtController.clear();
      } else {
        toast("Please enter a message");
        txtController.clear();
      }
    });
  }

  void dialog() {
    int size = notes.length;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.red, width: 8),
          ),
          title: Text("⚠️ Confirm action ⚠️", textAlign: TextAlign.center),
          content: Text(
            "Are you sure you want to clear the chat?",
            textAlign: TextAlign.center,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      notes.clear();
                      toast("All messages have been deleted");
                      Navigator.of(context).pop();
                    });
                  },
                  child: Text("Delete"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void delete(int a) {
    setState(() {
      if (a == 0) {
        if (notes.isNotEmpty) {
          notes.removeLast();
        } else {
          toast("Chat is locked!!");
        }
      } else {
        if (notes.isNotEmpty) {
          dialog();
        } else {
          toast("Long press to delete all the messages");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Color(0xffece5dd),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/wabg.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.all(0),
                  padding: EdgeInsets.all(0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.9,
                  /*decoration: BoxDecoration(
                    color: Color(0x1f000000),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.zero,
                    border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                  ),*/
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(0),
                            padding: EdgeInsets.fromLTRB(0, 35, 0, 0),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.zero,
                              border: Border.all(
                                color: Color(0x4d9e9e9e),
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      delete(0);
                                    },
                                    onLongPress: () {
                                      delete(1);
                                    },
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: Colors.black,
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                    ),
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Color(0xfff3ccd6),
                                      child: Text(
                                        "S",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ),

                                  Text(
                                    "Soorya Kiran",
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      toast("Video calls coming soon...");
                                    },
                                    icon: Icon(
                                      Icons.video_camera_front_outlined,
                                      color: Colors.black,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      toast("Voice calls coming soon...");
                                    },
                                    icon: Icon(Icons.call, color: Colors.black),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      toast("Cloud sync coming soon...");
                                    },
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        flex: 1,
                        child: ListView(
                          reverse: true,
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.all(0),
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          children: notes
                              .map((item) {
                                return Align(
                                  alignment: Alignment.centerRight,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.zero,
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    color: Color(0xffdcf8c6),
                                    elevation: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10.0,
                                        horizontal: 16.0,
                                      ),
                                      child: Text(item.text),
                                    ),
                                  ),
                                );
                              })
                              .toList()
                              .reversed
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.07,
                /*decoration: BoxDecoration(
                  color: Color(0x1f000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.zero,
                  border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                ),*/
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextField(
                            controller: txtController,
                            onChanged: (text) {
                              setState(() {});
                            },
                            obscureText: false,
                            textAlign: TextAlign.start,
                            maxLines: null,
                            minLines: null,
                            expands: true,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                            decoration: InputDecoration(
                              prefixIcon: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.emoji_emotions_outlined),
                              ),
                              suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.attach_file_sharp),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      toast("Not enough balance!!...");
                                    },
                                    icon: Icon(Icons.currency_rupee_sharp),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      toast("Camera driver faulty!!...");
                                    },
                                    icon: Icon(Icons.camera_alt_outlined),
                                  ),
                                ],
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Message",
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                              filled: true,
                              fillColor: Color(0xfff2f2f3),
                              isDense: false,
                              contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 72,
                        width: 72,
                        child: MaterialButton(
                          onPressed: () {
                            if (txtController.text.isNotEmpty) {
                              push_data();
                            } else {
                              toast("Voice notes coming soon!!");
                            }
                          },
                          color: Color(0xff0a912b),
                          elevation: 5,
                          shape: CircleBorder(side: BorderSide(width: 0)),
                          child: Icon(
                            txtController.text.isNotEmpty
                                ? Icons.send
                                : Icons.mic,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
