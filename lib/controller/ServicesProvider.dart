import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker_ios/image_picker_ios.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ServicesProvider with ChangeNotifier {
  SharedPreferences? sharedPreferences;
  ImagePickerIOS picker = ImagePickerIOS();
  XFile? image;
  Future<String> gettoken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences!.getString('token') ?? "";
  }

  Future<String> getrole() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences!.getString('role') ?? "";
  }

  Future<void> setlocale(String? locale) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences!.setString('lang', locale ?? "ar");
  }

  Future<String> getlocale() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences!.getString('lang') ?? "ar";
  }

  Future<SharedPreferences> sharedprefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences!;
  }

  Future<File> getgallery() async {
    image = await picker.getImage(source: ImageSource.gallery);
    notifyListeners();

    return File(image!.path);
  }

  Future<File> getcamera() async {
    image = await picker.getImage(source: ImageSource.camera);
    notifyListeners();
    return File(image!.path);
  }
}
