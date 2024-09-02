import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:baba_karkar/constant/colors.dart';
import 'package:baba_karkar/constant/fonts.dart';
import 'package:baba_karkar/controller/AuthProvider.dart';
import 'package:baba_karkar/main.dart';
import 'package:baba_karkar/view/Admin/Home/HomePageAdmin.dart';
import 'package:baba_karkar/view/Auth/Signup.dart';
import 'package:baba_karkar/widgets/textinputall.dart';
import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final phoneloginController = TextEditingController();
  final passwordloginController = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    phoneloginController.clear();
    passwordloginController.clear();
    super.dispose();
  }

  @override
  // ButtonState stateOnlyText = ButtonState.idle;
  // ButtonState stateTextWithIcon = ButtonState.idle;
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(AppLocalizations.of(context)!.login,
                                  style: defaultstyle),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextInpuAll(
                                    controller: phoneloginController,
                                    label: AppLocalizations.of(context)!.phone,
                                    isPassword: false,
                                    type: TextInputType.phone,
                                  ),
                                  TextInpuAll(
                                    controller: passwordloginController,
                                    label:
                                        AppLocalizations.of(context)!.password,
                                    isPassword: true,
                                    type: TextInputType.phone,
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (await authprovider.login(
                                      phone: phoneloginController.text,
                                      password: passwordloginController.text,
                                      context: context)) {
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
                                      btnOkText:
                                          AppLocalizations.of(context)!.ok,
                                    ).show();
                                  }
                                },
                                child: authprovider.isloadinglogin
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
                                            AppLocalizations.of(context)!.login,
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
                          AppLocalizations.of(context)!.skiptosignup,
                        ),
                        TextButton(
                          child: Text(AppLocalizations.of(context)!.signup,
                              style: TextStyle(color: kPrimarycolor)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: Signup(),
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
