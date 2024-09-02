import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:baba_karkar/constant/colors.dart';
import 'package:baba_karkar/controller/ClassroomProvider.dart';
import 'package:baba_karkar/controller/LanguageProvider.dart';
import 'package:baba_karkar/main.dart';
import 'package:baba_karkar/model/Room.dart';
import 'package:baba_karkar/view/Admin/Home/HomePageAdmin.dart';
import 'package:baba_karkar/widgets/ListSkelatonClass.dart';
import 'package:baba_karkar/widgets/ListSkelatonList.dart';
import 'package:baba_karkar/widgets/SkelatonCard.dart';
import 'package:baba_karkar/widgets/textinputall.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flexi_chip/flexi_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ClassPage extends StatefulWidget {
  const ClassPage({super.key});

  @override
  State<ClassPage> createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  // List<Room> searchroom = [];
  final classnamecontroller = TextEditingController();
  final roomnamecontroller = TextEditingController();

  // List<C2Choice<int>>? options = [
  //   // C2Choice<int>(
  //   //   value: 1,
  //   //   label: "الصف الأول",
  //   // ),
  //   // C2Choice<int>(
  //   //   value: 2,
  //   //   label: "الصف الثاني",
  //   // ),
  //   // C2Choice<int>(
  //   //   value: 3,
  //   //   label: "الصف الثالث",
  //   // ),
  //   // C2Choice<int>(
  //   //   value: 4,
  //   //   label: "الصف الرابع",
  //   // ),
  // ];
  // List<int> selectedIds = [];
  // void filterRooms() {
  //   searchroom = classroomProvider.listroom
  //       .where((room) => selectedIds.contains(room.classid))
  //       .toList();
  // }

  @override
  void initState() {
    // classroomProvider.get_all_room();

    Future.delayed(Duration.zero).then((value) async {
      await classroomProvider.get_all_class();
      // options = await classroomProvider.listclassroom
      //     .map((classroom) => C2Choice<int>(
      //           value: classroom.id!,
      //           label: classroom.name!,
      //         ))
      //     .toList();
      // filterRooms();
    });
    super.initState();
  }

  int? idclass;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    classroomProvider = Provider.of<ClassroomProvider>(context);
    languageprovider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.classroom),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
                Colors.grey.withOpacity(0.5), BlendMode.dstATop),
            child: Image.asset(
              "images/Splash.png",
              height: height,
              fit: BoxFit.cover,
            ),
          ),
          ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              children: [
                classroomProvider.isloadinggetallclass
                    ? ListSkelatonList(
                        height: height,
                        width: width,
                      )
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: classroomProvider.listclassroom.length,
                        itemBuilder: (context, index) => Slidable(
                          endActionPane:
                              ActionPane(motion: ScrollMotion(), children: [
                            SlidableAction(
                              onPressed: (context) {
                                showDialog(
                                  context: context,
                                  builder: (context) => StatefulBuilder(
                                    builder: (context, setState) => AlertDialog(
                                      title: Text(AppLocalizations.of(context)!
                                          .editclass),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextInpuAll(
                                              label:
                                                  AppLocalizations.of(context)!
                                                      .classname,
                                              controller: roomnamecontroller,
                                              isPassword: false,
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () async {
                                              setState(
                                                () {},
                                              );
                                              if (await classroomProvider
                                                  .update_class(
                                                      name: roomnamecontroller
                                                          .text,
                                                      classid: classroomProvider
                                                          .listclassroom[index]
                                                          .id)) {
                                                AwesomeDialog(
                                                  context: context,
                                                  dialogType:
                                                      DialogType.success,
                                                  animType: AnimType.scale,
                                                  title: AppLocalizations.of(
                                                          context)!
                                                      .messageeditclass,
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
                                                        ((route) => false));
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
                                                  dialogType: DialogType.error,
                                                  animType: AnimType.scale,
                                                  title: AppLocalizations.of(
                                                          context)!
                                                      .titleerrordialog,
                                                  desc: AppLocalizations.of(
                                                          context)!
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
                                                        ((route) => false));
                                                  },
                                                  btnOkText:
                                                      AppLocalizations.of(
                                                              context)!
                                                          .ok,
                                                ).show();
                                              }
                                            },
                                            child: classroomProvider
                                                    .isloadingupdateclass
                                                ? Text(AppLocalizations.of(
                                                        context)!
                                                    .editing)
                                                : Text(AppLocalizations.of(
                                                        context)!
                                                    .edit)),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            style: ButtonStyle(
                                                overlayColor: MaterialStateColor
                                                    .resolveWith((states) =>
                                                        kPrimarycolor
                                                            .withAlpha(100))),
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .close,
                                              style: TextStyle(
                                                  color: kBaseSecondryColor),
                                            ))
                                      ],
                                    ),
                                  ),
                                );
                              },
                              backgroundColor: kPrimarycolor,
                              foregroundColor: Colors.white,
                              icon: Icons.edit,
                              // label: 'Share',
                            ),
                            SlidableAction(
                              onPressed: (context) {
                                showDialog(
                                  context: context,
                                  builder: (context) => StatefulBuilder(
                                    builder: (context, setState) => AlertDialog(
                                      // title: Text(AppLocalizations.of(context)!
                                      //     .addnewroom),
                                      content: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(AppLocalizations.of(context)!
                                              .areyousudedelete)
                                        ],
                                      ),
                                      actions: [
                                        ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateColor
                                                        .resolveWith((states) =>
                                                            Colors.red)),
                                            onPressed: () async {
                                              setState(
                                                () {},
                                              );
                                              if (await classroomProvider
                                                  .delete_class(
                                                      classid: classroomProvider
                                                          .listclassroom[index]
                                                          .id)) {
                                                AwesomeDialog(
                                                  context: context,
                                                  dialogType:
                                                      DialogType.success,
                                                  animType: AnimType.scale,
                                                  title: AppLocalizations.of(
                                                          context)!
                                                      .messagedelete,
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
                                                        ((route) => false));
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
                                                  dialogType: DialogType.error,
                                                  animType: AnimType.scale,
                                                  title: AppLocalizations.of(
                                                          context)!
                                                      .titleerrordialog,
                                                  desc: AppLocalizations.of(
                                                          context)!
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
                                                        ((route) => false));
                                                  },
                                                  btnOkText:
                                                      AppLocalizations.of(
                                                              context)!
                                                          .ok,
                                                ).show();
                                              }
                                            },
                                            child: classroomProvider
                                                    .isloadingdeleteclass
                                                ? Text(AppLocalizations.of(
                                                        context)!
                                                    .deleting)
                                                : Text(AppLocalizations.of(
                                                        context)!
                                                    .delete)),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            style: ButtonStyle(
                                                overlayColor: MaterialStateColor
                                                    .resolveWith((states) =>
                                                        kPrimarycolor
                                                            .withAlpha(100))),
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .close,
                                              style: TextStyle(
                                                  color: kBaseSecondryColor),
                                            ))
                                      ],
                                    ),
                                  ),
                                );
                              },
                              backgroundColor: Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              // label: 'Delete',
                            ),
                          ]),
                          child: SizedBox(
                            height: height * 0.1,
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
                                              "${classroomProvider.listclassroom[index].name}")
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
