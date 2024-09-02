import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:baba_karkar/constant/colors.dart';
import 'package:baba_karkar/controller/ClassroomProvider.dart';
import 'package:baba_karkar/controller/HomeworkProvider.dart';
import 'package:baba_karkar/controller/LanguageProvider.dart';
import 'package:baba_karkar/controller/NewsProvider.dart';
import 'package:baba_karkar/controller/ServicesProvider.dart';
import 'package:baba_karkar/controller/StrudentProvider.dart';
import 'package:baba_karkar/main.dart';

import 'package:baba_karkar/view/Admin/Home/HomePageAdmin.dart';
import 'package:baba_karkar/view/Teacher/Classroom/allstudentfromroom.dart';
import 'package:baba_karkar/view/Teacher/HomeWork/AllHM.dart';
import 'package:baba_karkar/view/Teacher/HomeWork/PageSendHM.dart';
import 'package:baba_karkar/view/Teacher/Notifications/AllNotificarions.dart';

import 'package:baba_karkar/widgets/ListSkelatonList.dart';
import 'package:baba_karkar/widgets/textinputall.dart';

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ClassRoomPageTeacher extends StatefulWidget {
  const ClassRoomPageTeacher({super.key});

  @override
  State<ClassRoomPageTeacher> createState() => _ClassRoomPageTeacherState();
}

class _ClassRoomPageTeacherState extends State<ClassRoomPageTeacher> {
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
    studentProvider = Provider.of<StudentProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.classroom),
        centerTitle: true,
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
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              children: [
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
                            studentProvider.get_all_student_from_room(
                                classroomProvider.listroom[index].id);
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: AllStudentFromRoom(),
                                    type: PageTransitionType.fade));
                          },
                          child: SizedBox(
                            child: Card(
                              elevation: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      )
              ]),
        ],
      ),
    );
  }
}
