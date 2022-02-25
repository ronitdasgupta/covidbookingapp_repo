import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String uid;
  DatabaseService({ required this.uid });

  // collection reference
  final CollectionReference users = FirebaseFirestore.instance.collection('userInformation');

  Future updateUserInfo(String name, String phoneNumber, String email, String aptDate, String aptTime) async {
    return await users.doc(uid).set({
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'aptDate': aptDate,
      'aptTime': aptTime,
    });
  }
}