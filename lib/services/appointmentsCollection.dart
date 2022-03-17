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

  List<AppointmentsInfo> _appointmentInfoFromSnapshot(QuerySnapshot snapshot) {
    try{
      return snapshot.docs.map<AppointmentsInfo>((doc){
        return AppointmentsInfo(
          // appointmentslots: doc.get('appointmentslots'),
          day: doc.get('day'),
        );
      }).toList();
    } catch(e) {
      print("_appointmentInfoFromSnapshot not working");
      return snapshot.docs.map<AppointmentsInfo>((doc){
        return AppointmentsInfo(
          // appointmentslots: doc.get('appointmentslots'),
          day: doc.get('day'),
        );
      }).toList();
    }
  }

  Stream<List<AppointmentsInfo>> get appointmentInfo {
    try{
      return appointments.snapshots().map<List<AppointmentsInfo>>(_appointmentInfoFromSnapshot);
    } catch(e) {
      print("Stream function not working");
      return appointments.snapshots().map<List<AppointmentsInfo>>(_appointmentInfoFromSnapshot);
    }
  }




  }