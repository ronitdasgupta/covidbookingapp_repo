import 'package:covidbookingapp_repo/screens/home/manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidbookingapp_repo/services/businessHourDayCollection.dart';
import 'package:covidbookingapp_repo/services/businessHoursCollection.dart';
import 'package:covidbookingapp_repo/shared/loading.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/businessHours.dart';
import '../../services/auth.dart';

class AddDayForm extends StatefulWidget {

  final AuthService _auth = AuthService();

  // final BusinessHours businessHours;

  // AddDayForm({ required this.businessHours });

  @override
  _AddDayFormState createState() => _AddDayFormState();
}

class _AddDayFormState extends State<AddDayForm> {
  //const ManagerPage({Key? key}) : super(key: key);
  //TimeOfDay? time;

  final _formKey = GlobalKey<FormState>();

  String _currentStartTimeString = "";

  String _currentEndTimeString = '';

  int _currentSlotInterval = 0;

  String _currentDay = "Monday";
  // String _currentDay = "";

  List<String> _currentSlots = [];

  bool _currentIsHoliday = true;

  List<String> _availableDays = [];


  /*
  String? _currentStartTimeString;

  String? _currentEndTimeString;

  int? _currentSlotInterval;

  String _currentDay = "Monday";

  List<String> _currentSlots = [];

  bool _currentIsHoliday = true;
   */


  // final BusinessHoursCollection businessHoursCollection = BusinessHoursCollection(dayOfWeek: _currentDay);

  TimeOfDay? startTime;
  TimeOfDay? endTime;



  bool startTimeChanged = true;
  bool endTimeChanged = true;
  //bool isButtonWorking = true;



  String buttonText1 = "Select Start Time";

  String buttonText2 = "Select End Time";

