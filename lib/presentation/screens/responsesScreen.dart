// ignore_for_file: file_names
import 'package:flutter/material.dart';

import '../../constants/colorConstants/appColors.dart';
import '../../constants/textConstants/appTextConstants.dart';

class ResponsesScreen extends StatefulWidget {
  const ResponsesScreen({Key? key, required this.response}) : super(key: key);
  final List response;
  @override
  State<ResponsesScreen> createState() => _ResponsesScreenState();
}

class _ResponsesScreenState extends State<ResponsesScreen> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      backgroundColor: AppColors.appScaffoldColor,
      appBar: AppBar(
      toolbarHeight: 40,
        iconTheme: IconThemeData(
          color: AppColors.leadingIconColor, //change your color here
        ),
      elevation: 0,
      centerTitle: false,
      backgroundColor: AppColors.otherScreenAppBarColor,
      title: Text(AppTextConstant.responseScreenAppBarText,style:TextStyle(
          color: AppColors.otherScreenAppBarTextColor,
          fontSize: 20,
          fontWeight: FontWeight.w400
      ),),
    ),
    body: ListView.builder(
        itemCount: widget.response.length,
        itemBuilder: (BuildContext context, index){
      return Padding(
        padding: const EdgeInsets.all(8),
        child:Container(
          width: MediaQuery.of(context).size.width,
          color: AppColors.responseScreenCardColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: const EdgeInsets.fromLTRB(10, 8, 10, 4),
              child:Text( 'Q ${index+1}.  '+widget.response[index]['question'],
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.responseScreenQuestionText),),),
              Padding(padding: const EdgeInsets.fromLTRB(10, 4, 10, 8),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text( 'Ans .  '+widget.response[index]['answer'],
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.responseScreenAnswerText),),
                   if(widget.response[index]['correct_answer'].trim() == widget.response[index]['answer'].trim() && widget.response[index]['answer'].trim() != '')
                     Icon(Icons.check, color: AppColors.responseScreenCorrectAnsIconColor,),
                    if(widget.response[index]['correct_answer'].trim() != widget.response[index]['answer'].trim() && widget.response[index]['answer'].trim() != '')
                     Icon(Icons.clear, color: AppColors.responseScreenWrongAnsIconColor,)
                  ],
                ),),
              if(widget.response[index]['answer'].trim() == '')
                Padding(padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
                child:Text(AppTextConstant.responseScreenLeftAnsText,
                  style:  TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.responseScreenLeftAnsColor),),),

            ],
          ),
        ),
      );
    }),));
  }
}
