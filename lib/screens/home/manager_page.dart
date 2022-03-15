import 'package:covidbookingapp_repo/services/businessHoursCollection.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/businessHours.dart';

class ManagerPage extends StatefulWidget {
  @override
  State<ManagerPage> createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
  //const ManagerPage({Key? key}) : super(key: key);
  //TimeOfDay? time;

  final BusinessHoursCollection businessHours = BusinessHoursCollection();

  TimeOfDay? startTime;
  TimeOfDay? endTime;

  bool startTimeChanged = false;
  bool endTimeChanged = false;
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



  List<String> calculateSlots(TimeOfDay startTime, TimeOfDay endTime, Duration _initialDuration) {
    // 1. Calculate total hours the business is running

    List<String> slotString = [];
    slotString.add("9:00");

    // Converting String from buttons into TimeOfDay type
    TimeOfDay _startTime = TimeOfDay(hour:int.parse(buttonText1.split(":")[0]),minute: int.parse(buttonText1.split(":")[1]));
    TimeOfDay _endTime = TimeOfDay(hour:int.parse(buttonText2.split(":")[0]),minute: int.parse(buttonText2.split(":")[1]));

    // Converting TimeOfDay to DateTime type
    // Do not actually need the year, month, or day simply using today's date to format the TimeOfDay into DateTime type
    final now1 = new DateTime.now();
    DateTime startTimeDateTime = new DateTime(now1.year, now1.month, now1.day, _startTime.hour, _startTime.minute);

    final now2 = new DateTime.now();
    DateTime endTimeDateTime = new DateTime(now2.year, now2.month, now2.day, _endTime.hour, _endTime.minute);

    // Subtracting end time and start time to get total minutes the business is running
    var minutesOpen = endTimeDateTime.difference(startTimeDateTime).inMinutes;

    // Converts the minutes into hours:minutes
    String hoursOpen = durationToString(minutesOpen);

    // 2. Divide the total hours open by the slot length and add 1 to get the number of slots available
    //Duration test = _initialDuration / _initialDuration;

    int countSlots = 0;
    //int currentHoursLeft = (Int)hoursOpen;
    TimeOfDay _currentHoursLeft = TimeOfDay(hour:int.parse(hoursOpen.split(":")[0]),minute: int.parse(hoursOpen.split(":")[1]));
    final now3 = new DateTime.now();
    DateTime currentHoursLeftDateTime = new DateTime(now3.year, now3.month, now3.day, _currentHoursLeft.hour, _currentHoursLeft.minute);

    //for(int i = 0; i < )
    //while(currentHoursLeftDateTime != )

    String duration = _printDuration(_initialDuration);
    TimeOfDay _durationTOD = TimeOfDay(hour:int.parse(duration.split(":")[0]),minute: int.parse(duration.split(":")[1]));
    final now4 = new DateTime.now();
    DateTime durationDateTime = new DateTime(now4.year, now4.month, now4.day, _durationTOD.hour, _durationTOD.minute);

    while(currentHoursLeftDateTime.difference(durationDateTime).inMinutes > 0) {
      // Having trouble with this LINE OF CODE
      // IT IS GETTING THE SAME DIFFERENCE EVERY TIME IT GOES THROUGH THE LOOP
      int currentHours = currentHoursLeftDateTime.difference(durationDateTime).inMinutes;
      countSlots++;
    }

    DateTime slotFinderHelper = new DateTime(2022, 03, 06, 0, 0);

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
  String? value;

  @override
  Widget build(BuildContext context) {

    Future pickStartTime(BuildContext context) async {
      final initialTime = TimeOfDay(hour: 9, minute: 0);
      final newStartTime = await showTimePicker(
        context: context,
        initialTime: startTime ?? initialTime,
      );
      if(newStartTime == null) {
        return;
      }
      setState(() => startTime = newStartTime);
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
      setState(() => endTime = newEndTime);
    }

    DropdownMenuItem<String> dropDownDays(String day) => DropdownMenuItem(
      value: day,
      child: Text(
        day,
        style: TextStyle(fontSize: 20),
      ),
    );


    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Start Time",
                style: TextStyle(
                    fontSize: 20.0
                ),
              ),
              ElevatedButton(
                  child: Text(
                    getStartTimeText(),
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    startTimeChanged = !startTimeChanged;
                    pickStartTime(context);
                    setState(() {
                      startTimeChanged == true ? buttonText1 : buttonText1 = "${startTime?.hour}: ${startTime?.minute}";
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
                    getEndTimeText(),
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
                  this.setState(() => _initialDuration = val);
                },
                snapToMins: 5.0,
              ),

              /*
              DropDownButton<String>(
                items: days.map(dropDownDays).toList(),
                onChanged: (value) => setState(() => this.value = value),
              ),
               */

              DropdownButton(
                  hint: Text("Select Day"),
                  value: value,
                  items: days.map(dropDownDays).toList(),
                  onChanged: (value) => setState(() => this.value = value as String?)
              ),
              ElevatedButton(
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {

                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Submitted Successfully!",
                        ),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );

                    if(value == "Sunday") {
                      //updateBusinessHoursInfoSunday
                      //dynamic result = businessHours.updateBusinessHoursInfoSunday(buttonText1, buttonText2, false, _initialDuration, slots);
                    }

                    /*
                  SnackBar(
                    content: Text(
                      "Submitted Successfully!",
                    ),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 3),
                    behavior: SnackBarBehavior.floating,
                  );
                  */
                  }
              ),



              /*
              DurationPicker(
                onChange: (duration) {
                  print(duration.toString());
                },
                snapToMins: 5.0,
              ),
              */


              /*
              DropdownButton<String>(
                value: value,
                items: days.map()
              ),
              */
            ],
          ),
        ),
      ),
    );
  }
}