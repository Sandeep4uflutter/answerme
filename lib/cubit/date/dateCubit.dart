import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
part 'dateState.dart';

class DateCubit extends Cubit<DateState>{
  DateCubit() : super(DateState(date: DateFormat('dd-MM-yyyy').format(DateTime.now())));

  void updateDate(String date) => emit(DateState(date: date));
}