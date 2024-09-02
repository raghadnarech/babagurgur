import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:baba_karkar/constant/colors.dart';
import 'package:baba_karkar/controller/StrudentProvider.dart';
import 'package:baba_karkar/controller/TeacherProvider.dart';
import 'package:baba_karkar/main.dart';
import 'package:baba_karkar/view/Admin/Home/HomePageAdmin.dart';
import 'package:baba_karkar/view/Admin/Teacher/ProfileTeacherFromAdmin.dart';
import 'package:baba_karkar/widgets/GridSkelaton.dart';
import 'package:baba_karkar/widgets/ListSkelatonList.dart';
import 'package:baba_karkar/widgets/textinputall.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';

class TeacherHome extends StatefulWidget {
  const TeacherHome({super.key});

  @override
  State<TeacherHome> createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  final namecontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      await teacherProvider.get_all_teacher();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    teacherProvider = Provider.of<TeacherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.teachers),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                title: Text(AppLocalizations.of(context)!.addnewteacher),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextInpuAll(
                        label: AppLocalizations.of(context)!.teachername,
                        isPassword: false,
                        controller: namecontroller,
                      ),
                      TextInpuAll(
                        label: AppLocalizations.of(context)!.teacherphone,
                        isPassword: false,
                        controller: phonecontroller,
                      ),
                      TextInpuAll(
                        label: AppLocalizations.of(context)!.password,
                        isPassword: true,
                        controller: passwordcontroller,
                      )
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                      onPressed: () async {
                        setState(
                          () {},
                        );
                        if (await teacherProvider.add_teacher(
                            name: namecontroller.text,
                            password: passwordcontroller.text,
                            phone: phonecontroller.text)) {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.scale,
                            title:
                                AppLocalizations.of(context)!.messageaddteacher,
                            // desc: "سيتم مراجعة طلبك في أقرب وقت",
                            btnOkOnPress: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  PageTransition(
                                      child: HomePageAdmin(),
                                      type: PageTransitionType.fade),
                                  ((route) => false));
                            },
                            btnOkText: AppLocalizations.of(context)!.ok,
                          ).show();
                        } else {
                          setState(
                            () {},
                          );
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.scale,
                            title:
                                AppLocalizations.of(context)!.titleerrordialog,
                            desc: AppLocalizations.of(context)!
                                .messageerrordialog,
                            btnOkOnPress: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  PageTransition(
                                      child: HomePageAdmin(),
                                      type: PageTransitionType.fade),
                                  ((route) => false));
                            },
                            btnOkText: AppLocalizations.of(context)!.ok,
                          ).show();
                        }
                      },
                      child: teacherProvider.isloadingaddteacher
                          ? Text(AppLocalizations.of(context)!.adding)
                          : Text(AppLocalizations.of(context)!.add)),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                          overlayColor: MaterialStateColor.resolveWith(
                              (states) => kPrimarycolor.withAlpha(100))),
                      child: Text(
                        AppLocalizations.of(context)!.close,
                        style: TextStyle(color: kBaseSecondryColor),
                      ))
                ],
              ),
            ),
          );
        },
        backgroundColor: kPrimarycolor,
        child: Icon(
          Icons.add,
        ),
      ),
      body: Stack(children: [
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
        teacherProvider.isloadinggetallteacher
            ? GridSkelaton(
                height: height,
                width: width,
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: teacherProvider.listteacher.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: ProfileTeacherfromAdmin(
                                  id: teacherProvider.listteacher[index].id),
                              type: PageTransitionType.fade));
                    },
                    child: SizedBox(
                      height: height * 0.1,
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.person,
                                size: 40,
                                color: kPrimarycolor,
                              ),
                              Expanded(
                                child: Row(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: AutoSizeText(
                                            AppLocalizations.of(context)!
                                                .name)),
                                    AutoSizeText(
                                      softWrap: true,
                                      "${teacherProvider.listteacher[index].name}",
                                      maxLines: 1,
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: AutoSizeText(
                                            AppLocalizations.of(context)!
                                                .phone)),
                                    AutoSizeText(
                                      softWrap: true,
                                      "${teacherProvider.listteacher[index].phone}",
                                      maxLines: 1,
                                    )
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
      ]),
    );
  }
}
