import 'dart:async';

import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:programming_hero_quiz/model/question_list_model.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key, required this.list}) : super(key: key);
  final QuestionList list;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  bool isLoading = false;
  int questionIndex = 0;
  int totalScore = 0;
  int totalQuestion = 0;
  String selectedAnswer = '';
  late BuildContext ctx;

  @override
  void initState() {
    super.initState();

    totalQuestion = widget.list.questions?.length ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top + kToolbarHeight);
    return LoadingOverlay(
        color: Colors.redAccent,
        progressIndicator: const CircularProgressIndicator(color: Colors.red),
        isLoading: isLoading,
        child: Scaffold(
          appBar: AppBar(),
          body: Container(
            color: const Color.fromRGBO(0, 2, 49, 1.0),
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                quizmarkContainer(width, height),
                const SizedBox(height: 30),
                topContainer(width, height),
                const SizedBox(height: 30),
                bottomContainer(width, height),
                const Spacer(),
              ],
            ),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }

  FDottedLine quizmarkContainer(double width, double height) {
    var qindex = questionIndex + 1;
    return FDottedLine(
      width: width,
      height: (height * 0.7) / 10.0,
      color: Colors.white,
      strokeWidth: 2.0,
      dottedLength: 10.0,
      space: 2.0,
      corner: FDottedLineCorner.all(8),
      child: Container(
        height: (height * 0.7) / 10.0,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Text(
              'Question: $qindex/$totalQuestion',
              style: const TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            Text(
              'Score: $totalScore',
              style: const TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  FDottedLine topContainer(double width, double height) {
    var points = widget.list.questions?.elementAt(questionIndex).score ?? 0;

    return FDottedLine(
      width: width,
      height: (height * 4) / 10.0,
      color: Colors.white,
      strokeWidth: 2.0,
      dottedLength: 10.0,
      space: 2.0,
      corner: FDottedLineCorner.all(6),
      child: Container(
        height: (height * 4) / 10.0,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            const Spacer(),
            Column(children: [
              const Spacer(),
              SizedBox(
                width: width - 60,
                child: Center(
                  child: Text(
                    '$points Points',
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: width - 60,
                height: (((height * 4) / 10.0) * 3) / 10.0,
                child: Image.asset('assets/Logo.png'),
              ),
              const Spacer(),
              SizedBox(
                width: width - 60,
                child: Center(
                  child: Text(
                    widget.list.questions?.elementAt(questionIndex).question ??
                        '',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ]),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  FDottedLine bottomContainer(double width, double height) {
    var widthPercent = 7;
    return FDottedLine(
      width: width,
      height: (height * 3) / 10.0,
      color: Colors.white,
      strokeWidth: 2.0,
      dottedLength: 10.0,
      space: 2.0,
      corner: FDottedLineCorner.all(8),
      child: Container(
        height: (height * 3) / 10.0,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            const Spacer(),
            Column(
              children: [
                const Spacer(),
                SizedBox(
                  width: (width * widthPercent) / 10.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        side: BorderSide(
                            color: widget.list.questions
                                        ?.elementAt(questionIndex)
                                        .correctAnswer
                                        ?.toLowerCase() ==
                                    selectedAnswer
                                ? Colors.green
                                : Colors.red,
                            width: selectedAnswer == 'a' ? 4 : 0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6))),
                    child: Center(
                      child: Text(
                        widget.list.questions
                                ?.elementAt(questionIndex)
                                .answers
                                ?.a ??
                            '',
                        style:
                            const TextStyle(fontSize: 17, color: Colors.black),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedAnswer = 'a';
                        checkingAnswers();
                      });
                    },
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: (width * widthPercent) / 10.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        side: BorderSide(
                            color: widget.list.questions
                                        ?.elementAt(questionIndex)
                                        .correctAnswer
                                        ?.toLowerCase() ==
                                    selectedAnswer
                                ? Colors.green
                                : Colors.red,
                            width: selectedAnswer == 'b' ? 4 : 0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6))),
                    child: Center(
                      child: Text(
                        widget.list.questions
                                ?.elementAt(questionIndex)
                                .answers
                                ?.b ??
                            '',
                        style:
                            const TextStyle(fontSize: 17, color: Colors.black),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedAnswer = 'b';
                        checkingAnswers();
                      });
                    },
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: (width * widthPercent) / 10.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        side: BorderSide(
                            color: widget.list.questions
                                        ?.elementAt(questionIndex)
                                        .correctAnswer
                                        ?.toLowerCase() ==
                                    selectedAnswer
                                ? Colors.green
                                : Colors.red,
                            width: selectedAnswer == 'c' ? 4 : 0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6))),
                    child: Center(
                      child: Text(
                        widget.list.questions
                                ?.elementAt(questionIndex)
                                .answers
                                ?.c ??
                            '',
                        style:
                            const TextStyle(fontSize: 17, color: Colors.black),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedAnswer = 'c';
                        checkingAnswers();
                      });
                    },
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: (width * widthPercent) / 10.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 0),
                        side: BorderSide(
                            color: widget.list.questions
                                        ?.elementAt(questionIndex)
                                        .correctAnswer
                                        ?.toLowerCase() ==
                                    selectedAnswer
                                ? Colors.green
                                : Colors.red,
                            width: selectedAnswer == 'd' ? 4 : 0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6))),
                    child: Center(
                      child: Text(
                        widget.list.questions
                                ?.elementAt(questionIndex)
                                .answers
                                ?.d ??
                            '',
                        style:
                            const TextStyle(fontSize: 17, color: Colors.black),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedAnswer = 'd';
                        checkingAnswers();
                      });
                    },
                  ),
                ),
                const Spacer(),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  void checkingAnswers() {
    var length = widget.list.questions?.length ?? 0;
    if (questionIndex >= length - 1) {
      Navigator.pop(ctx, totalScore);
    } else {
      setState(() {
        isLoading = true;
        scheduleTimeout(1 * 1000);
      });
    }
  }

  Timer scheduleTimeout([int milliseconds = 10000]) => Timer(
      Duration(milliseconds: milliseconds), updateQuestionAndAnswerPoints);

  void updateQuestionAndAnswerPoints() {
    if (widget.list.questions
            ?.elementAt(questionIndex)
            .correctAnswer
            ?.toLowerCase() ==
        selectedAnswer) {
      totalScore += widget.list.questions?.elementAt(questionIndex).score ?? 0;
    }
    selectedAnswer = '';
    questionIndex++;
    setState(() {
      isLoading = false;
    });
  }
}
