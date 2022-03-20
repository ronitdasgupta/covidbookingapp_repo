import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidbookingapp_repo/models/appointmentInfo.dart';

class AppointmentsCollection {
  // collection reference

  final CollectionReference appointments = FirebaseFirestore.instance.collection('Appointments');



  // appointment info for selected date


  /*
  AppointmentsInfo _appointmentInfoFromSnapshot(DocumentSnapshot snapshot){
    return AppointmentsInfo(
      appointmentslots: snapshot['appointmentslots'],
      day: snapshot['day'],
    );
  }

  Stream<AppointmentsInfo> get appointmentInfo {
    return appointments.doc(dateString).snapshots().map<AppointmentsInfo>(_appointmentInfoFromSnapshot);
  }
   */


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



  /*
  Future updateAppointment(AppointmentsInfo appointmentsInfo) async {
    try{
      return await appointments.doc(appointmentsInfo.selectedDate).update(appointmentsInfo.appointmentslots[0]);
    } catch(e){
      print(e.toString());
    }

  }
   */


  /*
  Future updateAppointment(AppointmentsInfo appointmentsInfo) async {
    return await appointments.doc(appointmentsInfo.selectedDate).update(appointmentsInfo);
  }
   */


  /*
  Future updateAppointment(AppointmentsInfo appointmentsInfo) async {
    return await appointments.doc(appointmentsInfo.selectedDate).set(AppointmentsInfo);
  }
   */


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

  /*
  List<AppointmentsInfo> _appointmentInfoFromSnapshot(QuerySnapshot snapshot) {
    try{
      return snapshot.docs.map<AppointmentsInfo>((doc){
        return AppointmentsInfo(
          // appointmentslots: doc.get('appointmentslots'),
          // appointmentslots: Map.from(doc.get('appointmentslots')),
          appointmentslots: doc.get('appointmentslots') as List<dynamic>,
          day: doc.get('day'),
        );
      }).toList();
    } catch(e) {
      print("_appointmentInfoFromSnapshot not working");
      return snapshot.docs.map<AppointmentsInfo>((doc){
        return AppointmentsInfo(
          // appointmentslots: doc.get('appointmentslots'),
          // appointmentslots: Map.from<dynamic, dynamic>(doc.get('appointmentslots')),
          day: doc.get('day'),
        );
      }).toList();
    }
  }
   */


  Stream<List<AppointmentsInfo>> get appointmentInfo {
      return appointments.snapshots().map<List<AppointmentsInfo>>(_appointmentInfoFromSnapshot);
  }




  }