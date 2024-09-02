import 'dart:convert';

import 'package:baba_karkar/constant/API-Url.dart';
import 'package:baba_karkar/controller/ServicesProvider.dart';
import 'package:baba_karkar/main.dart';
import 'package:baba_karkar/model/Class.dart';
import 'package:baba_karkar/model/Room.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ClassroomProvider with ChangeNotifier {
  bool isloadinggetallclass = false;
  bool isloadinggetallroom = false;
  bool isloadingaddroom = false;
  bool isloadingaddclass = false;
  bool isloadingupdateclass = false;
  bool isloadingdeleteclass = false;
  bool isloadingupdateroom = false;
  bool isloadingSendMessageToRoom = false;
  bool isloadingdeleteroom = false;

  Classroom classroom = Classroom();
  Room room = Room();
  List<Room> listroom = [];
  List<Classroom> listclassroom = [];

  Future<void> get_all_class() async {
    isloadinggetallclass = true;
    notifyListeners();
    get_all_room();

    listclassroom = [];
    notifyListeners();
    String? token = await servicesProvider.gettoken();
    // print(await servicesProvider.gettoken());
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request =
          http.Request('GET', Uri.parse('$baseURL${AppApi.Allclass}'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        dynamic data = json.decode(await response.stream.bytesToString());
        for (var element in data) {
          classroom = Classroom.fromJson(element);
          listclassroom.add(classroom);
          notifyListeners();
        }
        // print(await response.stream.bytesToString());
        print(data);
        print(listclassroom.length);
        isloadinggetallclass = false;
        notifyListeners();
      } else {
        print(response.reasonPhrase);
        isloadinggetallclass = false;
        notifyListeners();
      }
    } catch (e) {
      isloadinggetallclass = false;
      notifyListeners();
    }
  }

  Future<void> get_all_room() async {
    isloadinggetallroom = true;
    notifyListeners();
    listroom = [];
    notifyListeners();
    String? token = await servicesProvider.gettoken();
    // print(await servicesProvider.gettoken());
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.Request('GET', Uri.parse('$baseURL${AppApi.Allroom}'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        dynamic data = json.decode(await response.stream.bytesToString());
        for (var element in data) {
          room = Room.fromJson(element);
          listroom.add(room);
          notifyListeners();
        }
        // print(await response.stream.bytesToString());
        print(data);
        print(listroom.length);
        isloadinggetallroom = false;
        notifyListeners();
      } else {
        print(response.reasonPhrase);
        isloadinggetallroom = false;
        notifyListeners();
      }
    } catch (e) {
      isloadinggetallroom = false;
      notifyListeners();
    }
  }

  Future<bool> add_class(String? name) async {
    String? token = await servicesProvider.gettoken();
    isloadingaddclass = true;
    notifyListeners();
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseURL${AppApi.CreateClass}'));
      request.fields.addAll({
        'name': name!,
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        isloadingaddclass = false;
        notifyListeners();
        return true;
      } else {
        print(response.reasonPhrase);
        isloadingaddclass = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      isloadingaddclass = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> add_room(String? name, int? id) async {
    String? token = await servicesProvider.gettoken();
    isloadingaddroom = true;
    notifyListeners();
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseURL${AppApi.CreateRoom}'));
      request.fields.addAll({'name': name!, 'class_id': id.toString()});

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        isloadingaddroom = false;
        notifyListeners();
        return true;
      } else {
        print(response.reasonPhrase);
        isloadingaddroom = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      isloadingaddroom = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> update_room({String? name, int? classid, int? roomid}) async {
    String? token = await servicesProvider.gettoken();
    isloadingupdateroom = true;
    notifyListeners();
    print(token);
    print(classid);
    print(roomid);
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseURL${AppApi.UpdateRoom(roomid!)}'));
      request.fields.addAll({
        'name': name!,
        'class_id': classid.toString(),
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print(response.stream.bytesToString());

      if (response.statusCode == 200) {
        isloadingupdateroom = false;
        notifyListeners();

        return true;
      } else {
        print(response.reasonPhrase);
        isloadingupdateroom = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print(e);
      isloadingupdateroom = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> SendMessageToRoom({String? text, int? roomid}) async {
    String? token = await servicesProvider.gettoken();
    isloadingSendMessageToRoom = true;
    notifyListeners();
    print(token);
    print(roomid);
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseURL${AppApi.SendMessageToRoom(roomid!)}'));
      request.fields.addAll({
        'text': text!,
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print(response.stream.bytesToString());

      if (response.statusCode == 200) {
        isloadingSendMessageToRoom = false;
        notifyListeners();

        return true;
      } else {
        print(response.reasonPhrase);
        isloadingSendMessageToRoom = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print(e);
      isloadingSendMessageToRoom = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteroom({int? roomid}) async {
    String? token = await servicesProvider.gettoken();
    isloadingdeleteroom = true;
    notifyListeners();
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.MultipartRequest(
          'GET', Uri.parse('$baseURL${AppApi.DeleteRoom(roomid!)}'));
      // request.fields.addAll({'name': name!, 'class_id': id.toString()});

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        isloadingdeleteroom = false;
        notifyListeners();
        return true;
      } else {
        print(response.reasonPhrase);
        isloadingdeleteroom = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print(e);
      isloadingdeleteroom = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> update_class({String? name, int? classid}) async {
    String? token = await servicesProvider.gettoken();
    isloadingupdateclass = true;
    notifyListeners();
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseURL${AppApi.UpdateClass(classid!)}'));
      request.fields.addAll({
        'name': name!,
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        isloadingupdateclass = false;
        notifyListeners();
        return true;
      } else {
        print(response.reasonPhrase);
        isloadingupdateclass = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      isloadingupdateclass = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> delete_class({int? classid}) async {
    String? token = await servicesProvider.gettoken();
    isloadingdeleteclass = true;
    notifyListeners();
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.MultipartRequest(
          'GET', Uri.parse('$baseURL${AppApi.DeleteClass(classid!)}'));
      // request.fields.addAll({'name': name!, 'class_id': id.toString()});

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        isloadingdeleteclass = false;
        notifyListeners();
        return true;
      } else {
        print(response.reasonPhrase);
        isloadingdeleteclass = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      isloadingdeleteclass = false;
      notifyListeners();
      return false;
    }
  }
}
