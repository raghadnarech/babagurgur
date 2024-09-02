import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:baba_karkar/constant/colors.dart';
import 'package:baba_karkar/controller/ClassroomProvider.dart';
import 'package:baba_karkar/controller/LanguageProvider.dart';
import 'package:baba_karkar/controller/NewsProvider.dart';
import 'package:baba_karkar/main.dart';

import 'package:baba_karkar/view/Admin/Home/HomePageAdmin.dart';
import 'package:baba_karkar/view/Teacher/Notifications/AllNotificarions.dart';

import 'package:baba_karkar/widgets/ListSkelatonList.dart';
import 'package:baba_karkar/widgets/textinputall.dart';

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class SendNotifications extends StatefulWidget {
  const SendNotifications({super.key});

  @override
  State<SendNotifications> createState() => _SendNotificationsState();
}

class _SendNotificationsState extends State<SendNotifications> {
  final textnotifications = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      await classroomProvider.get_all_class();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    classroomProvider = Provider.of<ClassroomProvider>(context);
    languageprovider = Provider.of<LanguageProvider>(context);
    newsProvider = Provider.of<NewsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.notifications),
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
                            // newsProvider.allnewsfromroom(
                            //     classroomProvider.listroom[index].id);
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: AllNotifications(
                                        id: classroomProvider
                                            .listroom[index].id),
                                    type: PageTransitionType.fade));
                          },
                          child: Slidable(
                            endActionPane:
                                ActionPane(motion: ScrollMotion(), children: [
                              SlidableAction(
                                icon: Icons.send,
                                foregroundColor: kBaseColor,
                                backgroundColor: kPrimarycolor,
                                onPressed: (context) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => StatefulBuilder(
                                      builder: (context, setState) =>
                                          AlertDialog(
                                        title: Text(
                                            AppLocalizations.of(context)!
                                                .sendnotifications),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextInpuAll(
                                                label: AppLocalizations.of(
                                                        context)!
                                                    .textnotifications,
                                                controller: textnotifications,
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
                                                    .SendMessageToRoom(
                                                        text: textnotifications
                                                            .text,
                                                        roomid:
                                                            classroomProvider
                                                                .listroom[index]
                                                                .id)) {
                                                  AwesomeDialog(
                                                    context: context,
                                                    dialogType:
                                                        DialogType.success,
                                                    animType: AnimType.scale,
                                                    title: AppLocalizations.of(
                                                            context)!
                                                        .messagesendmessage,
                                                    // desc: "سيتم مراجعة طلبك في أقرب وقت",
                                                    btnOkOnPress: () {
                                                      Navigator.pop(context);
                                                      textnotifications.clear();
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
                                                    animType: AnimType.scale,
                                                    title: AppLocalizations.of(
                                                            context)!
                                                        .titleerrordialog,
                                                    desc: AppLocalizations.of(
                                                            context)!
                                                        .messageerrordialog,
                                                    btnOkOnPress: () {
                                                      textnotifications.clear();
                                                    },
                                                    btnOkText:
                                                        AppLocalizations.of(
                                                                context)!
                                                            .ok,
                                                  ).show();
                                                }
                                              },
                                              child: classroomProvider
                                                      .isloadingSendMessageToRoom
                                                  ? Text(AppLocalizations.of(
                                                          context)!
                                                      .sending)
                                                  : Text(AppLocalizations.of(
                                                          context)!
                                                      .send)),
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
                              )
                            ]),
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
                        ),
                      )
              ]),
        ],
      ),
    );
  }
}
