import 'package:flutter_bloc/flutter_bloc.dart';
part 'attemptDateState.dart';

class AttemptDateCubit extends Cubit<AttemptDateState>{
  AttemptDateCubit() : super(AttemptDateState(dates: []));
  void showQuestion(List dates) => emit(AttemptDateState(dates: dates));
}