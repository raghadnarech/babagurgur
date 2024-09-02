import 'dart:async';
import 'package:baba_karkar/controller/AuthProvider.dart';
import 'package:baba_karkar/controller/ServicesProvider.dart';
import 'package:baba_karkar/main.dart';
import 'package:baba_karkar/view/Admin/Home/HomePageAdmin.dart';
import 'package:baba_karkar/view/Auth/Login.dart';
import 'package:baba_karkar/view/Student/Home/HomePageStudent.dart';
import 'package:baba_karkar/view/Teacher/Home/HomePageTeacher.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  bool? isLogged;

  Splash({this.isLogged});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  AnimationController? scaleController;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 5)).then((value) async {
      String? role = await servicesProvider.getrole();

      if (widget.isLogged!) {
        role == 'admin'
            ? Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                    child: HomePageAdmin(), type: PageTransitionType.fade),
                (route) => false)
            : role == 'student'
                ? {
                    await authprovider.get_profile_user(context),
                    // Navigator.pushAndRemoveUntil(
                    //     context,
                    //     PageTransition(
                    //         child: HomePageStudent(),
                    //         type: PageTransitionType.fade),
                    //     (route) => false)
                  }
                : Navigator.pushAndRemoveUntil(
                    context,
                    PageTransition(
                        child: HomePageTeacher(),
                        type: PageTransitionType.fade),
                    (route) => false);
      } else {
        Navigator.pushReplacement(
          context,
          PageTransition(
            child: Login(),
            type: PageTransitionType.fade,
          ),
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    servicesProvider = Provider.of<ServicesProvider>(context);
    authprovider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: height,
            width: width,
            child: Image.asset('images/Splash.png', fit: BoxFit.cover),
          ),
          SafeArea(
            child: Align(
              alignment: AlignmentDirectional.center,
              child: SizedBox(
                width: width * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('images/Logo.png'),
                    LoadingAnimationWidget.waveDots(
                        color: Color(0xff89b0af), size: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
