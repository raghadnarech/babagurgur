import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:baba_karkar/constant/colors.dart';
import 'package:baba_karkar/constant/fonts.dart';
import 'package:baba_karkar/controller/ClassroomProvider.dart';
import 'package:baba_karkar/controller/HomeworkProvider.dart';
import 'package:baba_karkar/controller/LanguageProvider.dart';
import 'package:baba_karkar/controller/ServicesProvider.dart';
import 'package:baba_karkar/main.dart';
import 'package:baba_karkar/view/Admin/Classroom/classroomPage.dart';
import 'package:baba_karkar/view/Admin/Student/StudentHome.dart';
import 'package:baba_karkar/view/Admin/Teacher/TeacherHome.dart';
import 'package:baba_karkar/view/Auth/Login.dart';
import 'package:baba_karkar/view/Language/languagePage.dart';
import 'package:baba_karkar/view/Student/Profile/ProfileStudent.dart';
import 'package:baba_karkar/view/Teacher/Classroom/classroomPage.dart';
import 'package:baba_karkar/view/Teacher/HomeWork/AllHM.dart';
import 'package:baba_karkar/view/Teacher/HomeWork/PageSendHM.dart';
import 'package:baba_karkar/view/Teacher/HomeWork/SendHM.dart';
import 'package:baba_karkar/view/Teacher/Notifications/SendNotifications.dart';
import 'package:baba_karkar/view/Teacher/Schedule/ScheduleExam.dart';
import 'package:baba_karkar/view/Teacher/Schedule/ScheduleWeek.dart';
import 'package:baba_karkar/view/Teacher/Student/StudentHomeTeacher.dart';
import 'package:baba_karkar/widgets/ListSkelatonList.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../Student/Schedule/ScheduleExam.dart';

class HomePageTeacher extends StatefulWidget {
  const HomePageTeacher({super.key});

  @override
  State<HomePageTeacher> createState() => _HomePageTeacherState();
}

class _HomePageTeacherState extends State<HomePageTeacher> {
  final textnotifications = TextEditingController();
  File? image;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      classroomProvider.get_all_class();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    classroomProvider = Provider.of<ClassroomProvider>(context);
    languageprovider = Provider.of<LanguageProvider>(context);
    homeworkProvider = Provider.of<HomeworkProvider>(context);
    servicesProvider = Provider.of<ServicesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.hw),
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
                          child: ProfileStudent(),
                          type: PageTransitionType.fade),
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
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Colors.grey.withOpacity(0.5), BlendMode.dstATop),
              child: Image.asset(
                "images/Splash.png",
                height: height,
                fit: BoxFit.cover,
                width: width,
              ),
            ),
          ),
          ListView(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AutoSizeText(
                  " ${AppLocalizations.of(context)!.classroom} :",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              classroomProvider.isloadinggetallroom ||
                      classroomProvider.isloadinggetallroom
                  ? ListSkelatonList(
                      height: height,
                      width: width,
                    )
                  : ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: classroomProvider.listroom.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () async {
                          // newsProvider.allnewsfromroom(
                          //     classroomProvider.listroom[index].id);
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: AllHM(
                                      id: classroomProvider.listroom[index].id),
                                  type: PageTransitionType.fade));
                        },
                        child: Slidable(
                          endActionPane:
                              ActionPane(motion: BehindMotion(), children: [
                            SlidableAction(
                              icon: Icons.send,
                              foregroundColor: kBaseColor,
                              backgroundColor: kPrimarycolor,
                              onPressed: (context) {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: PageSendHM(
                                            id: classroomProvider
                                                .listroom[index].id),
                                        type: PageTransitionType.fade));
                              },
                            )
                          ]),
                          child: SizedBox(
                            child: Card(
                              elevation: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              "${classroomProvider.listroom[index].name}")
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              "${classroomProvider.listclassroom.where((element) => element.id == classroomProvider.listroom[index].classid).first.name}")
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
            ],
          ),
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
            style: TextStyle(color: kBaseSecondryColor, fontSize: 16),
          )
        ],
      ),
    ),
  );
}
