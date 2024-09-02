import 'dart:convert';

import 'package:baba_karkar/constant/API-Url.dart';
import 'package:baba_karkar/main.dart';
import 'package:baba_karkar/model/Student.dart';
import 'package:baba_karkar/model/Teacher.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TeacherProvider with ChangeNotifier {
  bool isloadinggetallteacher = false;
  bool isloadingaddteacher = false;
  bool isloadingupdateprofilestudentfromadmin = false;
  bool isloadingdeleteuser = false;

  Teacher teacher = Teacher();
  List<Teacher> listteacher = [];
  Future<void> get_all_teacher() async {
    listteacher = [];
    notifyListeners();
    String? token = await servicesProvider.gettoken();
    isloadinggetallteacher = true;
    notifyListeners();
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request =
          http.Request('GET', Uri.parse('$baseURL${AppApi.AllTeacher}'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        dynamic data = json.decode(await response.stream.bytesToString());
        for (var element in data) {
          teacher = Teacher.fromJson(element);
          listteacher.add(teacher);
          notifyListeners();
        }
        isloadinggetallteacher = false;
        notifyListeners();
        print(await response.stream.bytesToString());
      } else {
        isloadinggetallteacher = false;
        notifyListeners();
        print(response.reasonPhrase);
      }
    } catch (e) {
      isloadinggetallteacher = false;
      notifyListeners();
    }
  }

  Future<bool> add_teacher(
      {String? name, String? phone, String? password}) async {
    String? token = await servicesProvider.gettoken();
    isloadingaddteacher = true;
    notifyListeners();
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseURL${AppApi.CreateTeacher}'));
      request.fields.addAll({
        'name': name!,
        'phone': phone!,
        'password': password!,
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        isloadingaddteacher = false;
        notifyListeners();
        print(await response.stream.bytesToString());
        return true;
      } else {
        print(response.reasonPhrase);
        isloadingaddteacher = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      isloadingaddteacher = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> update_teacher({String? name, String? phone, int? id}) async {
    String? token = await servicesProvider.gettoken();
    isloadingupdateprofilestudentfromadmin = true;
    notifyListeners();
    print(name);
    print(phone);
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseURL${AppApi.UpdateUserData(id!)}'));
      request.fields.addAll({
        'name': name!,
        'phone': phone!,
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print(response.statusCode);
      if (response.statusCode == 200) {
        isloadingupdateprofilestudentfromadmin = false;
        notifyListeners();
        print(await response.stream.bytesToString());
        return true;
      } else {
        print(response.reasonPhrase);
        isloadingupdateprofilestudentfromadmin = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print(e);
      isloadingupdateprofilestudentfromadmin = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> delete_teacher({int? userid}) async {
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
}
