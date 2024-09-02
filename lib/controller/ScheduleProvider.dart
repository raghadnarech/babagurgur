import 'dart:convert';
import 'dart:io';

import 'package:baba_karkar/constant/API-Url.dart';
import 'package:baba_karkar/main.dart';
import 'package:baba_karkar/model/Schedule.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ScheduleProvider with ChangeNotifier {
  Schedule scheduleexam = Schedule();
  Schedule scheduleweek = Schedule();
  bool isloadinggetscheduleexam = false;
  bool isloadinggsendscheduleexam = false;
  bool isloadinggupdatescheduleexam = false;
  bool isloadinggetscheduleweek = false;
  bool isloadinggsendscheduleweek = false;
  bool isloadinggupdatescheduleweek = false;

  Future<void> get_schedule_exam() async {
    String? token = await servicesProvider.gettoken();
    isloadinggetscheduleexam = true;
    notifyListeners();
    // print();

    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.MultipartRequest(
          'GET',
          Uri.parse(
              '$baseURL${AppApi.ScheduleExam(servicesProvider.sharedPreferences!.getInt('roomid_student')!)}'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      // print(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        dynamic data = json.decode(await response.stream.bytesToString());
        // print(data);
        scheduleexam = Schedule.fromJson(data);
        print(data);
        notifyListeners();
        isloadinggetscheduleexam = false;
        notifyListeners();

        // return true;
      } else {
        print(response.reasonPhrase);
        isloadinggetscheduleexam = false;
        notifyListeners();
        // return false;
      }
    } catch (e) {
      print(e);
      isloadinggetscheduleexam = false;
      notifyListeners();
      // return false;
    }
  }

  Future<bool> CreateExamSchedule({File? image, int? roomid}) async {
    String? token = await servicesProvider.gettoken();
    isloadinggsendscheduleexam = true;
    notifyListeners();
    print(token);
    print(roomid);
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseURL${AppApi.CreateExamSchedule(roomid!)}'));

      request.files.addAll([
        await http.MultipartFile.fromPath(
          'image',
          image!.path,
        ),
      ]);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print(response.stream.bytesToString());

      if (response.statusCode == 200) {
        isloadinggsendscheduleexam = false;
        notifyListeners();

        return true;
      } else {
        print(response.reasonPhrase);
        isloadinggsendscheduleexam = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print(e);
      isloadinggsendscheduleexam = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> UpdateExamSchedule({File? image, int? roomid}) async {
    String? token = await servicesProvider.gettoken();
    isloadinggupdatescheduleexam = true;
    notifyListeners();
    print(token);
    print(roomid);
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseURL${AppApi.UpdateExamSchedule(roomid!)}'));

      request.files.addAll([
        await http.MultipartFile.fromPath(
          'image',
          image!.path,
        ),
      ]);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print(response.stream.bytesToString());

      if (response.statusCode == 200) {
        isloadinggupdatescheduleexam = false;
        notifyListeners();

        return true;
      } else {
        print(response.reasonPhrase);
        isloadinggupdatescheduleexam = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print(e);
      isloadinggupdatescheduleexam = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> get_schedule_weekly() async {
    String? token = await servicesProvider.gettoken();
    isloadinggetscheduleweek = true;
    notifyListeners();
    // print();

    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.MultipartRequest(
          'GET',
          Uri.parse(
              '$baseURL${AppApi.ScheduleWeek(servicesProvider.sharedPreferences!.getInt('roomid_student')!)}'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      // print(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        dynamic data = json.decode(await response.stream.bytesToString());
        // print(data);
        scheduleweek = Schedule.fromJson(data);
        print(data);
        notifyListeners();
        isloadinggetscheduleweek = false;
        notifyListeners();

        // return true;
      } else {
        print(response.reasonPhrase);
        isloadinggetscheduleweek = false;
        notifyListeners();
        // return false;
      }
    } catch (e) {
      print(e);
      isloadinggetscheduleweek = false;
      notifyListeners();
      // return false;
    }
  }

  Future<bool> CreateWeeklySchedule({File? image, int? roomid}) async {
    String? token = await servicesProvider.gettoken();
    isloadinggsendscheduleweek = true;
    notifyListeners();
    print(token);
    print(roomid);
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseURL${AppApi.CreateWeeklySchedule(roomid!)}'));

      request.files.addAll([
        await http.MultipartFile.fromPath(
          'image',
          image!.path,
        ),
      ]);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print(response.stream.bytesToString());

      if (response.statusCode == 200) {
        isloadinggsendscheduleweek = false;
        notifyListeners();

        return true;
      } else {
        print(response.reasonPhrase);
        isloadinggsendscheduleweek = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print(e);
      isloadinggsendscheduleweek = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> UpdateWeeklySchedule({File? image, int? roomid}) async {
    String? token = await servicesProvider.gettoken();
    isloadinggupdatescheduleweek = true;
    notifyListeners();
    print(token);
    print(roomid);
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseURL${AppApi.UpdateWeeklySchedule(roomid!)}'));

      request.files.addAll([
        await http.MultipartFile.fromPath(
          'image',
          image!.path,
        ),
      ]);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print(response.stream.bytesToString());

      if (response.statusCode == 200) {
        isloadinggupdatescheduleweek = false;
        notifyListeners();

        return true;
      } else {
        print(response.reasonPhrase);
        isloadinggupdatescheduleweek = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print(e);
      isloadinggupdatescheduleweek = false;
      notifyListeners();
      return false;
    }
  }
}
