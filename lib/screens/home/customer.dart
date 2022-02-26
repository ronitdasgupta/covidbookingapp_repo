import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../models/users.dart';
import '../../services/auth.dart';
import 'package:covidbookingapp_repo/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidbookingapp_repo/screens/home/user_list.dart';

class Customer extends StatefulWidget {
  @override
  State<Customer> createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {

  final AuthService _auth = AuthService();

  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  //const Customer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    void _showAppointmentInfo(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: Text('bottom sheet'),
        );
      });
    }


    return StreamProvider<List<Users>?>.value(
      value: DatabaseService(uid: '').userInfo,
      initialData: null,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              title: Text('Select Appointment'),
              backgroundColor: Colors.black,
              actions: <Widget>[
                TextButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Logout'),
                  onPressed: () async {
                    await _auth.signOut();
                  },
                )
              ]
          ),
        //body: UserList(),
        body: TableCalendar(
          focusedDay: selectedDay,
          firstDay: DateTime.now(),
          lastDay: DateTime(2050),
          calendarFormat: format,
          onFormatChanged: (CalendarFormat _format){
            setState(() {
              format = _format;
            });
          },
          onDaySelected: (DateTime selectDay, DateTime focusDay){
            setState((){
              selectedDay = selectDay;
              focusedDay = focusDay;
            });
            _showAppointmentInfo();
            //print(focusedDay);
          },
          calendarStyle: CalendarStyle(
            isTodayHighlighted: true,
            selectedDecoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            selectedTextStyle: TextStyle(color: Colors.white),
          ),
          selectedDayPredicate: (DateTime date){
            return isSameDay(selectedDay, date);
          },
          //startingDayOfWeek: StartingDayOfWeek.sunday,
        ),
      ),
    );
  }
}
