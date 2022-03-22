// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'formatCurrentDate.dart';

class SelectDate with currentDate{
  DateTime selectedDate = DateTime.now();
  String? resultDate;
  Future selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),

    );
    if (selected != null && selected != selectedDate) {
        selectedDate = selected;
        resultDate = formatCurrentDate(selected);
    }
    return resultDate;
  }
}