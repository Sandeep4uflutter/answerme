import 'package:flutter_bloc/flutter_bloc.dart';
part 'userAnswersState.dart';

class UserAnswersCubit extends Cubit<UserAnswersState>{
  UserAnswersCubit() : super(UserAnswersState(answers: []));
  void setAnswers(List answers) => emit(UserAnswersState(answers: answers));
}