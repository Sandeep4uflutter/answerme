// ignore_for_file: file_names
import 'package:flutter/foundation.dart';

import '../database/insertAnswer.dart';

mixin SetAnswers {
  void setAnswers(List questions, List answers, List date) {
    final insertAns = InsertAnsQuery();
    List finalAnswer = [];
    for (var i = 0; i < questions.length; i++) {
      finalAnswer.add(
          {
            "question": questions[i]['question'],
            "given_answer": answers[i],
            "correct_ans": questions[i]['correct_answer'],
            "date": date[i]}
      );
    }
    if(finalAnswer.isNotEmpty){
      insertAns.answerInsertToDb(finalAnswer);
    }
  }
}
