import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/users.dart';

class DatabaseService{

  final String uid;
  DatabaseService({ required this.uid });

  // collection reference
  final CollectionReference users = FirebaseFirestore.instance.collection('Users');

  Future updateUserInfo(String name, String phoneNumber, String email) async {
    return await users.doc(uid).set({
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'aptDate': "",
      'aptTime': "",
      'day': "",
    });
  }

  // user list from snapshot
  List<Users> _userListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Users(
        aptDate: doc.get('aptDate') ?? '',
        aptTime: doc.get('aptTime') ?? '',
        day: doc.get('day') ?? '',
        email: doc.get('email') ?? '',
        name: doc.get('name') ?? '',
        phoneNumber: doc.get('phoneNumber') ?? '',
      );
    }).toList();
  }

  // get stream
  Stream<List<Users>> get userInfo {
    return users.snapshots().map(_userListFromSnapshot);
  }
}