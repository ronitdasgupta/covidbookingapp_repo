import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidbookingapp_repo/models/businessHours.dart';
import 'package:flutter/cupertino.dart';

import '../models/user.dart';
import '../models/users.dart';

class BusinessHoursCollection{

  // collection reference
  final CollectionReference businessHoursCollection = FirebaseFirestore.instance.collection('BusinessHours');

  // business info from snapshot

   List<BusinessHours> _businessHoursFromSnapshot(QuerySnapshot snapshot)  {
    try{
      return snapshot.docs.map<BusinessHours>((doc){
        return BusinessHours(
          day: doc.get('day') ?? '',
          start: doc.get('start') ?? '',
          end: doc.get('end') ?? '',
          isholiday: doc.get('isholiday') ?? true,
          slotintervals: doc.get('slotintervals') ?? 0,
          slots: List.from(doc.get('slots')),
        );
      }).toList();
    } catch(e) {
      print("_businessHoursFromSnapshot not working");
      return snapshot.docs.map<BusinessHours>((doc){
        return BusinessHours(
          day: doc.get('day') ?? '',
          start: doc.get('start') ?? '',
          end: doc.get('end') ?? '',
          isholiday: doc.get('isholiday') ?? true,
          slotintervals: doc.get('slotintervals') ?? 0,
          slots: List.from(doc.get('slots')),
        );
      }).toList();
    }
  }

  // get businessInfo stream
  Stream<List<BusinessHours>> get businessInfo {
      return businessHoursCollection.snapshots().map<List<BusinessHours>>(_businessHoursFromSnapshot);
  }

}