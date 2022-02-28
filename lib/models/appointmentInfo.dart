import 'dart:core';

class AppointmentSlot {
  final String email;
  final String slot;

  AppointmentSlot({ required this.email, required this.slot });
}

class AppointmentsInfo {
  final List<AppointmentSlot> appointmentSlots;
  final String day;

  AppointmentsInfo({ required this.appointmentSlots, required this.day });
}











