import 'package:flutter/foundation.dart';

import '../insertableQuestions/insertableQuestions.dart';
import 'database_helper.dart';
final dbHelper = DatabaseHelper.instance;


class InsertQuestQuery with InsertableQuestions {
  void questionInsertToDb() async {
    // row to insert
    for (var i = 0; i < questions.length; i++) {
      Map<String, dynamic> row = {
        DatabaseHelper.columnName: questions[i]['question'],
        DatabaseHelper.marks: questions[i]['marks'],
        DatabaseHelper.correctAns : questions[i]['correct_ans']
      };
      final id = await dbHelper.insertQuest(row);
      if (kDebugMode) {
        print('inserted row id: $id');
      }
    }
  }
}