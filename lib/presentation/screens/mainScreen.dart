// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/constants/colorConstants/appColors.dart';
import 'package:projects/constants/textConstants/appTextConstants.dart';
import 'package:projects/cubit/attemptDate/attemptDateCubit.dart';
import 'package:projects/cubit/date/dateCubit.dart';
import 'package:projects/cubit/loader/loaderCubit.dart';
import '../../cubit/attemptType/attemptTypeCubit.dart';
import '../../cubit/questionsView/questionsCubit.dart';
import '../../cubit/selectedAnswers/selectedAnswersCubit.dart';
import '../../cubit/userAnswersView/userAnswersCubit.dart';
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

class _MainScreenState extends State<MainScreen>
    with
        SetAnswers,
        currentDate,
        GetAvailableQuestionsInDb,
        GetAvailableAnswersInDb {
  // <----------- variables ------------> //
  List allQuestions = [];
  List selectedAnswers = [];
  String? date;
  // <-----------variable declaration ends------------> //
  @override
  void initState() {
    super.initState();
    settingCurrDate();
  }

  void queries(String date) {
    allQuestions = [];
    List selectedAns = [];
    List dates = [];
    BlocProvider.of<QuestionsCubit>(context).showQuestion([]);
    BlocProvider.of<UserAnswersCubit>(context).setAnswers([]);
    queryQuests();
    queryAnswers(date.toString()).then((value) => [
          if (value.isEmpty)
            {
              Future.delayed(const Duration(milliseconds: 500), () {
                queryQuests().then((value) => [
                      BlocProvider.of<LoaderCubit>(context).visibility(false),
                      BlocProvider.of<QuestionsCubit>(context)
                          .showQuestion(value),
                      BlocProvider.of<SelectedAnswersCubit>(context)
                          .saveAnswers([]),
                      allQuestions = value,
                      dates.clear(),
                      for (var i = 0; i <= allQuestions.length; i++)
                        {
                          selectedAns.add(''),
                          dates.add(date),
                        },
                      BlocProvider.of<AttemptDateCubit>(context)
                          .showQuestion(dates),
                      BlocProvider.of<SelectedAnswersCubit>(context)
                          .saveAnswers(selectedAns),
                    ]);
              })
            }
          else
            {
              BlocProvider.of<LoaderCubit>(context).visibility(false),
              BlocProvider.of<UserAnswersCubit>(context).setAnswers(value),
            }
        ]);
  }

  //<----- setting date to the view variable --------->
  void settingCurrDate() {
    var currDate = formatCurrentDate(DateTime.now());
    date = currDate;
    if (date != null) {
      queries(date!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 40,
              leading: Container(),
              leadingWidth: 0.0,
              elevation: 0,
              centerTitle: false,
              backgroundColor: AppColors.mainScreenAppBarColor,
              title: Text(
                AppTextConstant.mainScreenAppBar,
                style: TextStyle(
                    color: AppColors.mainScreenAppBarTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
              actions: [
                IconButton(
                    tooltip: AppTextConstant.mainScreenAppBarButtonToolTip,
                    onPressed: () {
                      List dates = [];
                      var mySelectedDate = SelectDate();
                      mySelectedDate.selectDate(context).then((value) => [
                            if (value != null)
                              {
                                BlocProvider.of<DateCubit>(context).updateDate(value),
                                BlocProvider.of<LoaderCubit>(context).visibility(true),
                                BlocProvider.of<AttemptTypeCubit>(context).attemptStatus(true),
                                for (var i = 0; i <= allQuestions.length; i++){dates.add(value)},
                                BlocProvider.of<AttemptDateCubit>(context).showQuestion(dates),
                                queries(value),
                              }
                          ]);
                    },
                    icon: Icon(
                      Icons.calendar_today_outlined,
                      color: AppColors.mainScreenAppBarIconColor,
                    ))
              ],
            ),
            backgroundColor: AppColors.appScaffoldColor,
            bottomNavigationBar: const BottomBar(),
            floatingActionButton: BlocConsumer<QuestionsCubit, QuestionState>(
                listener: (questContext, questState) {},
                builder: (questContext, questState) {
                  return questState.allQuestions.isEmpty
                      ? Container()
                      : Container(
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.appScaffoldColor,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: BlocConsumer<SelectedAnswersCubit,
                                      SelectedAnswersState>(
                                  listener:
                                      (selectedAnsContext, selectedAnsState) {},
                                  builder:
                                      (selectedAnsContext, selectedAnsState) {
                                    return BlocConsumer<AttemptDateCubit,
                                            AttemptDateState>(
                                        listener: (attemptDateContext,
                                            attemptDateState) {},
                                        builder: (attemptDateContext,
                                            attemptDateState) {
                                          return FloatingActionButton.large(
                                            onPressed: () {
                                              setAnswers(
                                                  questState.allQuestions,
                                                  selectedAnsState
                                                      .selectedAnswers,
                                                  attemptDateState.dates);
                                              BlocProvider.of<AttemptTypeCubit>(context).attemptStatus(false);
                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 500), () {
                                                queries(
                                                    attemptDateState.dates[0]!);
                                              });
                                            },
                                            elevation: 0,
                                            heroTag: null,
                                            child: const Icon(Icons.check),
                                          );
                                        });
                                  })),
                        );
                }),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: BlocConsumer<QuestionsCubit, QuestionState>(
                listener: (questContext, questState) {},
                builder: (questContext, questState) {
                  return BlocConsumer<LoaderCubit, LoaderState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              MainCard(date: date.toString()),
                              if (questState.allQuestions.isNotEmpty)
                                Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.hintCardColor,
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Center(
                                            child: Text(
                                              AppTextConstant.hintText,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      AppColors.hintTextColor),
                                            ),
                                          )),
                                    )),
                              if (questState.allQuestions.isNotEmpty)
                                const Padding(
                                  padding: EdgeInsets.only(
                                      left: 50, right: 50, top: 2, bottom: 2),
                                  child: Divider(
                                    color: Colors.black,
                                    thickness: 1,
                                  ),
                                ),
                              if (state.visibility == false)
                                Expanded(
                                    child: questState.allQuestions.isEmpty
                                        ? BlocConsumer<AttemptTypeCubit,
                                                AttemptTypeState>(
                                            listener: (attemptTypeContext,
                                                attemptTypeState) {},
                                            builder:
                                                (attemptTypeContext, attemptTypeState) {
                                              return BlocConsumer<UserAnswersCubit,
                                                  UserAnswersState>(
                                                  listener: (userAnsContext,
                                                      userAnsState) {},
                                                  builder:
                                                      (userAnsContext, userAnsState) {
                                                    return AlreadyAttempted(
                                                      isOld: attemptTypeState.isOld,
                                                      responses: userAnsState.answers,
                                                    );
                                                  });
                                            })
                                        : BlocConsumer<SelectedAnswersCubit,
                                                SelectedAnswersState>(
                                            listener: (selectedAnswersContext,
                                                selectedAnswersState) {},
                                            builder: (selectedAnswersContext,
                                                selectedAnswersState) {
                                              return Builder(
                                                builder:
                                                    (BuildContext context) {
                                                  return PageView.builder(
                                                      itemCount: questState
                                                          .allQuestions.length,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              index) {
                                                        return Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            // < ---------- question -------------->
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      8,
                                                                      10,
                                                                      8,
                                                                      8),
                                                              child: Container(
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(1),
                                                                    color: AppColors
                                                                        .questCardColor,
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            10),
                                                                    child: Text(
                                                                      ' Q ${index + 1}. ' +
                                                                          questState.allQuestions[index]
                                                                              [
                                                                              'question'],
                                                                      style: const TextStyle(
                                                                          height:
                                                                              1,
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                  )),
                                                            ),
                                                            // < ---------- options --------------->
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8),
                                                              child: Column(
                                                                children: [
                                                                  CheckboxListTile(
                                                                    checkColor:
                                                                        Colors
                                                                            .white,
                                                                    activeColor:
                                                                        Colors
                                                                            .blue,
                                                                    value: selectedAnswersState.selectedAnswers[index] ==
                                                                            '-'
                                                                        ? false
                                                                        : selectedAnswersState.selectedAnswers[index] ==
                                                                                'yes'
                                                                            ? true
                                                                            : false,
                                                                    title:
                                                                        const Text(
                                                                      'Yes',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                    onChanged:
                                                                        (bool?
                                                                            value) {
                                                                      setState(
                                                                          () {
                                                                        if (value ==
                                                                            true) {
                                                                          selectedAnswersState.selectedAnswers[index] =
                                                                              'yes';
                                                                        } else {
                                                                          selectedAnswersState.selectedAnswers[index] =
                                                                              '';
                                                                        }
                                                                      });
                                                                    },
                                                                  ),
                                                                  CheckboxListTile(
                                                                    checkColor:
                                                                        Colors
                                                                            .white,
                                                                    activeColor:
                                                                        Colors
                                                                            .blue,
                                                                    value: selectedAnswersState.selectedAnswers[index] ==
                                                                            '-'
                                                                        ? false
                                                                        : selectedAnswersState.selectedAnswers[index] ==
                                                                                'no'
                                                                            ? true
                                                                            : false,
                                                                    title:
                                                                        const Text(
                                                                      'No',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                    onChanged:
                                                                        (bool?
                                                                            value) {
                                                                      setState(
                                                                          () {
                                                                        if (value ==
                                                                            true) {
                                                                          selectedAnswersState.selectedAnswers[index] =
                                                                              'no';
                                                                        } else {
                                                                          selectedAnswersState.selectedAnswers[index] =
                                                                              '';
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
                                                },
                                              );
                                            }))
                              else
                                const Expanded(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                            ],
                          ),
                        );
                      });
                })));
  }
}
