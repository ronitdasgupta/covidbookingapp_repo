import 'package:covidbookingapp_repo/models/appointmentInfo.dart';
import 'package:covidbookingapp_repo/screens/home/appointments_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class AppointmentsList extends StatefulWidget {
  //const AppointmentsList({Key? key}) : super(key: key);

  @override
  _AppointmentsListState createState() => _AppointmentsListState();
}

class _AppointmentsListState extends State<AppointmentsList> {
  @override
  Widget build(BuildContext context) {

    final apt = Provider.of<List<AppointmentsInfo>?>(context);
    apt?.forEach((appointment){
      print(appointment.appointmentslots);
      print(appointment.day);
    }
    );

    if (apt != null && apt.isNotEmpty)
    {
      return ListView.builder(
        itemCount: apt.length,
        itemBuilder: (context, index){
          return AppointmentsWidget(appointmentsInfo: apt[index]);
        },
      );
    } else{
      return Container();
    }
  }
}
