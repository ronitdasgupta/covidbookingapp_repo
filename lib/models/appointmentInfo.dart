import 'dart:core';

class AppointmentSlot {
  final String email;
  final String slot;

  AppointmentSlot({ required this.email, required this.slot });

  factory AppointmentSlot.fromJson(Map<String, dynamic> json) {
    return AppointmentSlot(
      email: json['email'],
      slot: json['timeslot'],
    );
  }
  static List<AppointmentSlot> fromJsonArray(List<dynamic> jsonArray) {
    List<AppointmentSlot> arrayOfSlots = [];

    jsonArray.forEach((jsonData) {
      arrayOfSlots.add(AppointmentSlot.fromJson(jsonData));
    });

    return arrayOfSlots;
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "timeslot": slot,
    };
  }

}

class AppointmentsInfo {
  final List<AppointmentSlot> appointmentslots;
  final String day;
  final String selectedDate;

  AppointmentsInfo({ required this.appointmentslots, required this.day, required this.selectedDate });

  // AppointmentsInfo({ required this.day });
}











