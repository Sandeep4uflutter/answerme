import 'package:flutter_bloc/flutter_bloc.dart';
part 'questionsState.dart';

class QuestionsCubit extends Cubit<QuestionState>{
  QuestionsCubit() : super(QuestionState(allQuestions: []));
  void showQuestion(List question) => emit(QuestionState(allQuestions: question));
}