import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidbookingapp_repo/models/appointmentInfo.dart';

class AppointmentsCollection {
  // collection reference

  final CollectionReference appointments = FirebaseFirestore.instance.collection('Appointments');



  // appointment info for selected date
  Future updateAppointment(AppointmentsInfo appointmentsInfo) async {
    try{
      return await appointments.doc(appointmentsInfo.selectedDate).set({
        'appointmentslots' : appointmentsInfo.appointmentslots,
        // 'appointmentslots' : jsonDecode(source)
        'day' : appointmentsInfo.day,
        'selecteddate' : appointmentsInfo.selectedDate,
      }, SetOptions(merge: true));
    } catch(e){
      print(e.toString());
    }

  }

  Future deleteAppointment(String appointmentDate) async {
    try {
      return await appointments.doc(appointmentDate).delete();
    } catch(e) {
      print(e.toString());
    }
  }

  List<AppointmentsInfo> _appointmentInfoFromSnapshot(QuerySnapshot snapshot) {
    List<AppointmentsInfo> arrayOfAptInfo = [];
    snapshot.docs.forEach((eachDate) {
      AppointmentsInfo eachAptInfo = AppointmentsInfo(
        appointmentslots: eachDate['appointmentslots'],
        // appointmentslots: AppointmentSlot.fromJsonArray(eachDate['appointmentslots']),
        // appointmentslots: eachDate['appointmentslots'],
        day: eachDate['day'],
        selectedDate: eachDate['selecteddate'],
      );
      arrayOfAptInfo.add(eachAptInfo);
    });
    return arrayOfAptInfo;
  }

  Stream<List<AppointmentsInfo>> get appointmentInfo {
      return appointments.snapshots().map<List<AppointmentsInfo>>(_appointmentInfoFromSnapshot);
  }

  }