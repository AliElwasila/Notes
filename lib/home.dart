import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_notes/addnote.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'edit.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   var prefValue;
  setPref(var name) async {
    SharedPreferences preferences =  await SharedPreferences.getInstance();
    preferences.setString('UserName', name);
  }
  Future getPref() async {
    SharedPreferences preferences =  await SharedPreferences.getInstance();
    var _username = await preferences.getString('UserName');
    if(_username == null){
      _displayTextInputDialog(context);
    }
    else {
         prefValue = _username;
         _showMyDialog();
    }

  }
  TextEditingController _textFieldController = TextEditingController();

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Your Name Please'  ,style:
                GoogleFonts.kottaOne( fontSize: 18),),
            content: TextField(
              // onChanged: (value) {
              //   setState(() {
              //     valueText = value;
              //   });
              // },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "User Name",hintStyle:
                  GoogleFonts.kottaOne( fontSize: 18),),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('CANCEL'  ,style:
          GoogleFonts.kottaOne( fontSize: 18),),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              TextButton(
                child: Text('OK',  style:
                GoogleFonts.kottaOne( fontSize: 18),),
                onPressed: () {
                  setState(() {
                    setPref(_textFieldController.text);
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
          title: Text('Your Notes Keeper',
            style:
            GoogleFonts.kottaOne( fontSize: 18),),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Welcome $prefValue',
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
                //Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void initState() {
    // TODO: implement initState
    getPref();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.sort,
              color: Colors.white,
            ),
            onPressed: () {
            },
          )
        ],
        centerTitle: true,
        titleSpacing: 5.0,
        elevation: 5.0,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(125.0),
            bottomRight: Radius.circular(125.0),
          ),
        ),
        title: Text('My Notes',style: GoogleFonts.kottaOne(fontWeight: FontWeight.bold,fontSize: 22),),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Stack(
            //fit: StackFit.expand,
            children: [
              Center(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('Notes').snapshots(),
                  builder: (BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot){
                    if(! snapshot.hasData){
                      return Center(child: CircularProgressIndicator(),);
                    }
                    return ListView(
                      children: snapshot.data!.docs.map((document){
                        return  Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return Update(document.get('body'),document.id,);
                                }),
                              );
                            },
                            child: Card(
                              shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50.0),
                                ),
                              ),
                              elevation: 3.0,
                              child: Container(
                                height: MediaQuery.of(context).size.height * .20,
                                decoration: BoxDecoration(
                                  color: Colors.brown[100],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20.0),
                                  ),
                                ),
                                child: Center(
                                  child: Text("${document.get('body')}",style: GoogleFonts.kottaOne(fontSize: 20),),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      );
                  },
                ),
              ),
              ],)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return AddNote();
            }),
          );
        },
        elevation: 5.0,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25.0),
          ),
        ),
        backgroundColor: Colors.teal[400],
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
