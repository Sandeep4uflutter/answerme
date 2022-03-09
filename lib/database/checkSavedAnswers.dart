// ignore_for_file: file_names
import 'package:flutter/foundation.dart';
import 'insertQuestion.dart';

mixin GetAvailableAnswersInDb{
  Future<List<dynamic>> queryAnswers(String date) async {
    final allRows = await dbHelper.queryAllAnsRows();
    if (kDebugMode) {
      print('query all answer rows:');
    }
    // ignore: avoid_print
    allRows.forEach(print);
    List finalRows = [];
    for(var i=0; i< allRows.length; i++){
      if(allRows[i]['date']==date){
        finalRows.add(allRows[i]);
      }
    }
    return finalRows;
  }
}