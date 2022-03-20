import 'package:flutter/material.dart';

class BusinessDay {
  final String day;

  BusinessDay({ required this.day});
}

class BusinessHours {
  final String day;
  final String start;
  final String end;
  final bool isholiday;
  final int slotintervals;
  final List<String> slots;

  BusinessHours({ required this.day, required this.start, required this.end, required this.isholiday, required this.slotintervals, required this.slots });
}