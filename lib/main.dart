import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // setPref(var name) async {
  //   SharedPreferences preferences =  await SharedPreferences.getInstance();
  //   preferences.setString('UserName', name);
  // }
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.brown[400],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal[400],
        ),
      ),
      home: HomePage(),
    );
  }
}

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'My Notes',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         backgroundColor: Colors.brown[400],
//         appBarTheme: AppBarTheme(
//           backgroundColor: Colors.teal[400],
//         ),
//       ),
//       home: HomePage(),
//     );
//   }
// }

