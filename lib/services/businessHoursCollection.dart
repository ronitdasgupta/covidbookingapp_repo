import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';
import '../models/users.dart';

class BusinessHoursCollection{

  //final String day;
  //BusinessHoursCollection({ required this.day });
  final String day1 = "Sunday";
  final String day2 = "Monday";
  final String day3 = "Tuesday";
  final String day4 = "Wednesday";
  final String day5 = "Thursday";
  final String day6 = "Friday";
  final String day7 = "Saturday";

  // collection reference
  //final CollectionReference users = FirebaseFirestore.instance.collection('Users');
  final CollectionReference businessHours = FirebaseFirestore.instance.collection('BusinessHours');
  //final CollectionReference appointments = FirebaseFirestore.instance.collection('Appointments');

  /*
  Future updateUserInfo(String name, String phoneNumber, String email) async {
    return await businessHours.doc(day).set({
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'aptDate': "",
      'aptTime': "",
      'day': "",
    });
  }
   */

  Future updateBusinessHoursInfoSunday(String start, String end, bool isholiday, int slotintervals, List<String> slots) async {
    return await businessHours.doc(day1).set({
      'start': start,
      'end': end,
      'isholiday': isholiday,
      'slotintervals': slotintervals,
      'slots': slots,
    });
  }

  Future updateBusinessHoursInfoMonday(String startTime, String endTime, bool isHoliday, Duration slotLength, List<String> slots) async {
    return await businessHours.doc(day2).set({
      'startTime': startTime,
      'endTime': endTime,
      'isHoliday': isHoliday,
      'slotLength': slotLength,
      'slots': slots,
    });
  }

  Future updateBusinessHoursInfoTuesday(String startTime, String endTime, bool isHoliday, Duration slotLength, List<String> slots) async {
    return await businessHours.doc(day3).set({
      'startTime': startTime,
      'endTime': endTime,
      'isHoliday': isHoliday,
      'slotLength': slotLength,
      'slots': slots,
    });
  }

  Future updateBusinessHoursInfoWednesday(String startTime, String endTime, bool isHoliday, Duration slotLength, List<String> slots) async {
    return await businessHours.doc(day4).set({
      'startTime': startTime,
      'endTime': endTime,
      'isHoliday': isHoliday,
      'slotLength': slotLength,
      'slots': slots,
    });
  }

  Future updateBusinessHoursInfoThursday(String startTime, String endTime, bool isHoliday, Duration slotLength, List<String> slots) async {
    return await businessHours.doc(day5).set({
      'startTime': startTime,
      'endTime': endTime,
      'isHoliday': isHoliday,
      'slotLength': slotLength,
      'slots': slots,
    });
  }

  Future updateBusinessHoursInfoFriday(String startTime, String endTime, bool isHoliday, Duration slotLength, List<String> slots) async {
    return await businessHours.doc(day6).set({
      'startTime': startTime,
      'endTime': endTime,
      'isHoliday': isHoliday,
      'slotLength': slotLength,
      'slots': slots,
    });
  }

  Future updateBusinessHoursInfoSaturday(String startTime, String endTime, bool isHoliday, Duration slotLength, List<String> slots) async {
    return await businessHours.doc(day7).set({
      'startTime': startTime,
      'endTime': endTime,
      'isHoliday': isHoliday,
      'slotLength': slotLength,
      'slots': slots,
    });
  }

  // get businessInfo stream
  Stream<QuerySnapshot> get businessInfo {
    return businessHours.snapshots();
  }

  /*
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

  // appointment times from snapshot


  // get stream
  Stream<List<Users>> get userInfo {
    return users.snapshots().map(_userListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData{
    return users.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

// get appointments doc stream
   */

}