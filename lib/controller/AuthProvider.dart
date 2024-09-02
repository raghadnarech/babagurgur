import 'dart:convert';

import 'package:baba_karkar/constant/API-Url.dart';
import 'package:baba_karkar/main.dart';
import 'package:baba_karkar/model/Profile.dart';
import 'package:baba_karkar/model/User.dart';
import 'package:baba_karkar/view/Admin/Home/HomePageAdmin.dart';
import 'package:baba_karkar/view/Student/Home/HomePageStudent.dart';
import 'package:baba_karkar/view/Student/PleaseActiveAccount/PleaseActiveAccount.dart';
import 'package:baba_karkar/view/Student/SelectRoom/SelectRoomPage.dart';
import 'package:baba_karkar/view/Teacher/Home/HomePageTeacher.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  User user = User();
  Profile profile = Profile();
  Profile profilestudent = Profile();
  bool isloadinglogin = false;
  bool isloadingsignup = false;
  bool isloadingupdateprofile = false;
  bool isloadingupdateprofileadmin = false;
  bool isloadinggetprofileadmin = false;
  bool isloadinggetprofileuser = false;
  bool isloadingupdateprofilestudentfromadmin = false;
  bool isloadingchangepassword = false;

  Future<bool> login({
    String? phone,
    String? password,
    BuildContext? context,
  }) async {
    isloadinglogin = true;
    notifyListeners();
    print(phone);
    print(password);
    http.Response response;
    try {
      response = await http.post(
        Uri.parse('$baseURL${AppApi.LOGIN}'),
        headers: {'Accept': 'application/json'},
        body: {
          'phone': phone,
          'password': password,
        },
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        user = User.fromJson(data);
        saveUser(user);

        isloadinglogin = false;
        notifyListeners();
        user.role == 'admin'
            ? Navigator.pushAndRemoveUntil(
                context!,
                PageTransition(
                    child: HomePageAdmin(), type: PageTransitionType.fade),
                (route) => false)
            : user.role == 'student'
                ? {
                    get_profile_user(context!),
                  }
                : Navigator.pushAndRemoveUntil(
                    context!,
                    PageTransition(
                        child: HomePageTeacher(),
                        type: PageTransitionType.fade),
                    (route) => false);

        return true;
      } else {
        isloadinglogin = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print(e);
      isloadinglogin = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> Signup({
    String? phone,
    String? password,
    String? name,
  }) async {
    // String? token = await servicesProvider.gettoken();
    isloadingsignup = true;
    notifyListeners();
    try {
      var headers = {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token'
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
        isloadingsignup = false;
        notifyListeners();
        print(await response.stream.bytesToString());
        return true;
      } else {
        print(response.reasonPhrase);
        isloadingsignup = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      isloadingsignup = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> update_profile({String? name, String? phone}) async {
    String? token = await servicesProvider.gettoken();
    isloadingupdateprofile = true;
    notifyListeners();
    print(name);
    print(phone);
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseURL${AppApi.UpdateProfileforall}'));
      request.fields.addAll({
        'name': name!,
        'phone': phone!,
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print(response.statusCode);
      if (response.statusCode == 200) {
        isloadingupdateprofile = false;
        notifyListeners();
        print(await response.stream.bytesToString());
        return true;
      } else {
        print(response.reasonPhrase);
        isloadingupdateprofile = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print(e);
      isloadingupdateprofile = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> update_profile_admin({String? name, String? phone}) async {
    String? token = await servicesProvider.gettoken();
    isloadingupdateprofileadmin = true;
    notifyListeners();
    print(name);
    print(phone);
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseURL${AppApi.UpdateProfileAdmin}'));
      request.fields.addAll({
        'name': name!,
        'phone': phone!,
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print(response.statusCode);
      if (response.statusCode == 200) {
        isloadingupdateprofileadmin = false;
        notifyListeners();
        print(await response.stream.bytesToString());
        return true;
      } else {
        print(response.reasonPhrase);
        isloadingupdateprofileadmin = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print(e);
      isloadingupdateprofileadmin = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> update_user_from_admin(
      {String? name, String? phone, int? id}) async {
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

//تغيير كلمة السر للجميع
  Future<bool> changepassword({String? password}) async {
    String? token = await servicesProvider.gettoken();
    isloadingchangepassword = true;
    notifyListeners();

    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseURL${AppApi.ChangePassword}'));
      request.fields.addAll({
        'password': password!,
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print(response.statusCode);
      if (response.statusCode == 200) {
        isloadingchangepassword = false;
        notifyListeners();

        print(await response.stream.bytesToString());
        return true;
      } else {
        print(response.reasonPhrase);
        isloadingchangepassword = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print(e);
      isloadingchangepassword = false;
      notifyListeners();
      return false;
    }
  }

//جلب بروفايل الادمن
  Future<void> get_profile_admin() async {
    String? token = await servicesProvider.gettoken();
    isloadinggetprofileadmin = true;
    notifyListeners();

    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.MultipartRequest(
          'GET', Uri.parse('$baseURL${AppApi.ProfileAdmin}'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print(response.statusCode);
      if (response.statusCode == 200) {
        dynamic data = json.decode(await response.stream.bytesToString());
        profile = Profile.fromJson(data);
        notifyListeners();
        isloadinggetprofileadmin = false;
        notifyListeners();

        print(await response.stream.bytesToString());
        // return true;
      } else {
        print(response.reasonPhrase);
        isloadinggetprofileadmin = false;
        notifyListeners();
        // return false;
      }
    } catch (e) {
      print(e);
      isloadinggetprofileadmin = false;
      notifyListeners();
      // return false;
    }
  }

  Future<void> get_profile_user(BuildContext context) async {
    String? token = await servicesProvider.gettoken();
    isloadinggetprofileuser = true;
    notifyListeners();

    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.MultipartRequest(
          'GET', Uri.parse('$baseURL${AppApi.MyProfileStudent}'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      // print(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        dynamic data = json.decode(await response.stream.bytesToString());
        print(data);
        if (data['room'] == null && data['role'] == 'student') {
          Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: SelectRoomPage(), type: PageTransitionType.fade),
            (route) => false,
          );
        } else {
          if (data['room']['isStudentActive'] == 0 &&
              data['role'] == 'student') {
            Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                  child: PleaseActiveAccount(), type: PageTransitionType.fade),
              (route) => false,
            );
          } else {
            print(data);
            profile = Profile.fromJson(data);
            servicesProvider.sharedPreferences!
                .setInt('roomid_student', data['room']['room_id']);
            Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                  child: HomePageStudent(), type: PageTransitionType.fade),
              (route) => false,
            );
          }
        }

        notifyListeners();
        isloadinggetprofileuser = false;
        notifyListeners();

        // return true;
      } else {
        print(response.reasonPhrase);
        isloadinggetprofileuser = false;
        notifyListeners();
        // return false;
      }
    } catch (e) {
      print(e);
      isloadinggetprofileuser = false;
      notifyListeners();
      // return false;
    }
  }

  Future<void> get_profile_student(BuildContext context) async {
    String? token = await servicesProvider.gettoken();
    isloadinggetprofileuser = true;
    notifyListeners();

    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.MultipartRequest(
          'GET', Uri.parse('$baseURL${AppApi.MyProfileStudent}'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      // print(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        dynamic data = json.decode(await response.stream.bytesToString());
        print(data);

        print(data);
        profile = Profile.fromJson(data);
        servicesProvider.sharedPreferences!
            .setInt('roomid_student', data['room']['room_id']);

        notifyListeners();
        isloadinggetprofileuser = false;
        notifyListeners();

        // return true;
      } else {
        print(response.reasonPhrase);
        isloadinggetprofileuser = false;
        notifyListeners();
        // return false;
      }
    } catch (e) {
      print(e);
      isloadinggetprofileuser = false;
      notifyListeners();
      // return false;
    }
  }

  Future<void> get_profile_user_from_admin(int? id) async {
    String? token = await servicesProvider.gettoken();
    isloadinggetprofileadmin = true;
    notifyListeners();
    print(id);

    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.MultipartRequest(
          'GET', Uri.parse('$baseURL${AppApi.ProfileUserFromAdmin(id!)}}'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print(response.statusCode);

      if (response.statusCode == 200) {
        dynamic data = json.decode(await response.stream.bytesToString());
        profilestudent = Profile.fromJson(data);
        notifyListeners();
        isloadinggetprofileadmin = false;
        notifyListeners();

        print(await response.stream.bytesToString());
        // return true;
      } else {
        print(response.reasonPhrase);
        isloadinggetprofileadmin = false;
        notifyListeners();
        // return false;
      }
    } catch (e) {
      print(e);
      isloadinggetprofileadmin = false;
      notifyListeners();
      // return false;
    }
  }

  Future<void> logout() async {
    removeuser();
  }

  saveUser(User usershared) async {
    SharedPreferences? preferences = await SharedPreferences.getInstance();
    await preferences.setString('token', usershared.token!);
    await preferences.setString('role', usershared.role!);
    await preferences.setString('name', usershared.name!);
    await preferences.setBool("isLogged", true);
  }

  removeuser() async {
    SharedPreferences? preferences = await SharedPreferences.getInstance();
    await preferences.remove('token');
    await preferences.remove('role');
    await preferences.remove("isLogged");
    await preferences.remove("roomid_student");
    user = User();
    debugPrint("Logout Successfuly");
  }
}
