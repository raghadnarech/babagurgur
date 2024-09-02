import 'package:baba_karkar/constant/colors.dart';
import 'package:baba_karkar/constant/fonts.dart';
import 'package:baba_karkar/controller/AuthProvider.dart';
import 'package:baba_karkar/main.dart';
import 'package:baba_karkar/view/Auth/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PleaseActiveAccount extends StatelessWidget {
  const PleaseActiveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    authprovider = Provider.of<AuthProvider>(context);

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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(AppLocalizations.of(context)!.pleaseactive,
                                textAlign: TextAlign.center,
                                style: defaultstyle),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Divider(
                                  color: Colors.transparent,
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () async {
                                await authprovider.logout();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  PageTransition(
                                      child: Login(),
                                      type: PageTransitionType.fade),
                                  (route) => false,
                                );
                              },
                              child: Container(
                                  width: width * .4,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: kPrimarycolor,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Text(
                                      AppLocalizations.of(context)!.logout,
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
