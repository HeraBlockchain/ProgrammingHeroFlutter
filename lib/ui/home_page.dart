// ignore_for_file: unnecessary_new

import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:programming_hero_quiz/model/question_list_model.dart';
import 'package:programming_hero_quiz/ui/quiz_page.dart';
import '../repositiory/api_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  APIRepository apiRepository = APIRepository();
  bool isLoading = false;
  int score = 0;
  @override
  void initState() {
    super.initState();

    // Full screen width and height
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = 250;
    return LoadingOverlay(
        color: Colors.redAccent,
        progressIndicator: const CircularProgressIndicator(color: Colors.red),
        isLoading: isLoading,
        child: Scaffold(
          body: Container(
            color: const Color.fromRGBO(0, 2, 49, 1.0),
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Spacer(),
                topContainer(width, height),
                const SizedBox(height: 30),
                centerContainer(width, height),
                const SizedBox(height: 30),
                bottomContainer(width, height, context),
                const Spacer(),
              ],
            ),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }

  FDottedLine topContainer(double width, double height) {
    return FDottedLine(
      width: width,
      height: height,
      color: Colors.white,
      strokeWidth: 2.0,
      dottedLength: 10.0,
      space: 2.0,
      corner: FDottedLineCorner.all(6),
      child: Container(
        height: height,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            const Spacer(),
            Column(children: [
              const Spacer(),
              Container(
                width: width - 60,
                height: 120,
                child: Image.asset('assets/Logo.png'),
              ),
              const Spacer(),
              Text(
                'Quiz',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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

  FDottedLine centerContainer(double width, double height) {
    return FDottedLine(
      width: width,
      height: height / 3.0,
      color: Colors.white,
      strokeWidth: 2.0,
      dottedLength: 10.0,
      space: 2.0,
      corner: FDottedLineCorner.all(8),
      child: Container(
        height: height / 3.0,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            const Spacer(),
            Column(children: [
              const Spacer(),
              const Text(
                'Highscore',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Text(
                '$score',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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

  FDottedLine bottomContainer(
      double width, double height, BuildContext context) {
    return FDottedLine(
      width: width,
      height: height / 3.0,
      color: Colors.white,
      strokeWidth: 2.0,
      dottedLength: 10.0,
      space: 2.0,
      corner: FDottedLineCorner.all(8),
      child: Container(
        height: height / 3.0,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6))),
              child: const Text(
                'Start',
                style: TextStyle(fontSize: 22, color: Colors.black),
              ),
              onPressed: () {
                _getQuestionList(context);
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Future<void> _getQuestionList(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    try {
      QuestionList questionList = await apiRepository.getQuestionListInfo();
      setState(() {
        isLoading = false;
        _navigateAndDisplaySelection(context, questionList);
        // Navigator.push(
        //     context,
        //     new MaterialPageRoute(
        //         builder: (context) => QuizPage(list: questionList)));
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.toString());
    }
  }

  // A method that launches the SelectionScreen and awaits the result from
// Navigator.pop.
  Future<void> _navigateAndDisplaySelection(
      BuildContext context, QuestionList questionList) async {
    final result = await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => QuizPage(list: questionList)));

    setState(() {
      score = result;
    });
    print(result);
  }
}
