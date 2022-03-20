import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidbookingapp_repo/screens/home/days_list.dart';
import 'package:covidbookingapp_repo/screens/home/days_widget.dart';
import 'package:covidbookingapp_repo/screens/wrapper.dart';
import 'package:covidbookingapp_repo/services/appointmentsCollection.dart';
import 'package:covidbookingapp_repo/services/auth.dart';
import 'package:covidbookingapp_repo/services/businessHourDayCollection.dart';
import 'package:covidbookingapp_repo/services/businessHoursCollection.dart';
import 'package:covidbookingapp_repo/services/usersCollection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//import 'models/user.dart';
import 'package:covidbookingapp_repo/models/user.dart';

import 'models/appointmentInfo.dart';
import 'models/businessHours.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<MyUser?>.value(
          value: AuthService().user,
          initialData: null,
        ),
        StreamProvider<List<BusinessHours>>.value(
          value: BusinessHoursCollection().businessInfo,
          initialData: [],
        ),
        StreamProvider<List<AppointmentsInfo>>.value(
          value: AppointmentsCollection().appointmentInfo,
          initialData: [],
        ),
      ],
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}