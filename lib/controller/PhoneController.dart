import 'dart:convert';

import 'package:baba_karkar/constant/API-Url.dart';
import 'package:baba_karkar/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PhoneController with ChangeNotifier {
  String phone1 = "";
  String phone2 = "";
  bool isloadingaddphone = false;
  bool isloadingupdatephone = false;
  bool isloadinggetphone = false;

  Future<bool> createnumbers({String? phone1, String? phone2}) async {
    String? token = await servicesProvider.gettoken();
    isloadingaddphone = true;
    notifyListeners();
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseURL${AppApi.CreateNumbers}'));
      request.fields.addAll({
        'phone1': phone1!,
        'phone2': phone2!,
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        isloadingaddphone = false;
        notifyListeners();
        print(await response.stream.bytesToString());
        return true;
      } else {
        print(response.reasonPhrase);
        isloadingaddphone = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      isloadingaddphone = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updatenumbers({String? phone1, String? phone2}) async {
    String? token = await servicesProvider.gettoken();
    isloadingupdatephone = true;
    notifyListeners();
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseURL${AppApi.UpdateNumbers}'));
      if (phone2 == null) {
        request.fields.addAll({
          'phone1': phone1!,
        });
      } else if (phone1 == null) {
        request.fields.addAll({
          'phone2': phone2,
        });
      } else {
        request.fields.addAll({
          'phone1': phone1,
          'phone2': phone2,
        });
      }

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        isloadingupdatephone = false;
        notifyListeners();
        print(await response.stream.bytesToString());
        return true;
      } else {
        print(response.reasonPhrase);
        isloadingupdatephone = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      isloadingupdatephone = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> getphones() async {
    String? token = await servicesProvider.gettoken();
    isloadinggetphone = true;
    notifyListeners();
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request =
          http.Request('GET', Uri.parse('$baseURL${AppApi.ShowNumbers}'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        dynamic data = json.decode(await response.stream.bytesToString());
        print(data[0]);
        phone1 = data[0]['phone1'];
        notifyListeners();

        phone2 = data[0]['phone2'];
        notifyListeners();

        isloadinggetphone = false;
        notifyListeners();
        print(await response.stream.bytesToString());
      } else {
        isloadinggetphone = false;
        notifyListeners();
        print(response.reasonPhrase);
      }
    } catch (e) {
      isloadinggetphone = false;
      notifyListeners();
    }
  }
}
