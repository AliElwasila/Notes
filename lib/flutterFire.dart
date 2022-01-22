import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

create(note) async {
  try {
    await FirebaseFirestore.instance.collection('Notes').doc(Random().nextInt(999).toString()).set(
        {'body': note});
  }
  catch(e){
    print(e);
  }
}
update(id,note) async {
  try {
    await FirebaseFirestore.instance.collection('Notes').doc(id).update(
        {'body': note});
  }
  catch(e){
    print(e);
  }
}

delete(id) async {
  try {
    await FirebaseFirestore.instance.collection('Notes').doc(id).delete();
  }
  catch(e){
    print(e);
  }
}
// sort() async {
//   try {
//     await FirebaseFirestore.instance.collection('Notes').orderBy('body',descending: true);
//   }
//   catch(e){
//     print(e);
//   }
// }