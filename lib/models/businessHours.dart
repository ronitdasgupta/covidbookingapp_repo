import 'package:flutter/material.dart';

class BusinessHours {
  final String start;
  final String end;
  final bool isholiday;
  final TimeOfDay slotintervals;
  final List<String> slots;

  BusinessHours({ required this.start, required this.end, required this.isholiday, required this.slotintervals, required this.slots});
}