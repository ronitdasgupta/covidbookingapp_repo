import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:duration_picker/duration_picker.dart';


class DurationPicker extends StatefulWidget {
  const DurationPicker({Key? key}) : super(key: key);

  @override
  _DurationPickerState createState() => _DurationPickerState();
}

class _DurationPickerState extends State<DurationPicker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
    /*
    return Scaffold(
      body: Center(
        child: DurationPicker(
          onChange: (duration) {
            print(duration.toString());
          },
          snapToMins: 5.0,
        ),
      ),
    );
    */
  }
}
