import 'package:flutter_bloc/flutter_bloc.dart';
part 'selectedAnswersState.dart';

class SelectedAnswersCubit extends Cubit<SelectedAnswersState>{
  SelectedAnswersCubit() : super(SelectedAnswersState(selectedAnswers: []));
  void saveAnswers(List selectedAnswers) => emit(SelectedAnswersState(selectedAnswers: selectedAnswers));
}