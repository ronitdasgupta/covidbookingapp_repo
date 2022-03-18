import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidbookingapp_repo/models/appointmentInfo.dart';
import 'package:covidbookingapp_repo/services/businessHourDayCollection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  final CollectionReference appointments = FirebaseFirestore.instance.collection('Appointments');


  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  String buttonText1 = "Select Date";
  String buttonText2 = "Select Time";
  bool isChanged = true;

  DateTime? date;

  List<String> slots = [];

  String _currentSlot = "";

  String _currentDay = "";






  //final Stream<QuerySnapshot> BusinessHours = FirebaseFirestore.instance.collection('BusinessHours').snapshots();
  //final Stream<QuerySnapshot> Appointments = FirebaseFirestore.instance.collection('Appointments').snapshots();

  //Stream<List<Appointments>> readAppointments() => FirebaseFirestore.instance.collection("Appoingments").snapshots().map((snapshot) => snapshot.docs.map((doc) => AppointmentsInfo..data()).toList());

  //const Customer({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    String selectedDate = "";




    void _showAppointmentInfo(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: Text('bottom sheet'),
        );
      });
    }

    Future<void> updateAppointmentsInFirestore(AppointmentsInfo appointmentsInfo) async {
      final AppointmentsCollection appointmentsCollection = AppointmentsCollection();

      dynamic result = await appointmentsCollection.updateAppointment(appointmentsInfo);

      if(result == null) {
        setState(() {
          print('error');
        });
      }
    }



    final user = Provider.of<MyUser?>(context);
    print(user);

    final allBusinessHours = Provider.of<List<BusinessHours>>(context);
    print(allBusinessHours);

    final allAppointments = Provider.of<List<AppointmentsInfo>>(context);
    print(allAppointments);

    final userData = Provider.of<UserData?>(context);

    Future<void> writeNewDate() async {
      // 1. Case if the date is not found in the Appointments collection

        // 2. Getting the day of the selected date

        DateTime convertStringDate = DateTime.parse(selectedDate);

        _currentDay = DateFormat('EEEE').format(convertStringDate);

        // 3. Read the BusinessHours collection for slot information regarding the day selected

        List<AppointmentSlot> aptSlotArray = [];

        allBusinessHours.forEach((eachDay) {
          if(eachDay.day == _currentDay) {
            eachDay.slots.forEach((slot) {
              AppointmentSlot appointmentSlot = AppointmentSlot(email: "", slot: slot);
              aptSlotArray.add(appointmentSlot);
            });

          }
        });

        // 4. Write the slots into the Appointments collection for the given date
        // AppointmentsInfo newAppointmentInfo = AppointmentsInfo(appointmentslots: aptSlotArray, day: _currentDay, selectedDate: selectedDate);
        // updateAppointmentsInFirestore(newAppointmentInfo);

    }

    List<String> availableSlots() {
      // 1. Check to see if selected date is in Appointments collection

      bool dateFound = false;

      List<String> availableSlotArray = [];

      allAppointments.forEach((eachDate) {
        if(eachDate.selectedDate == selectedDate) {
          dateFound = true;
          eachDate.appointmentslots.forEach((AppointmentSlot slot) {
            if(slot.email == "") {
              availableSlotArray.add(slot.slot);
            }
          });
        }
      });

      if(dateFound == true) {
        return availableSlotArray;
      }

      if(dateFound == false) {
        return availableSlotArray;
      }

      return availableSlotArray;

    }



    // Checking if date is already in collection
    bool isDateFound() {
      bool dateFound = false;
      allAppointments.forEach((eachDate) {
        if(eachDate.selectedDate == selectedDate) {
          dateFound = true;
        }
      });
      return dateFound;
    }

    String getText() {
      if(date == null) {
        return "Select Date";
      } else {
        // selectedDate = "${date?.month}-${date?.day}-${date?.year}";
        selectedDate = DateFormat('yyyy-MM-dd').format(date!);
        //
        // Checking to see if date selected is available in Appointments collection
        if(isDateFound() == true) {

        } else {
          writeNewDate();
        }
        slots = availableSlots();
        return selectedDate;
      }
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

      // Checking to see if date selected is available in Appointments collection
      /*
      if(isDateFound() == true) {

      } else {
        writeNewDate();
      }


      setState(() {
        slots = availableSlots();
      });
       */

    }

    // DateTime convertStringDate = DateTime.parse(selectedDate);

     // String day = DateFormat('EEEE').format(convertStringDate);

    Future<void> updateUser() async {
      UsersCollection usersCollection = UsersCollection(uid: user?.uid ?? '');
      usersCollection.updateUserAppointment(
          userData?.name ?? '',
          userData?.phoneNumber ?? '',
          userData?.email ?? '',
          selectedDate,
          _currentSlot,
          _currentDay,
      );
    }






    // Updates Appointments Collection once user selects a date and time slot
    // Allocates time slot to user's email
    Future<void> updateAppointmentCollection() async {

      List<AppointmentSlot> updatedAppointmentSlotArray = [];

      allAppointments.forEach((eachDate) {
        if(eachDate.selectedDate == selectedDate) {
          // dateFound = true;
          eachDate.appointmentslots.forEach((AppointmentSlot slot) {
            if(slot.slot == _currentSlot) {
              AppointmentSlot updatedAppointmentSlot = AppointmentSlot(email: user?.email ?? '', slot: slot.slot);
              // AppointmentSlot updatedAppointmentSlot = AppointmentSlot(email: "sujas", slot: "09:30");
              updatedAppointmentSlotArray.add(updatedAppointmentSlot);
            } else {
              // Keeping the slot as is
              updatedAppointmentSlotArray.add(slot);
            }
          });
          AppointmentsInfo updatedAppointmentInfo = AppointmentsInfo(appointmentslots: updatedAppointmentSlotArray, day: eachDate.day, selectedDate: selectedDate);
          updateAppointmentsInFirestore(updatedAppointmentInfo);

          // Updates Users collection for specific user based on uid
          // Writes the user's date and time slot
          updateUser();
        }
      });
    }









    /*
    allBusinessHours.forEach((dayIsAvailable) {
      if(allBusinessHours.contains(dayIsAvailable.day == true)) {
        //_availableDays.add(dayIsAvailable.day);
        days.remove(dayIsAvailable.day);
      }
    });
     */

    /*
    allAppointments.forEach((appointment) {
      if(appointment.date == getText()) {
        // document.get().then((DocumentSnapshot) => null)
        // FirebaseFirestore.instance.collection('Appointments').doc(getText()).get().then((DocumentSnapshot) => )

        // Reading all the information for the specific date
        document.get().then((function) => "appointmentslots");
        document.get().then((function) => "day");

        // Loop through the map with timeslot that doesn't have an email
        appointmentslots.forEach(slot) {
          appointmentslots.forEach((k, v)) {
            if(v = "")
          }
        }
      }
    });
     */












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
                          selectedDate = getText(),
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          isChanged = !isChanged;
                          pickDate(context);
                          // slots = availableSlots();
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
                      DropdownButtonFormField(
                          hint: Text("Select a Time"),
                          items: slots.map((slot) {
                            return DropdownMenuItem(
                              value: slot,
                              child: Text("$slot"),
                            );
                          }).toList(),
                          onChanged: (slot) => setState(() => _currentSlot = (slot as String?)!)
                      ),
                      ElevatedButton(
                        child: Text(
                          "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                          updateAppointmentCollection();
                      })
                      /*
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
                      */
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
