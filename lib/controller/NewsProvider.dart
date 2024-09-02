import 'dart:convert';

import 'package:baba_karkar/constant/API-Url.dart';
import 'package:baba_karkar/main.dart';
import 'package:baba_karkar/model/News.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsProvider with ChangeNotifier {
  News news = News();
  News newsfromroom = News();
  List<News> listnews = [];
  List<News> listnewsroom = [];
  bool isloadinggetmynews = false;
  bool isloadinggetallnewsfromroom = false;

  Future<void> get_my_news() async {
    isloadinggetmynews = true;
    notifyListeners();
    listnews = [];
    notifyListeners();
    String? token = await servicesProvider.gettoken();
    print(token);
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.Request('GET', Uri.parse('$baseURL${AppApi.AllNews}'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        dynamic data = json.decode(await response.stream.bytesToString());
        for (var element in data) {
          news = News.fromJson(element);
          listnews.add(news);
          notifyListeners();
        }
        listnews = listnews.reversed.toList();
        notifyListeners();
        isloadinggetmynews = false;
        notifyListeners();
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
        isloadinggetmynews = false;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      isloadinggetmynews = false;
      notifyListeners();
    }
  }

  Future<void> allnewsfromroom(int? roomid) async {
    print(roomid);
    isloadinggetallnewsfromroom = true;
    notifyListeners();
    listnewsroom = [];

    notifyListeners();
    String? token = await servicesProvider.gettoken();
    print(token);
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.Request(
          'GET', Uri.parse('$baseURL${AppApi.AllNewsRoom(roomid!)}'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      // print(await response.stream.bytesToString());

      if (response.statusCode == 200) {
        dynamic data = json.decode(await response.stream.bytesToString());
        for (var element in data) {
          newsfromroom = News.fromJson(element);
          listnewsroom.add(newsfromroom);
          notifyListeners();
        }
        // listnewsroom = listnewsroom.reversed.toList();
        notifyListeners();
        print(listnewsroom.length);
        isloadinggetallnewsfromroom = false;
        notifyListeners();
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
        isloadinggetallnewsfromroom = false;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      isloadinggetallnewsfromroom = false;
      notifyListeners();
    }
  }
}
