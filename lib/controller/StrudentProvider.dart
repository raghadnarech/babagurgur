import 'dart:convert';

import 'package:baba_karkar/constant/API-Url.dart';
import 'package:baba_karkar/main.dart';
import 'package:baba_karkar/model/Student.dart';
import 'package:baba_karkar/view/Student/Home/HomePageStudent.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';

class StudentProvider with ChangeNotifier {
  bool isloadinggetallstudent = false;
  bool isloadingaddstudent = false;
  bool isloadingdeleteuser = false;
  bool isloadingjoinStudentToGroup = false;
  bool isloadingSelectmyroom = false;
  bool isloadingselectclassroomstudent = false;
  bool isloadinggetallstudentfromroom = false;

  Student student = Student();
  List<Student> liststudent = [];
  List<Student> liststudentfromroom = [];

  //جلب حميع الطلاب
  Future<void> get_all_student() async {
    liststudent = [];
    notifyListeners();
    String? token = await servicesProvider.gettoken();
    isloadinggetallstudent = true;
    notifyListeners();
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request =
          http.Request('GET', Uri.parse('$baseURL${AppApi.AllStudent}'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      // print(await response.stream.bytesToString());

      if (response.statusCode == 200) {
        dynamic data = json.decode(await response.stream.bytesToString());
        for (var element in data) {
          student = Student.fromJson(element);
          liststudent.add(student);
          notifyListeners();
        }
        isloadinggetallstudent = false;
        notifyListeners();
        print(await response.stream.bytesToString());
      } else {
        isloadinggetallstudent = false;
        notifyListeners();
        print(response.reasonPhrase);
      }
    } catch (e) {
      isloadinggetallstudent = false;
      notifyListeners();
    }
  }

  Future<void> get_all_student_from_room(int? roomid) async {
    liststudentfromroom = [];
    notifyListeners();
    String? token = await servicesProvider.gettoken();
    isloadinggetallstudentfromroom = true;
    notifyListeners();
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.Request(
          'GET', Uri.parse('$baseURL${AppApi.StudentFromRoom(roomid!)}'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      // print(await response.stream.bytesToString());

      if (response.statusCode == 200) {
        dynamic data = json.decode(await response.stream.bytesToString());
        for (var element in data) {
          student = Student.fromJson(element['user'][0]);
          liststudentfromroom.add(student);
          notifyListeners();
        }
        isloadinggetallstudentfromroom = false;
        notifyListeners();
        // print(await response.stream.bytesToString());
      } else {
        isloadinggetallstudentfromroom = false;
        notifyListeners();
        print(response.reasonPhrase);
      }
    } catch (e) {
      isloadinggetallstudentfromroom = false;
      notifyListeners();
    }
  }

//إضافة طالب جديد
  Future<bool> add_student(
      {String? name, String? phone, String? password}) async {
    String? token = await servicesProvider.gettoken();
    isloadingaddstudent = true;
    notifyListeners();
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseURL${AppApi.CreateStudent}'));
      request.fields.addAll({
        'name': name!,
        'phone': phone!,
        'password': password!,
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print(response.statusCode);
      if (response.statusCode == 200) {
        isloadingaddstudent = false;
        notifyListeners();
        print(await response.stream.bytesToString());
        return true;
      } else {
        print(response.reasonPhrase);
        isloadingaddstudent = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      isloadingaddstudent = false;
      notifyListeners();
      return false;
    }
  }

//حذف طالب
  Future<bool> delete_user({int? userid}) async {
    String? token = await servicesProvider.gettoken();
    isloadingdeleteuser = true;
    notifyListeners();
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.Request(
          'GET', Uri.parse('$baseURL${AppApi.DeleteUser(userid!)}'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      // print(await response.stream.bytesToString());

      if (response.statusCode == 200) {
        isloadingdeleteuser = false;
        notifyListeners();
        print(await response.stream.bytesToString());
        return true;
      } else {
        isloadingdeleteuser = false;
        notifyListeners();
        print(response.reasonPhrase);
        return false;
      }
    } catch (e) {
      isloadingdeleteuser = false;
      notifyListeners();
      return false;
    }
  }

//إسناد طالب إلى شعبة
  Future<bool> select_classroom_user(String? userid, String? roomid) async {
    String? token = await servicesProvider.gettoken();
    isloadingselectclassroomstudent = true;
    notifyListeners();
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseURL${AppApi.SelectClassroomStudent}'));
      request.fields.addAll({
        'user_id': userid!,
        'room_id': roomid!,
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        isloadingselectclassroomstudent = false;
        notifyListeners();
        print(await response.stream.bytesToString());
        return true;
      } else {
        isloadingselectclassroomstudent = false;
        notifyListeners();
        print(response.reasonPhrase);
        return false;
      }
    } catch (e) {
      isloadingselectclassroomstudent = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> joinStudentToGroup({int? studentid}) async {
    String? token = await servicesProvider.gettoken();
    isloadingjoinStudentToGroup = true;
    notifyListeners();
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.Request(
          'GET', Uri.parse('$baseURL${AppApi.JoinStudentToGroup(studentid!)}'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      // print(await response.stream.bytesToString());

      if (response.statusCode == 200) {
        isloadingjoinStudentToGroup = false;
        notifyListeners();
        print(await response.stream.bytesToString());
        return true;
      } else {
        isloadingjoinStudentToGroup = false;
        notifyListeners();
        print(response.reasonPhrase);
        return false;
      }
    } catch (e) {
      isloadingjoinStudentToGroup = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> SelectMyRoom({int? roomid, BuildContext? context}) async {
    String? token = await servicesProvider.gettoken();
    isloadingSelectmyroom = true;
    notifyListeners();
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.Request(
          'POST', Uri.parse('$baseURL${AppApi.SelectMyRoom(roomid!)}'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      // print(await response.stream.bytesToString());

      if (response.statusCode == 200) {
        isloadingSelectmyroom = false;
        notifyListeners();
        authprovider.get_profile_user(context!);
        print(await response.stream.bytesToString());

        return true;
      } else {
        isloadingSelectmyroom = false;
        notifyListeners();
        print(response.reasonPhrase);
        return false;
      }
    } catch (e) {
      isloadingSelectmyroom = false;
      notifyListeners();
      return false;
    }
  }
}
