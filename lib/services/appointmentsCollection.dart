import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidbookingapp_repo/models/appointmentInfo.dart';

class AppointmentsCollection {
  // collection reference

  //final CollectionReference appointments = FirebaseFirestore.instance.collection('Appointments');

  final String dateString;

  AppointmentsCollection({ required this.dateString });

  // appointment info for selected date
  /*
  AppointmentsInfo _appointmentDataFromSnapshot(DocumentSnapshot snapshot){

    return AppointmentsInfo(
      appointments: snapshot[],
      day: day,
    );
  }
   */

  /*
  final CollectionReference appointments = FirebaseFirestore.instance.collection('Appointments');

  // appointments list from snapshot
  List<AppointmentsInfo> _appointmentsListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return AppointmentsInfo(
        appointmentslots: doc.get('appointmentslots') ?? '',
        day: doc.get('day') ?? '',
      );
      // initially returns an iterable
    }).toList();
  }

  // get appointments stream
  Stream<List<AppointmentsInfo>> get apt {
    return appointments.snapshots().map(_appointmentsListFromSnapshot);
  }
   */

  /*
  var collection = FirebaseFirestore.instance.collection('users');
  var docSnapshot = await collection.doc('some_id').get();
  if (docSnapshot.exists) {
  Map<String, dynamic> data = docSnapshot.data()!;

  // You can then retrieve the value from the Map like this:
  var name = data['name'];
  }
   */

  /*
  Stream<DocumentSnapshot> provideDocumentFieldStream() {
    return FirebaseFirestore.instance.collection('Appointments').doc(dateString).snapshots();
  }

  StreamBuilder<DocumentSnapshot> (
      stream: provideDocumentFieldStream(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if(snapshot.hasData) {
          Map<String, dynamic> documentFields = snapshot.data.data;
          return Text(documentFields['testing']);
  }
  }
      )
   */


    //void getAppointmentsInfo() {
    //FirebaseFirestore rootRef = FirebaseFirestore.getInstance
    //CollectionReference applicationsRef = rootRef.collection("applications");

    //DocumentReference dateDoc = appointments.doc(dateString);
    //Future<DocumentSnapshot> docSnapshot = dateDoc.get();
    //print(docSnapshot);
    //print(docSnapshot['appointmentslots']);
    //AppointmentsInfo appointmentInfo = new AppointmentsInfo()
    /*
    applicationIdRef.get().addOnCompleteListener(task -> {
    if (task.isSuccessful()) {
    DocumentSnapshot document = task.getResult();
    if (document.exists()) {
    List<Map<String, Object>> users = (List<Map<String, Object>>) document.get("users");
    }
    }
    });
     */


  }



  // day from snapshot

  // get stream
  /*
  Stream<List<Appointment>> get appointmentInfo {
    return appointments.snapshots().map(_appointmentsListFromSnapshot);
  }
   */
//}