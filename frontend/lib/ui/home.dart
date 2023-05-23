import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:iconsax/iconsax.dart';
import 'package:parallels/api/list.dart';
import 'package:provider/provider.dart';
import '../api/correct.dart';
import '../api/improve.dart';
import '../api/listify.dart';
import '../state/authState.dart';

class HomePage extends StatefulWidget {
  @override
  _RealtimeNotePageState createState() => _RealtimeNotePageState();
}

class _RealtimeNotePageState extends State<HomePage> {
  String note = "";
  double rate = 0;
  double opacity = -5;
  late TextEditingController _note;
  late TextEditingController _prompt;
  DatabaseReference? _noteRef;
  String _noteText = "";
  double x = 0;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    AuthState state = Provider.of<AuthState>(context, listen: false);
    retrieveVal();

    _note = TextEditingController();
    _prompt = TextEditingController();
    _noteRef =
        FirebaseDatabase.instance.reference().child("note/${state.userId}");
    _noteRef!.onValue.listen((event) {
      setState(() {
        dynamic data = event.snapshot.value;
        String note = data["note"];
        _noteText = note;
      });
    });
  }

  Future retrieveVal() async {
    AuthState state = Provider.of<AuthState>(context, listen: false);
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("note/${state.userId}");
    DatabaseEvent event = await ref.once();
    setState(() {
      dynamic data = event.snapshot.value;
      String note = data["note"];
      _note.text = note;
    });
  }

  @override
  void dispose() {
    _prompt.dispose();
    _note.dispose();
    _noteRef!.onDisconnect();
    super.dispose();
  }

  void _saveNote() async {
    AuthState state = Provider.of<AuthState>(context, listen: false);
    DatabaseReference _noteRef = FirebaseDatabase.instance.ref("note");
    // String note = await corrigerFautes(_note.text);
    _noteRef.child(state.userId).set({'note': _note.text});
  }

  void _saveNoteAndPrompt() async {
    AuthState state = Provider.of<AuthState>(context, listen: false);
    DatabaseReference _noteRef = FirebaseDatabase.instance.ref("note");
    // String note = await corrigerFautes(_note.text);
    _noteRef.child(state.userId).set({'note': _note.text});
    // .set({'note': _prompt.text + "\n" + _note.text});
  }

  double magic = 0;
  Widget _notes(BuildContext context,
      {required TextEditingController controller}) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: TextField(
            focusNode: _focusNode,
            maxLines: 100,
            onChanged: (value) async {
              if (_note.text.length % 40 == 0 && _note.text.length != 0) {
                _note.text = await listifyStr(_note.text);
              }
              _saveNote();
              setState(() {
                _note.text;
              });
            },
            cursorColor: Color.fromARGB(255, 53, 34, 85),
            keyboardAppearance: Brightness.light,
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
            controller: controller,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(0, 0, 0, 0), width: 0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 0),
                ),
                hintText: "Une idée? 💡",
                hintStyle: TextStyle(color: Colors.black))));
  }

  @override
  Widget build(BuildContext context) {
    AuthState state = Provider.of<AuthState>(context, listen: false);
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 20,
              width: 30,
            ),
            GestureDetector(
                onTap: () {
                  correctStr(_note.text);
                  String note = _note.text;
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        title: Text('Something to add?'),
                        content: TextField(
                          onSubmitted: (value) {
                            correctStr(_prompt.text);
                            _saveNoteAndPrompt();
                            _prompt.clear();
                            Navigator.of(context).pop();
                          },
                          controller: _prompt,
                          onChanged: (value) {
                            setState(() {
                              _note.text = '* ${_prompt.text}\n$note';
                            });
                          },
                          decoration: InputDecoration(
                              hintText: 'Type something here...'),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              _note.text = note;
                              _prompt.clear();
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              correctStr(_prompt.text);
                              _saveNoteAndPrompt();
                              _prompt.clear();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                        color: Color.fromARGB(255, 53, 34, 85).withOpacity(1),
                        width: 60,
                        height: 60,
                        child: Icon(
                          Iconsax.add,
                          color: Colors.white,
                          size: 30,
                        )))),
            Container(
              height: 20,
              width: MediaQuery.of(context).size.width / 2,
            ),
            GestureDetector(
                onTap: () async {
                  String note = await correctStr(_note.text);
                  _note.text = await listifyStr(_note.text);
                  _saveNote();
                  // _note.text = note;
                },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: AnimatedContainer(
                        height: 60,
                        width: 60,
                        color: _note.text.length % 50 == 0 &&
                                _note.text.length != 0
                            ? Colors.red
                            : Color.fromARGB(255, 53, 34, 85).withOpacity(1),
                        duration: Duration(milliseconds: 11),
                        child: Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Transform.rotate(
                              angle: magic,
                              child: Text(
                                "🪄",
                                style: TextStyle(fontSize: 29),
                                textAlign: TextAlign.center,
                              )),
                        ))))
          ],
        ),
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              state.logoutCallback();
              Navigator.pop(context);
            },
            child: Icon(Iconsax.heart),
          ),
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 53, 34, 85).withOpacity(1),
          centerTitle: false,
          title: Text(
            'Welcome ${state.userModel?.displayName ?? "Home"} 👋',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 25),
          ),
        ),
        extendBodyBehindAppBar: false,
        body: GestureDetector(
            onHorizontalDragUpdate: (details) {
              if (details.delta.dx > 0) {
                _focusNode.unfocus();
              }
            },
            child: Stack(
              children: [
                NotificationListener(
                    onNotification: (v) {
                      if (v is ScrollUpdateNotification) {
                        setState(() {
                          rate -= v.scrollDelta! / 1;
                        });
                      }
                      return true;
                    },
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        _notes(context, controller: _note),
                      ],
                    )),
              ],
              alignment: Alignment.center,
            )));
  }
}
