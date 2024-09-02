import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:baba_karkar/constant/colors.dart';
import 'package:baba_karkar/controller/HomeworkProvider.dart';
import 'package:baba_karkar/controller/ServicesProvider.dart';
import 'package:baba_karkar/widgets/cardSelectImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker_ios/image_picker_ios.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import '../../../widgets/textinputall.dart';

class PageSendHM extends StatefulWidget {
  PageSendHM({this.id});
  int? id;

  @override
  State<PageSendHM> createState() => _PageSendHMState();
}

ImagePickerIOS picker = ImagePickerIOS();

XFile? image;

openimagefromgalleryID() async {
  image = await picker.getImage(source: ImageSource.gallery);
}

final textnotifications = TextEditingController();

class _PageSendHMState extends State<PageSendHM> {
  @override
  void dispose() {
    textnotifications.clear();
    image = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    homeworkProvider = Provider.of<HomeworkProvider>(context);
    servicesProvider = Provider.of<ServicesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.sendhomework),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextInpuAll(
                label: AppLocalizations.of(context)!.texthomework,
                controller: textnotifications,
                isPassword: false,
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
                        title: AppLocalizations.of(context)!.homeworkimage,
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
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )),
                          ),
                          onPressed: () async {
                            if (await homeworkProvider.SendHMToRoom(
                                image: image == null ? null : File(image!.path),
                                roomid: widget.id,
                                text: textnotifications.text)) {
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
                          child: homeworkProvider.isloadingsendhomework
                              ? Text(AppLocalizations.of(context)!.sending)
                              : Text(AppLocalizations.of(context)!.send)))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
