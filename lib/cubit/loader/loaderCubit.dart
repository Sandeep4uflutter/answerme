import 'package:flutter_bloc/flutter_bloc.dart';
part 'loaderState.dart';

class LoaderCubit extends Cubit<LoaderState>{
  LoaderCubit() : super(LoaderState(visibility: true));
  void visibility(bool status) => emit(LoaderState(visibility: status));
}