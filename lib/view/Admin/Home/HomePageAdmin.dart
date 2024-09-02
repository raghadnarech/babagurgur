import 'package:auto_size_text/auto_size_text.dart';
import 'package:baba_karkar/constant/colors.dart';
import 'package:baba_karkar/constant/fonts.dart';
import 'package:baba_karkar/main.dart';
import 'package:baba_karkar/view/Admin/Classroom/classroomPage.dart';
import 'package:baba_karkar/view/Admin/Phone/PhonePage.dart';
import 'package:baba_karkar/view/Admin/Profile/ProfileAdmin.dart';
import 'package:baba_karkar/view/Admin/Student/StudentHome.dart';
import 'package:baba_karkar/view/Admin/Teacher/TeacherHome.dart';
import 'package:baba_karkar/view/Auth/Login.dart';
import 'package:baba_karkar/view/Language/languagePage.dart';
import 'package:baba_karkar/view/Teacher/Classroom/classroomPage.dart';
import 'package:baba_karkar/view/Teacher/HomeWork/SendHM.dart';
import 'package:baba_karkar/view/Teacher/Notifications/SendNotifications.dart';
import 'package:baba_karkar/view/Teacher/Schedule/ScheduleExam.dart';
import 'package:baba_karkar/view/Teacher/Schedule/ScheduleWeek.dart';
import 'package:baba_karkar/view/Teacher/Student/StudentHomeTeacher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePageAdmin extends StatelessWidget {
  const HomePageAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.homepage),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Divider(
                  color: Colors.transparent,
                ),
                SizedBox(
                  width: width * 0.3,
                  child: Image.asset("images/Logo.png"),
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context)!.homepage),
                  leading: Icon(Icons.home),
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context)!.profile),
                  leading: Icon(Icons.person),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          child: ProfileAdmin(), type: PageTransitionType.fade),
                    );
                  },
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context)!.settings),
                  leading: Icon(Icons.settings),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          child: LanguagePage(), type: PageTransitionType.fade),
                    );
                  },
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context)!.logout),
                  leading: Icon(Icons.logout),
                  onTap: () async {
                    authprovider.logout();
                    Navigator.pushAndRemoveUntil(
                        context,
                        PageTransition(
                            child: Login(), type: PageTransitionType.fade),
                        (route) => false);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          CarouselSlider(
              items: [
                Image.asset("images/Sliders/slide1.jpg"),
                Image.asset("images/Sliders/slide2.jpg"),
                Image.asset("images/Sliders/slide3.jpg"),
              ],
              options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.scale)),
          GridView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisExtent: height * .2),
              children: [
                CustomCardHomePage(
                  context,
                  ontap: ClassRoomPage(),
                  icon: "images/Icon/classroom.png",
                  title: AppLocalizations.of(context)!.classroom,
                ),
                // CustomCardHomePage(
                //   context,
                //   icon: "images/Icon/sendalert.png",
                //   title: AppLocalizations.of(context)!.notifications,
                // ),
                // CustomCardHomePage(
                //   context,
                //   icon: "images/Icon/calenders.png",
                //   title: AppLocalizations.of(context)!.weeklyprogram,
                // ),
                // CustomCardHomePage(
                //   context,
                //   icon: "images/Icon/father.png",
                //   title: AppLocalizations.of(context)!.parents,
                // ),
                CustomCardHomePage(
                  context,
                  ontap: TeacherHome(),
                  icon: "images/Icon/school.png",
                  title: AppLocalizations.of(context)!.teachers,
                ),
                // CustomCardHomePage(
                //   context,
                //   icon: "images/Icon/exam.png",
                //   title: AppLocalizations.of(context)!.examprogram,
                // ),
                CustomCardHomePage(
                  context,
                  ontap: StudentHome(),
                  icon: "images/Icon/student-male.png",
                  title: AppLocalizations.of(context)!.student,
                ),

                CustomCardHomePage(
                  context,
                  ontap: PhonePage(),
                  icon: "images/Icon/phone_numbers.png",
                  title: AppLocalizations.of(context)!.phonepage,
                ),
                CustomCardHomePage(
                  ontap: SendNotifications(),
                  context,
                  icon: "images/Icon/news.png",
                  title: AppLocalizations.of(context)!.notifications,
                ),
                CustomCardHomePage(
                  context,
                  ontap: ClassRoomPageTeacher(),
                  icon: "images/Icon/father.png",
                  title: AppLocalizations.of(context)!.parents,
                ),

                CustomCardHomePage(
                  ontap: SendHM(),
                  context,
                  icon: "images/Icon/report-card.png",
                  title: AppLocalizations.of(context)!.hw,
                ),
                CustomCardHomePage(
                  ontap: ScheduleExamTeacher(),
                  context,
                  icon: "images/Icon/exam.png",
                  title: AppLocalizations.of(context)!.examprogram,
                ),
                CustomCardHomePage(
                  ontap: ScheduleWeekTeacher(),
                  context,
                  icon: "images/Icon/calenders.png",
                  title: AppLocalizations.of(context)!.weeklyprogram,
                ),
                CustomCardHomePage(
                  context,
                  ontap: StudentHomeTeacher(),
                  icon: "images/Icon/approval.png",
                  title: AppLocalizations.of(context)!.joinStudentToGroup,
                ),
              ]),
        ],
      ),
    );
  }
}

CustomCardHomePage(BuildContext context,
    {String? icon, String? title, Widget? ontap}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        PageTransition(child: ontap!, type: PageTransitionType.fade),
      );
    },
    child: Container(
      color: kBaseColor,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Image.asset(
              icon!,
            ),
          ),
          AutoSizeText(
            title!,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kBaseSecondryColor,
              fontSize: 16,
            ),
          )
        ],
      ),
    ),
  );
}
