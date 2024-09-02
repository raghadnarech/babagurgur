import 'dart:convert';
import 'dart:io';

import 'package:baba_karkar/constant/API-Url.dart';
import 'package:baba_karkar/main.dart';
import 'package:baba_karkar/model/Homework.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeworkProvider with ChangeNotifier {
  Homework homework = Homework();
  List<Homework> listhomework = [];
  List<Homework> listmyhomework = [];
  bool isloadinggetallhomework = false;
  bool isloadingsendhomework = false;
  bool isloadinggetmyhomework = false;

  Future<bool> SendHMToRoom({String? text, File? image, int? roomid}) async {
    String? token = await servicesProvider.gettoken();
    isloadingsendhomework = true;
    notifyListeners();
    print(token);
    print(image);

    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseURL${AppApi.CreateHomeWork(roomid!)}'));
      request.fields.addAll({
        'text': text!,
      });
      if (image != null) {
        request.files.addAll([
          await http.MultipartFile.fromPath(
            'image',
            image.path,
          ),
        ]);
      }

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print(response.stream.bytesToString());

      if (response.statusCode == 200) {
        isloadingsendhomework = false;
        notifyListeners();

        return true;
      } else {
        print(response.reasonPhrase);
        isloadingsendhomework = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print(e);
      isloadingsendhomework = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> allhmfromroom(int? roomid) async {
    print(roomid);
    isloadinggetallhomework = true;
    notifyListeners();
    listhomework = [];
    notifyListeners();
    String? token = await servicesProvider.gettoken();
    print(token);
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.Request(
          'GET', Uri.parse('$baseURL${AppApi.AllHWRoom(roomid!)}'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      // print(await response.stream.bytesToString());

      if (response.statusCode == 200) {
        dynamic data = json.decode(await response.stream.bytesToString());
        for (var element in data) {
          homework = Homework.fromJson(element);
          listhomework.add(homework);
          notifyListeners();
        }
        // listhomework = listhomework.reversed.toList();
        notifyListeners();
        isloadinggetallhomework = false;
        notifyListeners();
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
        isloadinggetallhomework = false;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      isloadinggetallhomework = false;
      notifyListeners();
    }
  }

  Future<void> allmyhomework() async {
    isloadinggetmyhomework = true;
    notifyListeners();
    listmyhomework = [];
    notifyListeners();
    String? token = await servicesProvider.gettoken();
    print(token);
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.Request('GET', Uri.parse('$baseURL${AppApi.AllHW}'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      // print(await response.stream.bytesToString());

      if (response.statusCode == 200) {
        dynamic data = json.decode(await response.stream.bytesToString());
        for (var element in data) {
          homework = Homework.fromJson(element);
          listmyhomework.add(homework);
          notifyListeners();
        }
        listmyhomework = listmyhomework.reversed.toList();
        notifyListeners();
        isloadinggetmyhomework = false;
        notifyListeners();
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
        isloadinggetmyhomework = false;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      isloadinggetmyhomework = false;
      notifyListeners();
    }
  }
}
