import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:baba_karkar/constant/colors.dart';
import 'package:baba_karkar/constant/fonts.dart';
import 'package:baba_karkar/controller/AuthProvider.dart';
import 'package:baba_karkar/main.dart';
import 'package:baba_karkar/view/Auth/Login.dart';
import 'package:baba_karkar/view/Auth/Signup.dart';
import 'package:baba_karkar/widgets/textinputall.dart';
import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _key = GlobalKey<FormState>();

  final phonesignupController = TextEditingController();
  final passwordsignupController = TextEditingController();
  final namesignupController = TextEditingController();
  @override
  void dispose() {
    phonesignupController.clear();
    passwordsignupController.clear();
    namesignupController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authprovider = Provider.of<AuthProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
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
                        height: 400,
                        width: width * .9,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: kPrimarycolor,
                                  offset: Offset(0, 0),
                                  blurRadius: 20)
                            ],
                            color: kBaseColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(AppLocalizations.of(context)!.signup,
                                  style: defaultstyle),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextInpuAll(
                                    label: AppLocalizations.of(context)!.name,
                                    isPassword: false,
                                    controller: namesignupController,
                                    type: TextInputType.phone,
                                  ),
                                  TextInpuAll(
                                    label: AppLocalizations.of(context)!.phone,
                                    isPassword: false,
                                    controller: phonesignupController,
                                    type: TextInputType.phone,
                                  ),
                                  TextInpuAll(
                                    label:
                                        AppLocalizations.of(context)!.password,
                                    isPassword: true,
                                    controller: passwordsignupController,
                                    type: TextInputType.phone,
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (await authprovider.Signup(
                                      name: namesignupController.text,
                                      phone: phonesignupController.text,
                                      password:
                                          passwordsignupController.text)) {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.success,
                                      animType: AnimType.scale,
                                      title: AppLocalizations.of(context)!
                                          .alertdialogsignuptitlesuccess,
                                      desc: AppLocalizations.of(context)!
                                          .alertdialogsignupcontentsuccess,
                                      btnOkOnPress: () {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            PageTransition(
                                                child: Login(),
                                                type: PageTransitionType.fade),
                                            (route) => false);
                                      },
                                      btnOkText:
                                          AppLocalizations.of(context)!.ok,
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
                                      btnOkOnPress: () {
                                        Navigator.pop(
                                          context,
                                        );
                                      },
                                      btnOkText:
                                          AppLocalizations.of(context)!.ok,
                                    ).show();
                                  }
                                },
                                child: authprovider.isloadingsignup
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
                                            AppLocalizations.of(context)!
                                                .signup,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.skiptologin,
                        ),
                        TextButton(
                          child: Text(AppLocalizations.of(context)!.login,
                              style: TextStyle(color: kPrimarycolor)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: Login(),
                                    type: PageTransitionType.fade));
                          },
                        ),
                      ],
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
      ),
    );
  }
}
