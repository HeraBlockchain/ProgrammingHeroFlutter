import 'dart:convert';

QuestionList questionListFromJson(String str) =>
    QuestionList.fromJson(json.decode(str));

class QuestionList {
  List<Question>? questions;

  QuestionList({
    this.questions,
  });

  factory QuestionList.fromJson(Map<String, dynamic> json) => QuestionList(
        questions: json["questions"] == null
            ? null
            : List<Question>.from(
                json["questions"].map((x) => Question.fromJson(x))),
      );
}

class Question {
  String? question;
  Answers? answers;
  String? questionImageUrl;
  String? correctAnswer;
  int? score;

  Question({
    this.question,
    this.answers,
    this.questionImageUrl,
    this.correctAnswer,
    this.score,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        question: json["question"],
        answers: Answers.fromJson(json["answers"]),
        questionImageUrl: json["questionImageUrl"],
        correctAnswer: json["correctAnswer"],
        score: json["score"],
      );
}

class Answers {
  Answers({
    this.a,
    this.b,
    this.c,
    this.d,
  });

  String? a;
  String? b;
  String? c;
  String? d;

  factory Answers.fromJson(Map<String, dynamic> json) => Answers(
        a: json["A"],
        b: json["B"],
        c: json["C"],
        d: json["D"],
      );
}