  Duration parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();  //"6:00 AM"
    return format.format(dt);
  }

  // Converts minutes into H:M
  String durationToString(int minutes) {
    var d = Duration(minutes:minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }



  List<String> calculateSlots() {
    // 1. Calculate total hours the business is running

    //List<String> slotString = [];
    //slotString.add("9:00");

    // Converting String from buttons into TimeOfDay type
    TimeOfDay _startTime = TimeOfDay(hour:int.parse(getStartTimeText().split(":")[0]),minute: int.parse(getStartTimeText().split(":")[1]));
    TimeOfDay _endTime = TimeOfDay(hour:int.parse(getEndTimeText().split(":")[0]),minute: int.parse(getEndTimeText().split(":")[1]));

    // Converting TimeOfDay to DateTime type
    // Do not actually need the year, month, or day simply using today's date to format the TimeOfDay into DateTime type
    final now1 = new DateTime.now();
    DateTime startTimeDateTime = new DateTime(now1.year, now1.month, now1.day, _startTime.hour, _startTime.minute);

    final now2 = new DateTime.now();
    DateTime endTimeDateTime = new DateTime(now2.year, now2.month, now2.day, _endTime.hour, _endTime.minute);

    // Subtracting end time and start time to get total minutes the business is running
    int minutesOpen = endTimeDateTime.difference(startTimeDateTime).inMinutes;

    // Converts the minutes into hours:minutes
    // String hoursOpen = durationToString(minutesOpen);

    // 2. Divide the total hours open by the slot length and add 1 to get the number of slots available
    //Duration test = _initialDuration / _initialDuration;

    DateTime addDateTime = startTimeDateTime;
    List<String> slotString = [];

    int numberOfSlots = (minutesOpen ~/ _initialDuration.inMinutes);
    for(int i = 0; i <= numberOfSlots; i++) {
      String formatDateTime = DateFormat.Hm().format(startTimeDateTime);
      slotString.add(formatDateTime);
      startTimeDateTime = startTimeDateTime.add(_initialDuration);
    }

    /*
    while(slotFinderHelper != currentHoursLeftDateTime)
      {

      }
      */



    return slotString;
  }

  //List<String> testing = calculateSlots(9:00, 17:00, 30);



  String getStartTimeText() {
    if(startTime == null) {
      return 'Select Time';
    } else {
      final hours = startTime?.hour.toString().padLeft(2, '0');
      final minutes = startTime?.minute.toString().padLeft(2, '0');

      return '$hours : $minutes';
    }
  }

  String getEndTimeText() {
    if(endTime == null) {
      return 'Select Time';
    } else {
      final hours = endTime?.hour.toString().padLeft(2, '0');
      final minutes = endTime?.minute.toString().padLeft(2, '0');

      return '$hours : $minutes';
    }
  }

  Duration _initialDuration = Duration(hours: 0, minutes: 0);

  final days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
  // String? value;






  @override

  Widget build(BuildContext context) {

    // final BusinessHours businessHours;

    final allBusinessHours = Provider.of<List<BusinessHours>>(context);
    print(allBusinessHours);

    // businessHours.start;

    allBusinessHours.forEach((dayIsAvailable) {
      if(allBusinessHours.contains(dayIsAvailable.day == true)) {
        //_availableDays.add(dayIsAvailable.day);
        days.remove(dayIsAvailable.day);
      }
    });

    /*
    allBusinessHours.forEach((dayIsAvailable) {
      if(allBusinessHours.contains(businessHours.day)) {
        continue;
      }
    });
     */

    /*
    getAvailableDays() {
      allBusinessHours.forEach(dayIsAvailable) {
        print(dayIsAvailagle);
      };
    }
     */




    // final businessHours = Provider.of<BusinessHours?>(context);

    /*
    final businessInfo = Provider.of<QuerySnapshot>(context);
    print(businessInfo);
     */

    // final BusinessHours businessHours = BusinessHoursCollection(dayOfWeek: _currentDay).businessHoursForADayFromSnapshot;

    Future pickStartTime(BuildContext context) async {
      final initialTime = TimeOfDay(hour: 9, minute: 0);
      final newStartTime = await showTimePicker(
        context: context,
        initialTime: startTime ?? initialTime,
      );
      if(newStartTime == null) {
        return;
      }

      final hours = newStartTime.hour.toString().padLeft(2, '0');
      final minutes = newStartTime.minute.toString().padLeft(2, '0');



      setState(() {
        startTime = newStartTime;
        // _currentStartTimeString = startTime?.hour.toString().padLeft(2, '0') ?? "" + ":" + startTime?.minute.toString().padLeft(2, '0');
        _currentStartTimeString = '$hours : $minutes';
      });
    }

    Future pickEndTime(BuildContext context) async {
      final initialTime = TimeOfDay(hour: 9, minute: 0);
      final newEndTime = await showTimePicker(
        context: context,
        initialTime: endTime ?? initialTime,
      );
      if(newEndTime == null) {
        return;
      }


      final hours = newEndTime.hour.toString().padLeft(2, '0');
      final minutes = newEndTime.minute.toString().padLeft(2, '0');



      setState(() {
        endTime = newEndTime;
        // _currentStartTimeString = startTime?.hour.toString().padLeft(2, '0') ?? "" + ":" + startTime?.minute.toString().padLeft(2, '0');
        _currentEndTimeString = '$hours : $minutes';
      });
    }

    DropdownMenuItem<String> dropDownDays(String day) => DropdownMenuItem(
      value: day,
      child: Text(
        day,
        style: TextStyle(fontSize: 20),
      ),
    );

    /*
    return StreamBuilder<BusinessHours>(
        stream: BusinessHourDayCollection(dayOfWeek: _currentDay).businessHoursForADayFromSnapshot,
        // stream: BusinessHourDayCollection(dayOfWeek: _currentDay).businessInfo,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            BusinessHours businessHours = snapshot.data as BusinessHours;

     */

            return Scaffold(
              // backgroundColor: Colors.black,
              appBar: AppBar(
                  title: Text('Manager Page'),
                  backgroundColor: Colors.black,
                  actions: <Widget>[
                    TextButton.icon(
                      icon: Icon(Icons.person),
                      label: Text('logout'),
                      onPressed: () async {
                        // await _auth.signOut();
                      },
                    ),
                  ]
              ),
              key: _formKey,
              body: Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Input Business Hours",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(height: 20.0),
                      DropdownButtonFormField(
                        hint: Text("Select a Day"),
                        items: days.map((day) {
                          return DropdownMenuItem(
                            value: day,
                            child: Text("$day"),
                          );
                        }).toList(),
                        onChanged: (day) => setState(() => _currentDay = (day as String?)!)
                      ),
                      Text(
                        "Start Time",
                        style: TextStyle(
                            fontSize: 20.0
                        ),
                      ),
                      ElevatedButton(
                          child: Text(
                            // _currentStartTimeString == '' ? _currentStartTimeString: businessHours.start,
                            _currentStartTimeString = getStartTimeText(),
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            startTimeChanged = !startTimeChanged;
                            pickStartTime(context);
                            setState(() {
                              startTimeChanged == true ? buttonText1 : buttonText1 = getStartTimeText();
                            });
                          }
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        "End Time",
                        style: TextStyle(
                            fontSize: 20.0
                        ),
                      ),
                      ElevatedButton(
                          child: Text(
                            // _currentEndTimeString == '' ? _currentEndTimeString: businessHours.end,
                            _currentEndTimeString = getEndTimeText(),
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            endTimeChanged = !endTimeChanged;
                            pickEndTime(context);
                            setState(() {
                              endTimeChanged == true ? buttonText2 : buttonText2 = "${endTime?.hour}: ${endTime?.minute}";
                            });
                          }
                      ),
                      DurationPicker(
                        duration: _initialDuration,
                        // duration: _initialDuration ?? parseDuration(businessHours.slotintervals.toString()),
                        onChange: (val) {
                          this.setState(() {
                            _initialDuration = val;
                            _currentSlotInterval = _initialDuration.inMinutes;
                          });
                        },
                        snapToMins: 5.0,
                      ),
                      ElevatedButton(
                          child: Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {


                              /*
                              SnackBar(
                                content: Text(
                                  "Submitted Successfully!",
                                ),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating,
                              );
                               */


                            //updateBusinessHoursInfoSunday
                            List<String> _currentSlots = calculateSlots();

                            final BusinessHourDayCollection businessHours = BusinessHourDayCollection(dayOfWeek: _currentDay);

                            dynamic result = await businessHours.updateBusinessHoursInfo(_currentStartTimeString, _currentEndTimeString, _currentIsHoliday, _currentSlotInterval, _currentSlots, _currentDay);
                            if(result == null) {
                              setState(() {
                                print('error');
                              });
                            }
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Manager()),
                            );
                          }
                      ),
                    ],
                  ),
                ),
              ),
            );
          } /*else {
            return LoadingScreen();
          }
          */

        }



