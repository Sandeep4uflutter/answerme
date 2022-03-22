// ignore_for_file: file_names
import 'package:flutter/foundation.dart';
import 'insertQuestion.dart';

mixin GetAvailableQuestionsInDb{
  Future<List<Map<String, dynamic>>> queryQuests() async {
    final insertQ = InsertQuestQuery();
    final allRows = await dbHelper.queryAllQuestRows();
    if (kDebugMode) {
      print('query all rows:');
      // ignore: avoid_print
      allRows.forEach(print);
    }
    if(allRows.isEmpty){
      insertQ.questionInsertToDb();
    }
    return allRows;
  }
}