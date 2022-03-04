import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ManagerPage extends StatefulWidget {
  @override
  State<ManagerPage> createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
  //const ManagerPage({Key? key}) : super(key: key);
  TimeOfDay? time;

  bool startTimeChanged = false;
  bool endTimeChanged = false;
  //bool isButtonWorking = true;

  String buttonText1 = "Select Start Time";

  String buttonText2 = "Select End Time";

  String getText() {
    if(time == null) {
      return 'Select Time';
    } else {
      final hours = time?.hour.toString().padLeft(2, '0');
      final minutes = time?.minute.toString().padLeft(2, '0');

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
        initialTime: time ?? initialTime,
      );
      if(newStartTime == null) {
        return;
      }
      setState(() => time = newStartTime);
    }

    Future pickEndTime(BuildContext context) async {
      final initialTime = TimeOfDay(hour: 9, minute: 0);
      final newEndTime = await showTimePicker(
        context: context,
        initialTime: time ?? initialTime,
      );
      if(newEndTime == null) {
        return;
      }
      setState(() => time = newEndTime);
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
                  getText(),
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  startTimeChanged = !startTimeChanged;
                  pickStartTime(context);
                  setState(() {
                    startTimeChanged == true ? buttonText1 : buttonText1 = "${time?.hour}: ${time?.minute}";
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
                    getText(),
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    endTimeChanged = !endTimeChanged;
                    pickEndTime(context);
                    setState(() {
                      endTimeChanged == true ? buttonText2 : buttonText2 = "${time?.hour}: ${time?.minute}";
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
