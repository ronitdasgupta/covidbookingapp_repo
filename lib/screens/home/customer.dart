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
  bool isChanged = true;

  DateTime? date;

  List<String> slots = [];

  String _currentDay = "";

  String _currentDate = '';
  String? _currentTime;
  DateTime now = new DateTime.now();
  String? _submitCancelButtonText;


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser?>(context);
    final allBusinessHours = Provider.of<List<BusinessHours>>(context);
    final allAppointments = Provider.of<List<AppointmentsInfo>>(context);
    final userData = Provider.of<UserData?>(context);



    // Gets slots for selected date
    List<String> readAvailableSlots() {
      // 1. Check to see if selected date is in Appointments collection

      bool dateFound = false;

      List<String> availableSlotArray = [];
      // availableSlotArray.add(selectTime);

      allAppointments.forEach((eachDate) {
        if(eachDate.selectedDate == _currentDate) {
          dateFound = true;
          eachDate.appointmentslots.forEach((dynamic slot) {
            if(slot['email'] == "" || slot['email'] == userData?.email) {
              String? test = slot['timeslot'];
              availableSlotArray.add(test ?? '');
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




    String getCurrentDate() {
      if(_currentDate == null || _currentDate == '') {
        if(userData?.aptDate == null || userData?.aptDate == '') {
          _currentDate = DateFormat('yyyy-MM-dd').format(now);
        } else {
          _currentDate = userData!.aptDate;
          // _currentTime = userData!.aptTime;
        }
      }
      return _currentDate;
    }

    // Checking if date is already in collection
    bool isDateFound() {
      bool dateFound = false;
      allAppointments.forEach((eachDate) {
        if(eachDate.selectedDate == _currentDate) {
          dateFound = true;
        }
      });
      return dateFound;
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

    Future<void> writeNewDate() async {
      // 1. Case if the date is not found in the Appointments collection

      // 2. Getting the day of the selected date


      DateTime convertStringDate = DateTime.parse(_currentDate);


      _currentDay = DateFormat('EEEE').format(convertStringDate);

      // 3. Read the BusinessHours collection for slot information regarding the day selected

      List<dynamic> aptSlotArray = [];

      allBusinessHours.forEach((eachDay) {
        if(eachDay.day == _currentDay) {
          eachDay.slots.forEach((slot) {
            if(slot != "") {
              dynamic appointmentSlot = {'email': '', 'timeslot': slot};
              aptSlotArray.add(appointmentSlot);
            }
          });

        }
      });

      // 4. Write the slots into the Appointments collection for the given date
      AppointmentsInfo newAppointmentInfo = AppointmentsInfo(appointmentslots: aptSlotArray, day: _currentDay, selectedDate: _currentDate);
      if(_submitCancelButtonText != "Cancel Appointment") {
        updateAppointmentsInFirestore(newAppointmentInfo);
        setState(() {
          _submitCancelButtonText = "Submit";
        });
      }

    }

    List<String> getSlotAvailability() {
      if(isDateFound() == true) {

      } else {
        writeNewDate();
      }
      // slots = getSlotAvailability();
      setState(() {
        slots = readAvailableSlots();
      });
      return slots;
    }


    String? getCurrentTime() {
      slots = getSlotAvailability();
      // _currentTime = (userData?.aptDate == null || userData?.aptDate == '' ? slots[0] : userData?.aptTime)!;
      if(_currentTime == null || _currentTime == '') {
        if(userData?.aptTime == null || userData?.aptTime == '') {
          if(slots.length > 0) {
            _currentTime = slots[0];
          } else {
            _currentTime = "";
          }
        } else {
          // _currentDate = userData!.aptDate;
          _currentTime = userData!.aptTime;
        }
      }
      return _currentTime;
    }
    // String _submitCancelButtonText;


    /*    _currentDate = getCurrentDate();
    slots = getSlotAvailability();
    _currentTime = getCurrentTime();*/

    // _currentDate = userData?.aptDate == null || userData?.aptDate == '' ? DateFormat('yyyy-MM-dd').format(now) : userData?.aptDate;
    // _currentDate = _currentDate ?? userData?.aptDate;







    //String _submitCancelButtonText = userData?.aptDate == null || userData?.aptDate == '' ? "Submit" : "Cancel Appointment";
    //_currentDate = (userData?.aptDate == null || userData?.aptDate == '' ? DateFormat('yyyy-MM-dd').format(now) : userData?.aptDate)!;
    // _currentTime = (userData?.aptDate == null || userData?.aptDate == '' ? slots[0] : userData?.aptTime)!;


    /*
    if(userData?.aptTime == null || userData?.aptTime == "") {
      if(slots.length > 0) {
        _currentTime = slots[0];
      }
    } else {
      _currentTime = userData?.aptTime;
    }
     */

    /*
    if(slots.length > 0 && userData?.aptTime == null) {
      _currentTime = userData?.aptTime ?? slots[0];
    } /* else {
      _currentTime = "00:00";
    } */
     */

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

      setState((){
        // _currentDate = getCurrentDate();
        _currentDate = DateFormat('yyyy-MM-dd').format(newDate);
        slots = getSlotAvailability();
        _currentTime = getCurrentTime();
        // _submitCancelButtonText = userData?.aptDate == null || userData?.aptDate == '' ? "Submit" : "Cancel Appointment";
      });

      // setState(() => date = newDate);
      // setState(() => _currentDate = DateFormat('yyyy-MM-dd').format(newDate));
      // _currentDate = DateFormat('yyyy-MM-dd').format(newDate);

      /*
      setState(() {
        _currentDate = DateFormat('yyyy-MM-dd').format(newDate);
        slots = getSlotAvailability();
      });
       */

    }

    Future<void> updateUser(isCancelled) async {
      // Updates user information once appointment gets scheduled
      if(isCancelled == false) {
        UsersCollection usersCollection = UsersCollection(uid: user?.uid ?? '');
        usersCollection.updateUserAppointment(
          userData?.name ?? '',
          userData?.phoneNumber ?? '',
          userData?.email ?? '',
          _currentDate,
          _currentTime ?? '',
          _currentDay,
        );
      } else {
        // Updating user info when user cancels appointment
        UsersCollection usersCollection = UsersCollection(uid: user?.uid ?? '');
        usersCollection.updateUserAppointment(
          userData?.name ?? '',
          userData?.phoneNumber ?? '',
          userData?.email ?? '',
          '',
          '',
          '',
        );
      }
    }

    // Updates Appointments Collection once user selects a date and time slot
    // Allocates time slot to user's email
    Future<void> updateAppointmentCollection(bool isCancelled) async {

      List<dynamic> updatedAppointmentSlotArray = [];

      allAppointments.forEach((eachDate) {
        if(eachDate.selectedDate == _currentDate) {
          eachDate.appointmentslots.forEach((dynamic slot) {
            if(isCancelled == false) {
              if(slot['timeslot'] == _currentTime) {
                String? slotString = slot['timeslot'];
                dynamic updatedAppointmentSlot = {'email': user?.email ?? '', 'timeslot': slotString ?? ''};
                updatedAppointmentSlotArray.add(updatedAppointmentSlot);
              } else {
                // Keeping the slot as is
                updatedAppointmentSlotArray.add(slot);
              }
            } else {
              // Cancel scenario - clearing up the email and timeslot in Appointments collection
              if(slot['email'] == user?.email) {
                String? slotString = slot['timeslot'];
                dynamic updatedAppointmentSlot = {'email': '', 'timeslot': slotString};
                updatedAppointmentSlotArray.add(updatedAppointmentSlot);
              } else {
                // Keeping the slot as is
                updatedAppointmentSlotArray.add(slot);
              }
            }
          });
          AppointmentsInfo updatedAppointmentInfo = AppointmentsInfo(appointmentslots: updatedAppointmentSlotArray, day: eachDate.day, selectedDate: _currentDate);
          updateAppointmentsInFirestore(updatedAppointmentInfo);

          // Updates Users collection for specific user based on uid
          // Writes the user's date and time slot
          updateUser(isCancelled);
        }
      });
    }

    Future<void> deleteAppointmentCollectionDocument(String _currentDate) async {
      final AppointmentsCollection appointmentsCollection = AppointmentsCollection();

      dynamic result = await appointmentsCollection.deleteAppointment(_currentDate);

      if(result == null) {
        setState(() {
          print('error');
        });
      }
    }

    Future<void> deleteFromAppointmentCollection() async {
      bool scheduledAppointmentFound = false;
      // List<dynamic>
      // Checks to see if there are scheduled appointments for that day
      // If there are no scheduled appointments : Delete the document
      allAppointments.forEach((eachDate) {
        if(eachDate.selectedDate == _currentDate) {
          eachDate.appointmentslots.forEach((dynamic slot) {
            if(slot['email'] != "" && slot['email'] != userData?.email) {
              scheduledAppointmentFound = true;
            }
          });
        }
      });

      if(scheduledAppointmentFound == true) {
        // Update the document
        updateAppointmentCollection(true);

      } else {
        // Delete the document
        deleteAppointmentCollectionDocument(_currentDate);
        updateUser(true);
      }
      // Else, update the email to an empty string

    }


    bool boolIsDatePresent = false;

    bool readUserInfo() {
      if(userData?.aptDate == "") {
        return boolIsDatePresent;
      } else {
        return boolIsDatePresent = true;
      }
    }

    boolIsDatePresent = readUserInfo();

    _currentDate = getCurrentDate();
    slots = getSlotAvailability();
    _currentTime = getCurrentTime();
    _submitCancelButtonText = userData?.aptDate == null || userData?.aptDate == '' ? "Submit" : "Cancel Appointment";

    /*
    setState((){
      _currentDate = getCurrentDate();
      slots = getSlotAvailability();
      _currentTime = getCurrentTime();
      _submitCancelButtonText = userData?.aptDate == null || userData?.aptDate == '' ? "Submit" : "Cancel Appointment";
    });
     */



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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 100.0),
              Text(
                "Welcome ${userData?.name}!",
                style: TextStyle(
                  fontSize: 35.0,
                ),
              ),
              SizedBox(height: 50.0),
              Text(
                "Date",
                style: TextStyle(
                    fontSize: 20.0
                ),
              ),
              ElevatedButton(
                child: Text(
                    _currentDate,
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  isChanged = !isChanged;
                  pickDate(context);
                  // checkSlotAvailability();
                  setState(() {
                    // isChanged == true ? buttonText1 = "Select Date" : buttonText1 = "${date?.month}/${date?.day}/${date?.year}";
                    isChanged == true ? buttonText1 = getCurrentDate(): getCurrentDate();
                    _currentDate = getCurrentDate();
                  });
                },
              ),
              SizedBox(height: 50.0),
              Text(
                "Time",
                style: TextStyle(
                    fontSize: 20.0
                ),
              ),
              DropdownButtonFormField(
                  value: _currentTime,
                  items: slots.map((slot) {
                    return DropdownMenuItem(
                      value: slot,
                      child: Text("$slot"),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currentTime = (val as String?) ?? '')
              ),
              ElevatedButton(
                  child: Text(
                    _submitCancelButtonText!,
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_currentTime == "") {
                      SnackBar(
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.error_outline, size: 32),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                "Please select a valid time",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                      );
                    }
                    if(_submitCancelButtonText == "Submit") {
                      updateAppointmentCollection(false);
                    } else{
                      // Cancel appointment method
                      deleteFromAppointmentCollection();
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
