// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:projects/constants/colorConstants/appColors.dart';
import 'package:projects/constants/textConstants/appTextConstants.dart';
import '../../database/checkInsertedQuestions.dart';
import '../../database/checkSavedAnswers.dart';
import '../../functions/formatCurrentDate.dart';
import '../../functions/selectDate.dart';
import '../../functions/setAnswers.dart';
import '../widgets/alreadyAttempted.dart';
import '../widgets/bottomBar.dart';
import '../widgets/mainScreenCard.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SetAnswers,currentDate,GetAvailableQuestionsInDb, GetAvailableAnswersInDb{
  // <----------- variables ------------> //
  List allQuestions = [];
  List allResponses = [];
  List selectedAnswers = [];
  List dates = [];
  String? date;
  bool isOld = true;
  // <-----------variable declaration ends------------> //
  @override
  void initState(){
    super.initState();
    settingCurrDate();
  }
  void queries(String date){
    allQuestions = [];
    allResponses = [];
    queryQuests();
    queryAnswers(date.toString()).then((value) => [
      if(value.isEmpty){
        queryQuests().then((value) => [
          setState((){
            allQuestions = value;
            selectedAnswers.clear();
            dates.clear();
            for(var i=0; i<=allQuestions.length; i++){
              selectedAnswers.add('');
              dates.add(date);
            }
          })
        ])
      }else{
        setState(() {
        allResponses = value;
        }),
      }
    ]);
  }
  //<----- setting date to the view variable --------->
  void settingCurrDate(){
    var currDate = formatCurrentDate(DateTime.now());
    setState(() {
      date = currDate;
    });
    if(date!=null){
      queries(date!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        leading: Container(),
        leadingWidth: 0.0,
        elevation: 0,
        centerTitle: false,
        backgroundColor: AppColors.mainScreenAppBarColor,
        title: Text(AppTextConstant.mainScreenAppBar,style:TextStyle(
          color: AppColors.mainScreenAppBarTextColor,
          fontSize: 20,
          fontWeight: FontWeight.w400
        ),),
        actions: [
          IconButton(
              tooltip: AppTextConstant.mainScreenAppBarButtonToolTip,
              onPressed: (){
                var mySelectedDate = SelectDate();
                mySelectedDate.selectDate(context).then((value) => [
                  if(value!=null){
                    setState(() {
                      isOld = true;
                      date = value;
                      dates.clear();
                      for(var i=0; i<=allQuestions.length; i++){
                        dates.add(date);
                      }
                    }),
                    queries(date!)
                  }
                ]);
              },
              icon: Icon(Icons.calendar_today_outlined,
              color: AppColors.mainScreenAppBarIconColor,))
        ],
      ),
      backgroundColor: AppColors.appScaffoldColor,
      bottomNavigationBar: const BottomBar(),
      floatingActionButton: allQuestions.isEmpty?Container():Container(
        height: 80,
        decoration: BoxDecoration(
          color: AppColors.appScaffoldColor,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: FloatingActionButton.large(
            onPressed: () {
              setAnswers(allQuestions, selectedAnswers, dates);
              setState(() {
                isOld = false;
                Future.delayed(const Duration(milliseconds: 500), () {
                  queries(date!);
                });
              });
            },
            elevation: 0,
            heroTag: null,
            child: const Icon(Icons.check),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            MainCard(date: date.toString()),
            if(allQuestions.isNotEmpty)
            Padding(padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Container(
                 width: MediaQuery.of(context).size.width,
                 decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(10),
                 color: AppColors.hintCardColor,
                    ),
                 child: Padding(
                  padding: const EdgeInsets.all(8),
                   child: Center(
                    child:Text(AppTextConstant.hintText,style: TextStyle(fontSize: 14,
                    fontWeight: FontWeight.w400, color: AppColors.hintTextColor),),
              )),
            )),
            if(allQuestions.isNotEmpty)
              const Padding(padding: EdgeInsets.only(left: 50, right: 50, top: 2, bottom: 2),
            child: Divider(
              color: Colors.black,
              thickness: 1,
            ),),
            Expanded(
              child: allQuestions.isEmpty?AlreadyAttempted(isOld: isOld, responses: allResponses,):Builder(builder: (BuildContext context) {
                return PageView.builder(
                    itemCount: allQuestions.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, index){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // < ---------- question -------------->
                      Padding(padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1),
                              color: AppColors.questCardColor,
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(10),
                                child:Text(' Q ${index+1}. '+allQuestions[index]['question'], style: const TextStyle(
                                      height: 1,
                                      fontSize: 18, fontWeight: FontWeight.w500
                                  ),),
                                )),
                          ),
                      // < ---------- options --------------->
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            CheckboxListTile(
                              checkColor: Colors.white,
                              activeColor: Colors.blue,
                              value: selectedAnswers[index]=='-'?false:selectedAnswers[index]=='yes'?true:false,
                              title: const Text('Yes', style: TextStyle(fontSize: 18, color:
                              Colors.black),),
                              onChanged: (bool? value) {
                                setState(() {
                                   if(value==true){
                                     selectedAnswers[index]='yes';
                                   }else{
                                     selectedAnswers[index]='';
                                   }
                                });
                              },
                            ),
                            CheckboxListTile(
                              checkColor: Colors.white,
                              activeColor: Colors.blue,
                              value: selectedAnswers[index]=='-'?false:selectedAnswers[index]=='no'?true:false,
                              title: const Text('No', style: TextStyle(fontSize: 18, color:
                              Colors.black),),
                              onChanged: (bool? value) {
                                setState(() {
                                  if(value==true){
                                    selectedAnswers[index]='no';
                                  }else{
                                    selectedAnswers[index]='';
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                });
              },),
            )
          ],
        ),
      ),
    ));
  }
}
