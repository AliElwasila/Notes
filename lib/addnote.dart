import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'flutterFire.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController note = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
            title: Text('ADD Note',
              style:
              GoogleFonts.kottaOne( fontSize: 18),),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Note Added',
                    style:
                    GoogleFonts.kottaOne( fontSize: 18),),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child:  Text('ok',
                  style:
                  GoogleFonts.kottaOne(color: Colors.brown, fontSize: 18),),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 5.0,
        elevation: 5.0,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(125.0),
            bottomRight: Radius.circular(125.0),
          ),
        ),
        title: Text(
          'Add Note',
          style: GoogleFonts.kottaOne(fontWeight: FontWeight.bold,fontSize: 22),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 150,
            left: 30,
            right: 30,
            child: Card(
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(150.0),
                ),
              ),
              elevation: 3.0,
              child: Container(
                padding: EdgeInsets.all(70.0),
                height: MediaQuery.of(context).size.height * .30,
                width: MediaQuery.of(context).size.width * .80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                  color: Colors.brown[100],
                ),
                child: TextField(
                  controller: note,
                  maxLines: 50,
                  style: GoogleFonts.kottaOne(fontSize: 20),
                ),
              ),
            ),
          ),
          Positioned(
            top: 450,
            left: 80,
            right: 80,
            child: Card(
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(100.0),
                ),
              ),
              elevation: 30.0,
              child: Container(
                height: MediaQuery.of(context).size.height * .07,
                width: MediaQuery.of(context).size.width * .30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                  color: Colors.teal[400],
                ),
                child: TextButton(
                  onPressed: () {
                    // update(widget._noteid.toString(),note.text);
                    // print('the id is ${widget._noteid} and the updae is ${note.text} ');
                    // note.clear();
                    create(note.text);
                    _showMyDialog();
                    note.clear();

                  },
                  child: Text(
                    'Add Note',
                    style:
                        GoogleFonts.kottaOne(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
