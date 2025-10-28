import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var string1 = "Test!!";
  List<String> notes = [];
  final TextEditingController txtController = TextEditingController();

  void toast(String a) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("$a"), duration: Duration(milliseconds: 400)),
    );
  }

  void push_data() {
    setState(() {
      if (txtController.text.isNotEmpty) {
        notes.add(txtController.text);
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
            "Are you sure you want to delete all the\n $size notes?",
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
                      toast("All notes deleted");
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
          toast("No notes to delete");
        }
      } else {
        if (notes.isNotEmpty) {
          dialog();
        } else {
          toast("Long press to delete all the notes");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffece5dd),
      body: Column(
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
              decoration: BoxDecoration(
                color: Color(0x1f000000),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.zero,
                border: Border.all(color: Color(0x4d9e9e9e), width: 1),
              ),
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
                          color: Color(0xff075e54),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.zero,
                          border: Border.all(
                            color: Color(0x4d9e9e9e),
                            width: 1,
                          ),
                        ),
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
                              icon: Icon(Icons.arrow_back,color: Colors.white),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.blue,
                                child: Icon(Icons.person, color: Colors.white),
                              ),
                            ),

                            Text(
                              "Recipient",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () {
                                toast("Video calls coming soon...");
                              },
                              icon: Icon(Icons.video_camera_front_outlined,color: Colors.white),
                            ),
                            IconButton(
                              onPressed: () {
                                toast("Voice calls coming soon...");
                              },
                              icon: Icon(Icons.call,color: Colors.white),
                            ),
                            IconButton(
                              onPressed: () {
                                toast("Cloud sync coming soon...");
                              },
                              icon: Icon(Icons.more_vert,color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    flex: 1,
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      children: notes.map((item) {
                        return Card(
                          color: Color(0xffdcf8c6),
                          elevation: 10,
                          child: ListTile(title: Text(item)),
                        );
                      }).toList(),
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
            height: MediaQuery.of(context).size.height * 0.1,
            decoration: BoxDecoration(
              color: Color(0x1f000000),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.zero,
              border: Border.all(color: Color(0x4d9e9e9e), width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: txtController,
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
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(
                          color: Color(0xff000000),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(
                          color: Color(0xff000000),
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(
                          color: Color(0xff000000),
                          width: 1,
                        ),
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
                MaterialButton(
                  onPressed: () {
                    if (txtController.text.isNotEmpty) {
                      push_data();
                    } else {
                      toast("Voice notes coming soon!!");
                    }
                  },
                  color: Color(0xffffffff),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Color(0xff808080), width: 1),
                  ),
                  padding: EdgeInsets.all(16),
                  textColor: Color(0xff000000),
                  height: MediaQuery.of(context).size.height,
                  minWidth: 140,
                  child: Icon(
                    Icons.mic,
                    color: Color(0xff000000),
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
