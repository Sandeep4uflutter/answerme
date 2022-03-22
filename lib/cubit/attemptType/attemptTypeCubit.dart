import 'package:flutter_bloc/flutter_bloc.dart';
part 'attemptTypeState.dart';

class AttemptTypeCubit extends Cubit<AttemptTypeState>{
  AttemptTypeCubit() : super(AttemptTypeState(isOld: true));
  void attemptStatus(bool status) => emit(AttemptTypeState(isOld: status));
}