import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidbookingapp_repo/models/businessHours.dart';

import '../models/user.dart';
import '../models/users.dart';

class BusinessHourDayCollection{

  final String dayOfWeek;

  BusinessHourDayCollection({ required this.dayOfWeek });

  // collection reference
  final CollectionReference businessHoursCollection = FirebaseFirestore.instance.collection('BusinessHours');

  Future updateBusinessHoursInfo(String start, String end, bool isholiday, int slotintervals, List<String> slots, String day) async {
    return await businessHoursCollection.doc(dayOfWeek).set({
      'start': start,
      'end': end,
      'isholiday': isholiday,
      'slotintervals': slotintervals,
      'slots': slots,
      'day': day,
    });
  }

  // business info from snapshot


  List<BusinessHours> _businessHoursFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      return BusinessHours(
        day: doc.get('day') ?? '',
        start: doc.get('start') ?? '',
        end: doc.get('end') ?? '',
        isholiday: doc.get('isholiday') ?? true,
        slotintervals: doc.get('slotintervals') ?? 0,
        // slots: doc.get('slots') ?? List<String>,
        slots: List.from(doc.get('slots')),
      );
    }).toList();
  }



  /*
  BusinessHours _businessHoursFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return BusinessHours(
          start: doc.get('start') ?? '',
          end: doc.get('end') ?? '',
          isholiday: doc.get('isholiday') ?? true,
          slotintervals: doc.get('slotintervals') ?? 0,
          slots: doc.get('slots') ?? List<String>,
    })
  }
   */

  // stream business hours for a day

  Stream<BusinessHours> get businessHoursForADayFromSnapshot {
    // return businessHoursCollection.doc(dayOfWeek).snapshots().map(_businessInfoFromSnapshot);
    return businessHoursCollection.doc(dayOfWeek).snapshots().map<BusinessHours>(_businessInfoFromSnapshot);
  }


  // business info from snapshot
  BusinessHours _businessInfoFromSnapshot(DocumentSnapshot snapshot) {
    return BusinessHours(
        day: snapshot['day'],
        start: snapshot['start'],
        end: snapshot['end'],
        isholiday: snapshot['isholiday'],
        slotintervals: snapshot['slotintervals'],
        // slots: snapshot['slots'],
        slots: List.from(snapshot['slots']),
        );
  }


  // gets business hours for a specific day
  /*
  Stream<QuerySnapshot> get slots {
    return businessHoursCollection.snapshots();
  }
   */


  /*
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
   */

  // get businessInfo stream
  Stream<List<BusinessHours?>> get businessInfo {
    return businessHoursCollection.snapshots().map(_businessHoursFromSnapshot);
  }

}