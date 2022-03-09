// ignore_for_file: file_names
import 'package:intl/intl.dart';

mixin currentDate{
  String? formatCurrentDate(DateTime now){
    DateFormat formatter = DateFormat('dd-MM-yyyy');
    String? formatted;
    formatted = formatter.format(now);
    return formatted;
  }
}