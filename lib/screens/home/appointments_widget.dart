import 'package:covidbookingapp_repo/models/appointmentInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppointmentsWidget extends StatelessWidget {
  //const AppointmentsWidget({Key? key}) : super(key: key);

  final AppointmentsInfo appointmentsInfo;

  AppointmentsWidget({ required this.appointmentsInfo });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.black,
            ),
            title: Text('Appointment Info'),
            subtitle: Text('Appointment Date: ${appointmentsInfo
                .appointmentslots} \nAppointment Time: ${appointmentsInfo
                .day}'),
          ),
        )
    );
  }
}

