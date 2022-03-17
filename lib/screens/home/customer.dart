import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidbookingapp_repo/models/appointmentInfo.dart';
import 'package:covidbookingapp_repo/services/businessHourDayCollection.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../models/businessHours.dart';
import '../../models/user.dart';
import '../../models/users.dart';
import '../../services/auth.dart';
import 'package:covidbookingapp_repo/services/usersCollection.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidbookingapp_repo/screens/home/user_list.dart';
import 'package:covidbookingapp_repo/services/appointmentsCollection.dart';

import '../../services/businessHoursCollection.dart';

class Customer extends StatefulWidget {
  @override
  State<Customer> createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {

  final AuthService _auth = AuthService();

  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  String buttonText1 = "Select Date";
  String buttonText2 = "Select Time";
  bool isChanged = true;

  DateTime? date;

  String getText() {
    if(date == null) {
      return "Select Date";
    } else {
      return "${date?.month}/${date?.day}/${date?.year}";
    }
  }

  //final Stream<QuerySnapshot> BusinessHours = FirebaseFirestore.instance.collection('BusinessHours').snapshots();
  //final Stream<QuerySnapshot> Appointments = FirebaseFirestore.instance.collection('Appointments').snapshots();

  //Stream<List<Appointments>> readAppointments() => FirebaseFirestore.instance.collection("Appoingments").snapshots().map((snapshot) => snapshot.docs.map((doc) => AppointmentsInfo..data()).toList());

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

    Future pickDate (BuildContext context) async {
      final initialDate = DateTime.now();
      final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2030),
      );

      if(newDate == null){
        return;
      }

      setState(() => date = newDate);

    }

    final user = Provider.of<MyUser?>(context);
    print(user);

    final allBusinessHours = Provider.of<List<BusinessHours>>(context);
    print(allBusinessHours);

    final allAppointments = Provider.of<List<AppointmentsInfo>>(context);
    print(allAppointments);



    /*
    final users = Provider.of<List<Users>?>(context);
    print(users);
     */

    // final slots = Provider.of<QuerySnapshot>(context);
    // print(slots);

      //return StreamProvider<List<AppointmentsInfo>?>.value(
        //value: AppointmentsCollection(dateString: '').apt,
        //initialData: null,
        //initialData: null,
              return Scaffold(
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
                //body: AppointmentsList(),
              body: Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Date",
                        style: TextStyle(
                            fontSize: 20.0
                        ),
                      ),
                      ElevatedButton(
                        child: Text(
                          getText(),
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          isChanged = !isChanged;
                          pickDate(context);
                          setState(() {
                            isChanged == true ? buttonText1 = "Select Date" : buttonText1 = "${date?.month}/${date?.day}/${date?.year}";
                          });
                        },
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        "Time",
                        style: TextStyle(
                          fontSize: 20.0
                        ),
                      ),
                      ElevatedButton(
                        child: Text(
                          "Select Time",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          isChanged =! isChanged;
                          // PUT SOMETHING HERE
                          setState(() {
                            isChanged == true ? buttonText2 = "Select Time" : buttonText2 = "4:00";
                          });
                        }
                      ),
                    ],
                  ),
                ),
              ),




                /*
              body: Container(
                //padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: ElevatedButton(
                  onPressed: () {

                  },
                  child: Text(
                    'Sign in',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
               */
                //body: UserList(),
                /*
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
                  //_showAppointmentInfo();
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
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AppointmentsScreen()),
                  );
                },
                child: Icon(
                Icons.schedule_sharp,
              ),
                backgroundColor: Colors.black,
              ), */
              );




    return Container();

  }
}
