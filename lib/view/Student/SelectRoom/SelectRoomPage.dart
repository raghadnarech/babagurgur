import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:baba_karkar/constant/colors.dart';
import 'package:baba_karkar/constant/fonts.dart';
import 'package:baba_karkar/controller/AuthProvider.dart';
import 'package:baba_karkar/controller/ClassroomProvider.dart';
import 'package:baba_karkar/controller/StrudentProvider.dart';
import 'package:baba_karkar/main.dart';
import 'package:baba_karkar/widgets/SkelatonCardList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Auth/Login.dart';

class SelectRoomPage extends StatefulWidget {
  const SelectRoomPage({super.key});

  @override
  State<SelectRoomPage> createState() => _SelectRoomPageState();
}

class _SelectRoomPageState extends State<SelectRoomPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      classroomProvider.get_all_class();
      // await classroomProvider.get_all_room();
    });
    super.initState();
  }

  int? idroom;

  @override
  Widget build(BuildContext context) {
    authprovider = Provider.of<AuthProvider>(context);
    classroomProvider = Provider.of<ClassroomProvider>(context);
    studentProvider = Provider.of<StudentProvider>(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: height,
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Image.asset(
                'images/Splash.png',
                fit: BoxFit.cover,
                height: height,
                width: width,
              ),
            ),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SafeArea(
                    child: Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: SizedBox(
                          width: width * 0.5,
                          child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Image.asset('images/Logo.png')),
                        ),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Container(
                      height: 300,
                      width: width * .9,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: kPrimarycolor,
                                offset: Offset(0, 0),
                                blurRadius: 20)
                          ],
                          color: kBaseColor,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(AppLocalizations.of(context)!.selectyourroom,
                                style: defaultstyle),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                classroomProvider.isloadinggetallclass ||
                                        classroomProvider.isloadinggetallroom
                                    ? SkelatonCardList(
                                        width: width, height: height * .7)
                                    : DropdownButtonFormField(
                                        focusColor: kPrimarycolor,
                                        hint: Text(AppLocalizations.of(context)!
                                            .selectroom),
                                        decoration: InputDecoration(
                                          hoverColor: kPrimarycolor,
                                          // Customize the underline color for the selected item
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: kPrimarycolor),
                                          ),
                                        ),
                                        items: classroomProvider.listroom
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
                                      ),
                                Divider(
                                  color: Colors.transparent,
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (await studentProvider.SelectMyRoom(
                                    roomid: idroom, context: context)) {
                                } else {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.scale,
                                    title: AppLocalizations.of(context)!
                                        .titleerrordialog,
                                    desc: AppLocalizations.of(context)!
                                        .messageerrordialog,
                                    btnOkOnPress: () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        PageTransition(
                                            child: Login(),
                                            type: PageTransitionType.fade),
                                        (route) => false,
                                      );
                                    },
                                    btnOkText: AppLocalizations.of(context)!.ok,
                                  ).show();
                                }
                              },
                              child: studentProvider.isloadingSelectmyroom
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: kPrimarycolor,
                                      ),
                                    )
                                  : Container(
                                      width: width * .4,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: kPrimarycolor,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Center(
                                        child: Text(
                                          AppLocalizations.of(context)!.join,
                                          style: TextStyle(
                                              color: kBaseColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.transparent,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            languageprovider.setlocale(Locale("ar"));
                          },
                          child: Image.asset(
                            "images/Flag/ar_flag.png",
                            width: 35,
                          ),
                        ),
                        VerticalDivider(
                          color: Colors.transparent,
                        ),
                        GestureDetector(
                          onTap: () {
                            languageprovider.setlocale(Locale("en"));
                          },
                          child: Image.asset(
                            "images/Flag/en_flag.png",
                            width: 35,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
