import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/cubit/attemptType/attemptTypeCubit.dart';
import 'package:projects/cubit/date/dateCubit.dart';
import 'package:projects/cubit/loader/loaderCubit.dart';
import 'package:projects/presentation/screens/mainScreen.dart';
import 'cubit/attemptDate/attemptDateCubit.dart';
import 'cubit/questionsView/questionsCubit.dart';
import 'cubit/selectedAnswers/selectedAnswersCubit.dart';
import 'cubit/userAnswersView/userAnswersCubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DateCubit>(
          create: (BuildContext context) => DateCubit(),
        ),
        BlocProvider<LoaderCubit>(
          create: (BuildContext context) => LoaderCubit(),
        ),
        BlocProvider<QuestionsCubit>(
          create: (BuildContext context) => QuestionsCubit(),
        ),
        BlocProvider<AttemptDateCubit>(
          create: (BuildContext context) => AttemptDateCubit(),
        ),
        BlocProvider<UserAnswersCubit>(
          create: (BuildContext context) => UserAnswersCubit(),
        ),
        BlocProvider<SelectedAnswersCubit>(
          create: (BuildContext context) => SelectedAnswersCubit(),
        ),
        BlocProvider<AttemptTypeCubit>(
          create: (BuildContext context) => AttemptTypeCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Answer Me',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MainScreen(),
      ),
    );
  }
}
