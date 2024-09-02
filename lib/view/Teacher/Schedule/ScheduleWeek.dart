import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:baba_karkar/constant/colors.dart';
import 'package:baba_karkar/controller/ClassroomProvider.dart';
import 'package:baba_karkar/controller/ScheduleProvider.dart';
import 'package:baba_karkar/main.dart';
import 'package:baba_karkar/widgets/SkelatonCardList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

import 'package:image_picker_ios/image_picker_ios.dart';
import 'package:provider/provider.dart';
import '../../../widgets/cardSelectImage.dart';

class ScheduleWeekTeacher extends StatefulWidget {
  const ScheduleWeekTeacher({super.key});

  @override
  State<ScheduleWeekTeacher> createState() => _ScheduleWeekTeacherState();
}

class _ScheduleWeekTeacherState extends State<ScheduleWeekTeacher> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      classroomProvider.get_all_class();
      // await classroomProvider.get_all_room();
    });
    super.initState();
  }

  ImagePickerIOS picker = ImagePickerIOS();

  XFile? image;

  openimagefromgalleryID() async {
    image = await picker.getImage(source: ImageSource.gallery);
  }

  int? idroom;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    classroomProvider = Provider.of<ClassroomProvider>(context);
    scheduleProvider = Provider.of<ScheduleProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.weeklyprogram),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            classroomProvider.isloadinggetallclass ||
                    classroomProvider.isloadinggetallroom
                ? SkelatonCardList(width: width, height: height * .7)
                : DropdownButtonFormField(
                    focusColor: kPrimarycolor,
                    hint: Text(AppLocalizations.of(context)!.selectroom),
                    decoration: InputDecoration(
                      hoverColor: kPrimarycolor,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kPrimarycolor),
                      ),
                    ),
                    items: classroomProvider.listroom.map((room) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: CardSelectImage(
                      width: width,
                      ondelete: () {
                        setState(() {
                          image = null;
                        });
                      },
                      isfill: image != null,
                      image: image == null
                          ? Image.asset(
                              "images/gallery.png",
                              fit: BoxFit.fitHeight,
                            )
                          : Image.file(File(image!.path)),
                      title: AppLocalizations.of(context)!.weeklyprogramimage,
                      ontap: () async {
                        await openimagefromgalleryID();
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => kPrimarycolor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          )),
                        ),
                        onPressed: () async {
                          if (await scheduleProvider.CreateWeeklySchedule(
                            image: File(image!.path),
                            roomid: idroom,
                          )) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.scale,
                              title: AppLocalizations.of(context)!
                                  .messagesendmessage,
                              // desc: "سيتم مراجعة طلبك في أقرب وقت",
                              btnOkOnPress: () {
                                Navigator.pop(context);
                              },
                              btnOkText: AppLocalizations.of(context)!.ok,
                            ).show();
                          } else {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.scale,
                              title: AppLocalizations.of(context)!
                                  .titleerrordialog,
                              desc: AppLocalizations.of(context)!
                                  .messageerrordialog,
                              btnOkOnPress: () {},
                              btnOkText: AppLocalizations.of(context)!.ok,
                            ).show();
                          }
                        },
                        child: scheduleProvider.isloadinggsendscheduleweek
                            ? Text(AppLocalizations.of(context)!.sending)
                            : Text(AppLocalizations.of(context)!.send)))
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => kPrimarycolor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          )),
                        ),
                        onPressed: () async {
                          if (await scheduleProvider.UpdateWeeklySchedule(
                            image: File(image!.path),
                            roomid: idroom,
                          )) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.scale,
                              title: AppLocalizations.of(context)!
                                  .messagesendmessage,
                              // desc: "سيتم مراجعة طلبك في أقرب وقت",
                              btnOkOnPress: () {
                                Navigator.pop(context);
                              },
                              btnOkText: AppLocalizations.of(context)!.ok,
                            ).show();
                          } else {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.scale,
                              title: AppLocalizations.of(context)!
                                  .titleerrordialog,
                              desc: AppLocalizations.of(context)!
                                  .messageerrordialog,
                              btnOkOnPress: () {},
                              btnOkText: AppLocalizations.of(context)!.ok,
                            ).show();
                          }
                        },
                        child: scheduleProvider.isloadinggupdatescheduleweek
                            ? Text(AppLocalizations.of(context)!.editing)
                            : Text(AppLocalizations.of(context)!.edit)))
              ],
            )
          ],
        ),
      ),
    );
  }
}
