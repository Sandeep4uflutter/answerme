import 'package:flutter/material.dart';

class AppColors{
  static Color appScaffoldColor = Colors.white;
  static Color bottomBarColor = Colors.grey.withOpacity(0.05);
  static Color menuButtonColor = Colors.black;
  static Color mainScreenAppBarColor = Colors.transparent;
  static Color otherScreenAppBarColor = Colors.transparent;
  static Color mainScreenAppBarTextColor = Colors.black;
  static Color otherScreenAppBarTextColor = Colors.black;
  static Color mainScreenAppBarIconColor = Colors.blue;
  static Gradient mainScreenCardColor = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: const [0.1, 0.5, 0.7, 0.9],
    colors: [
      Colors.blue[800]!,
      Colors.blue[700]!,
      Colors.blue[600]!,
      Colors.blue[400]!,
    ],
  );
  static Color mainScreenCardTimeCard =  Colors.white.withOpacity(0.5);
  static Color mainScreenCardTimeIcon =  Colors.black;
  static Color mainScreenCardTimeText =  Colors.black;
  static Color mainScreenCardIcon =  Colors.white.withOpacity(0.7);
  static Color mainScreenCardText =  Colors.white;
  static Color hintCardColor =  Colors.grey.withOpacity(0.1);
  static Color hintTextColor =  Colors.black;
  static Color alreadyAttemptedIcon =  Colors.green.withOpacity(0.5);
  static Color alreadyAttemptedText =  Colors.black;
  static Color alreadyAttemptedButtonText =  Colors.white;
  static Color alreadyAttemptedButton =  Colors.blue;
  static Color questCardColor =  Colors.blue.withOpacity(0.1);
  static Color responseScreenQuestionText =  Colors.black;
  static Color responseScreenAnswerText =  Colors.black;
  static Color responseScreenCardColor =  Colors.grey.withOpacity(0.05);
  static Color responseScreenCorrectAnsIconColor =  Colors.green;
  static Color responseScreenWrongAnsIconColor =  Colors.red;
  static Color responseScreenLeftAnsColor =  Colors.red;
  static Color leadingIconColor =  Colors.black;
}