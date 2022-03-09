// ignore_for_file: file_names
import 'package:flutter/foundation.dart';

import '../insertableQuestions/insertableQuestions.dart';
import 'database_helper.dart';
final dbHelper = DatabaseHelper.instance;


class InsertAnsQuery with InsertableQuestions {
  void answerInsertToDb(List myAnswer) async {
    for (var i = 0; i < myAnswer.length; i++) {
      Map<String, dynamic> row = {
        DatabaseHelper.columnName2: myAnswer[i]['question'],
        DatabaseHelper.givenAnswer: myAnswer[i]['given_answer'],
        DatabaseHelper.correctAnswer : myAnswer[i]['correct_ans'],
        DatabaseHelper.date : myAnswer[i]['date']
      };
      final id = await dbHelper.insertAns(row);
      if (kDebugMode) {
        print('inserted row id: $id');
      }
    }
  }
}