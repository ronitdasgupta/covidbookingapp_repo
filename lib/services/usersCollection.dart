import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';
import '../models/users.dart';

class UsersCollection{

  final String uid;
  UsersCollection({ required this.uid });


  // collection reference
  final CollectionReference users = FirebaseFirestore.instance.collection('Users');
  final CollectionReference businessHours = FirebaseFirestore.instance.collection('BusinessHours');
  final CollectionReference appointments = FirebaseFirestore.instance.collection('Appointments');

  // writes to users collection
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

  Future updateUserAppointment(String name, String phoneNumber, String email, String aptDate, String aptTime, String day) async {
    return await users.doc(uid).set({
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'aptDate': aptDate,
      'aptTime': aptTime,
      'day': day,
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

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      aptDate: snapshot['aptDate'],
      aptTime: snapshot['aptTime'],
      day: snapshot['day'],
      email: snapshot['email'],
      name: snapshot['name'],
      phoneNumber: snapshot['phoneNumber'],
    );
  }

  // get stream
  Stream<List<Users>> get userInfo {
    return users.snapshots().map(_userListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData{
    return users.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

}