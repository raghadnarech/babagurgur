import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:baba_karkar/constant/colors.dart';
import 'package:baba_karkar/constant/fonts.dart';
import 'package:baba_karkar/controller/ClassroomProvider.dart';
import 'package:baba_karkar/controller/LanguageProvider.dart';
import 'package:baba_karkar/controller/PhoneController.dart';
import 'package:baba_karkar/main.dart';
import 'package:baba_karkar/model/Room.dart';
import 'package:baba_karkar/view/Admin/Home/HomePageAdmin.dart';
import 'package:baba_karkar/widgets/ListSkelatonClass.dart';
import 'package:baba_karkar/widgets/ListSkelatonList.dart';
import 'package:baba_karkar/widgets/SkelatonCard.dart';
import 'package:baba_karkar/widgets/SkelatonCardList.dart';
import 'package:baba_karkar/widgets/textinputall.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flexi_chip/flexi_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class PhonePage extends StatefulWidget {
  const PhonePage({super.key});

  @override
  State<PhonePage> createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  final phone1controller = TextEditingController();
  final phone2controller = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      await phoneController.getphones();
      phone1controller.text = phoneController.phone1;
      phone2controller.text = phoneController.phone2;
    });

    super.initState();
  }

  @override
  void dispose() {
    phone1controller.clear();
    phone2controller.clear();
    super.dispose();
  }

  int? idclass;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    phoneController = Provider.of<PhoneController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.phonepage),
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
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
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
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                phoneController.isloadinggetphone
                                    ? SkelatonCardList(
                                        width: width, height: height * .7)
                                    : TextInpuAll(
                                        controller: phone1controller,
                                        label: AppLocalizations.of(context)!
                                            .phone1,
                                        isPassword: false,
                                        type: TextInputType.phone,
                                      ),
                                phoneController.isloadinggetphone
                                    ? SkelatonCardList(
                                        width: width, height: height * .7)
                                    : TextInpuAll(
                                        controller: phone2controller,
                                        label: AppLocalizations.of(context)!
                                            .phone2,
                                        isPassword: F,
                                        type: TextInputType.phone,
                                      ),
                              ],
                            ),
                            Divider(
                              color: Colors.transparent,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (await phoneController.updatenumbers(
                                  phone1: phone1controller.text,
                                  phone2: phone2controller.text,
                                )) {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.success,
                                    animType: AnimType.scale,
                                    title: AppLocalizations.of(context)!
                                        .messageeditphone,
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
                              child: phoneController.isloadingupdatephone
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
                                          AppLocalizations.of(context)!.edit,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
