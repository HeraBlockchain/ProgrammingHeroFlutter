import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:programming_hero_quiz/model/question_list_model.dart';

class APIRepository {
  Future<QuestionList> getQuestionListInfo() async {
    const url = 'https://herosapp.nyc3.digitaloceanspaces.com/quiz.json';

    Client client = Client();
    final resp = await client.get(Uri.parse(url));
    var responseJson = json.decode(resp.body.toString());
    print(responseJson);
    var list = QuestionList.fromJson(responseJson);
    return list;
  }
}
