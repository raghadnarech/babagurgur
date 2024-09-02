import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:baba_karkar/constant/colors.dart';
import 'package:baba_karkar/controller/ClassroomProvider.dart';
import 'package:baba_karkar/controller/StrudentProvider.dart';
import 'package:baba_karkar/main.dart';
import 'package:baba_karkar/view/Admin/Home/HomePageAdmin.dart';
import 'package:baba_karkar/view/Admin/Student/ProfileStudentFromAdmin.dart';
import 'package:baba_karkar/widgets/GridSkelaton.dart';
import 'package:baba_karkar/widgets/textinputall.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({super.key});

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  final namecontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      studentProvider.get_all_student();
      classroomProvider.get_all_class();
      // await classroomProvider.get_all_room();
    });
    super.initState();
  }

  int? idroom;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    studentProvider = Provider.of<StudentProvider>(context);
    classroomProvider = Provider.of<ClassroomProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.student),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                title: Text(AppLocalizations.of(context)!.addnewstudent),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextInpuAll(
                        label: AppLocalizations.of(context)!.studentname,
                        isPassword: false,
                        controller: namecontroller,
                      ),
                      TextInpuAll(
                        label: AppLocalizations.of(context)!.studentphone,
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
                        if (await studentProvider.add_student(
                            name: namecontroller.text,
                            password: passwordcontroller.text,
                            phone: phonecontroller.text)) {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.scale,
                            title:
                                AppLocalizations.of(context)!.messageaddstudent,
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
                      child: studentProvider.isloadingaddstudent
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
        studentProvider.isloadinggetallstudent ||
                classroomProvider.isloadinggetallclass ||
                classroomProvider.isloadinggetallroom
            ? GridSkelaton(
                height: height,
                width: width,
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.8, crossAxisCount: 2),
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: studentProvider.liststudent.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: ProfileStudentfromAdmin(
                                  id: studentProvider.liststudent[index].id),
                              type: PageTransitionType.fade));
                    },
                    child: SizedBox(
                      // height: height * 0.5,
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                      "${studentProvider.liststudent[index].name}",
                                      maxLines: 1,
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
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
                                      "${studentProvider.liststudent[index].phone}",
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.transparent,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => StatefulBuilder(
                                          builder: (context, setState) =>
                                              AlertDialog(
                                            title: Text(
                                                AppLocalizations.of(context)!
                                                    .addstudenttoroom),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                DropdownButtonFormField(
                                                  focusColor: kPrimarycolor,
                                                  hint: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .selectroom),
                                                  decoration: InputDecoration(
                                                    hoverColor: kPrimarycolor,
                                                    // Customize the underline color for the selected item
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: kPrimarycolor),
                                                    ),
                                                  ),
                                                  items: classroomProvider
                                                      .listroom
                                                      .map((room) {
                                                    return DropdownMenuItem(
                                                      value: room,
                                                      child: Text(
                                                          "${room.name}-${classroomProvider.listclassroom.where((element) => element.id == room.classid).first.name}"),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    setState(
                                                      () {
                                                        idroom = value!.id;
                                                        // print(idclass);
                                                      },
                                                    );
                                                  },
                                                )
                                              ],
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    setState(
                                                      () {},
                                                    );
                                                    if (await studentProvider
                                                        .select_classroom_user(
                                                            studentProvider
                                                                .liststudent[
                                                                    index]
                                                                .id
                                                                .toString(),
                                                            idroom
                                                                .toString())) {
                                                      AwesomeDialog(
                                                        context: context,
                                                        dialogType:
                                                            DialogType.success,
                                                        animType:
                                                            AnimType.scale,
                                                        title: AppLocalizations
                                                                .of(context)!
                                                            .messageaddstudenttoroom,
                                                        // desc: "سيتم مراجعة طلبك في أقرب وقت",
                                                        btnOkOnPress: () {
                                                          Navigator.pushAndRemoveUntil(
                                                              context,
                                                              PageTransition(
                                                                  child:
                                                                      HomePageAdmin(),
                                                                  type:
                                                                      PageTransitionType
                                                                          .fade),
                                                              ((route) =>
                                                                  false));
                                                        },
                                                        btnOkText:
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .ok,
                                                      ).show();
                                                    } else {
                                                      setState(
                                                        () {},
                                                      );
                                                      AwesomeDialog(
                                                        context: context,
                                                        dialogType:
                                                            DialogType.error,
                                                        animType:
                                                            AnimType.scale,
                                                        title: AppLocalizations
                                                                .of(context)!
                                                            .titleerrordialog,
                                                        desc: AppLocalizations
                                                                .of(context)!
                                                            .messageerrordialog,
                                                        btnOkOnPress: () {
                                                          Navigator.pushAndRemoveUntil(
                                                              context,
                                                              PageTransition(
                                                                  child:
                                                                      HomePageAdmin(),
                                                                  type:
                                                                      PageTransitionType
                                                                          .fade),
                                                              ((route) =>
                                                                  false));
                                                        },
                                                        btnOkText:
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .ok,
                                                      ).show();
                                                    }
                                                  },
                                                  child: studentProvider
                                                          .isloadingselectclassroomstudent
                                                      ? Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .adding)
                                                      : Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .add)),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  style: ButtonStyle(
                                                      overlayColor: MaterialStateColor
                                                          .resolveWith((states) =>
                                                              kPrimarycolor
                                                                  .withAlpha(
                                                                      100))),
                                                  child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .close,
                                                    style: TextStyle(
                                                        color:
                                                            kBaseSecondryColor),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(AppLocalizations.of(context)!
                                        .addtoroom)),
                              )
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
