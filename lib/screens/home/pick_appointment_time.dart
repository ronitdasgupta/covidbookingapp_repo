import 'package:covidbookingapp_repo/models/appointmentInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PickAppointmentTime extends StatefulWidget {
  const PickAppointmentTime({Key? key}) : super(key: key);

  @override
  _PickAppointmentTimeState createState() => _PickAppointmentTimeState();
}

class _PickAppointmentTimeState extends State<PickAppointmentTime> {

  bool isChanged = true;
  String buttonText2 = "Select Time";

  @override
  Widget build(BuildContext context) {

    final appointmentInfo = Provider.of<AppointmentsInfo>(context);
    print(appointmentInfo);

      return Container(
        child: ElevatedButton(
            child: Text(
              "Select Time",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              isChanged =! isChanged;
              setState(() {
                isChanged == true ? buttonText2 = "Select Time" : buttonText2 = "4:00";
              });
            }
        ),
      );

  }
}
