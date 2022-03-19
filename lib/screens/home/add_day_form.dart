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

  final AuthService auth = AuthService();
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

  String? _currentDay;

  bool _currentIsHoliday = true;



  TimeOfDay? startTime;
  TimeOfDay? endTime;



  bool startTimeChanged = true;
  bool endTimeChanged = true;


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

    return slotString;
  }

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
      _currentEndTimeString = '$hours : $minutes';
    });
  }

  @override

  Widget build(BuildContext context) {

    final allBusinessHours = Provider.of<List<BusinessHours>>(context);

    List<String> pickSelectableDays(List<String> selectableDays) {
      const String NotinDb = "NotInDB";
      final List weekDays = [["Sunday", NotinDb], ["Monday",NotinDb], ["Tuesday",NotinDb], ["Wednesday",NotinDb], ["Thursday",NotinDb], ["Friday",NotinDb], ["Saturday",NotinDb]];
      for (var i=0; i<weekDays.length; i++)
      {
        for (var k=0; k<weekDays[i].length; k++)
        {
          allBusinessHours.forEach((dayIsAvailable) {
            if(weekDays[i][0] == dayIsAvailable.day) {
              weekDays[i][1]= "FoundInDB";
            }
          });
          //print(weekDays[i][k]);
        }
      }
      for (var i=0; i<weekDays.length; i++)
      {
          if (weekDays[i][1]==NotinDb)
          {
            //Only adds the days that are not in the DB
            selectableDays.add(weekDays[i][0]);
          }
          //print(weekDays[i][k]);
      }
      return selectableDays;
    }



    List<String> selectableDays = [];

    selectableDays = pickSelectableDays(selectableDays);

    /*
    List<String> selectableDays = [];

    days.forEach((day) {
      bool isFound = false;
      allBusinessHours.forEach((dayIsAvailable) {
        if(day == dayIsAvailable.day) {
          isFound = true;
        }
      });
      if(isFound == false) {
        selectableDays.add(day);
      }
    });
     */

            return Scaffold(
              appBar: AppBar(
                  title: Text('Manager Page'),
                  backgroundColor: Colors.black,
                  actions: <Widget>[
                    TextButton.icon(
                      icon: Icon(Icons.person),
                      label: Text('logout'),
                      onPressed: () async {
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
                        value: _currentDay ?? selectableDays[0],
                        // hint: Text("Select a Day"),
                        items: selectableDays.map((day) {
                          return DropdownMenuItem(
                            value: day,
                            child: Text("$day"),
                          );
                        }).toList(),
                        onChanged: (val) => setState(() => _currentDay = (val as String?)!)
                      ),
                      Text(
                        "Start Time",
                        style: TextStyle(
                            fontSize: 20.0
                        ),
                      ),
                      ElevatedButton(
                          child: Text(
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
                            List<String> _currentSlots = calculateSlots();

                            final BusinessHourDayCollection businessHours = BusinessHourDayCollection(dayOfWeek: _currentDay!);

                            dynamic result = await businessHours.updateBusinessHoursInfo(_currentStartTimeString, _currentEndTimeString, _currentIsHoliday, _currentSlotInterval, _currentSlots, _currentDay!);
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
          }
        }



