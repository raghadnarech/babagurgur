import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:baba_karkar/constant/colors.dart';
import 'package:baba_karkar/constant/fonts.dart';
import 'package:baba_karkar/controller/AuthProvider.dart';
import 'package:baba_karkar/controller/HomeworkProvider.dart';
import 'package:baba_karkar/controller/LanguageProvider.dart';
import 'package:baba_karkar/controller/NewsProvider.dart';
import 'package:baba_karkar/main.dart';
import 'package:baba_karkar/view/Admin/Classroom/classroomPage.dart';
import 'package:baba_karkar/view/Admin/Student/StudentHome.dart';
import 'package:baba_karkar/view/Admin/Teacher/TeacherHome.dart';
import 'package:baba_karkar/view/Auth/Login.dart';
import 'package:baba_karkar/view/Language/languagePage.dart';
import 'package:baba_karkar/view/Student/HomeWork/AllHMStudent.dart';
import 'package:baba_karkar/view/Student/Profile/ProfileStudent.dart';
import 'package:baba_karkar/view/Student/Schedule/ScheduleExam.dart';
import 'package:baba_karkar/view/Student/Schedule/ScheduleNormal.dart';
import 'package:baba_karkar/widgets/SkelatonCardGrid.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../Notifications/AllNotificarionsStudent.dart';

class HomePageStudent extends StatefulWidget {
  const HomePageStudent({super.key});

  @override
  State<HomePageStudent> createState() => _HomePageStudentState();
}

class _HomePageStudentState extends State<HomePageStudent> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      newsProvider.get_my_news();
      homeworkProvider.allmyhomework();
      phoneController.getphones();
      // authprovider.get_profile_user(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    newsProvider = Provider.of<NewsProvider>(context);
    homeworkProvider = Provider.of<HomeworkProvider>(context);
    authprovider = Provider.of<AuthProvider>(context);
    languageprovider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.homepage),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: SpeedDial(
          switchLabelPosition:
              languageprovider.locale == Locale("ar") ? false : true,
          // overlayOpacity: 0.5,
          icon: CupertinoIcons.phone,
          // animatedIcon: AnimatedIcons.ellipsis_search,
          backgroundColor: kPrimarycolor,
          children: [
            SpeedDialChild(
              onTap: () {
                // ignore: unnecessary_null_comparison
                phoneController.phone1 == ""
                    ? null
                    : whatsAppOpen(phone: phoneController.phone1);
              },
              backgroundColor: kPrimarycolor,
              labelBackgroundColor: kPrimarycolor,
              labelStyle: TextStyle(
                color: kBaseColor,
                fontWeight: FontWeight.bold,
              ),
              label: AppLocalizations.of(context)!.phone2,
            ),
            SpeedDialChild(
              onTap: () {
                phoneController.phone2 == ""
                    ? null
                    : whatsAppOpen(phone: phoneController.phone2);
              },
              backgroundColor: kPrimarycolor,
              labelBackgroundColor: kPrimarycolor,
              labelStyle: TextStyle(
                color: kBaseColor,
                fontWeight: FontWeight.bold,
              ),
              label: AppLocalizations.of(context)!.phone1,
            ),
          ]),
      drawer: Drawer(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Divider(
                  color: Colors.transparent,
                ),
                SizedBox(
                  width: width * 0.3,
                  child: Image.asset("images/Logo.png"),
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context)!.homepage),
                  leading: Icon(Icons.home),
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context)!.profile),
                  leading: Icon(Icons.person),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          child: ProfileStudent(),
                          type: PageTransitionType.fade),
                    );
                  },
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context)!.settings),
                  leading: Icon(Icons.settings),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          child: LanguagePage(), type: PageTransitionType.fade),
                    );
                  },
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context)!.logout),
                  leading: Icon(Icons.logout),
                  onTap: () async {
                    authprovider.logout();
                    Navigator.pushAndRemoveUntil(
                        context,
                        PageTransition(
                            child: Login(), type: PageTransitionType.fade),
                        (route) => false);
                  },
                ),
              ],
            ),
          ),
        ),
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
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: AutoSizeText(
                              AppLocalizations.of(context)!.lastnews,
                              maxLines: 1,
                              style: TextStyle(
                                  color: kBaseSecondryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                          newsProvider.isloadinggetmynews
                              ? SkelatonCardGrid(width: width, height: height)
                              : SizedBox(
                                  width: double.infinity,
                                  height: height * 0.2,
                                  child: Card(
                                    elevation: 2,
                                    child: SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: AutoSizeText(
                                          newsProvider.listnews.first.text!,
                                          style: TextStyle(
                                              color: kBaseSecondryColor,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: AutoSizeText(
                              AppLocalizations.of(context)!.lasthomework,
                              maxLines: 1,
                              style: TextStyle(
                                  color: kBaseSecondryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                          homeworkProvider.isloadinggetmyhomework
                              ? SkelatonCardGrid(width: width, height: height)
                              : SizedBox(
                                  width: double.infinity,
                                  height: height * 0.2,
                                  child: Card(
                                    elevation: 2,
                                    child: SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: AutoSizeText(
                                          homeworkProvider
                                              .listmyhomework.first.text!,
                                          style: TextStyle(
                                              color: kBaseSecondryColor,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // CarouselSlider(
              //     items: newsProvider.listnews
              //         .map(
              //           (e) => CardNews(news: "${e.text}"),
              //         )
              //         .toList(),
              //     options: CarouselOptions(
              //         autoPlay: false,
              //         reverse: false,
              //         enlargeCenterPage: true,
              //         enlargeStrategy: CenterPageEnlargeStrategy.scale)),
              GridView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, mainAxisExtent: height * .2),
                  children: [
                    CustomCardHomePage(
                      context,
                      ontap: AllHMStudent(),
                      icon: "images/Icon/report-card.png",
                      title: AppLocalizations.of(context)!.hw,
                    ),
                    CustomCardHomePage(
                      ontap: AllNotificarionsStudent(),
                      context,
                      icon: "images/Icon/sendalert.png",
                      title: AppLocalizations.of(context)!.notifications,
                    ),
                    // CustomCardHomePage(
                    //   context,
                    //   icon: "images/Icon/calenders.png",
                    //   title: AppLocalizations.of(context)!.weeklyprogram,
                    // ),
                    // CustomCardHomePage(
                    //   context,
                    //   icon: "images/Icon/father.png",
                    //   title: AppLocalizations.of(context)!.parents,
                    // ),
                    // CustomCardHomePage(
                    //   context,
                    //   ontap: TeacherHome(),
                    //   icon: "images/Icon/school.png",
                    //   title: AppLocalizations.of(context)!.teachers,
                    // ),
                    CustomCardHomePage(
                      ontap: ScheduleExam(),
                      context,
                      icon: "images/Icon/exam.png",
                      title: AppLocalizations.of(context)!.examprogram,
                    ),
                    CustomCardHomePage(
                      ontap: ScheduleWeek(),
                      context,
                      icon: "images/Icon/calenders.png",
                      title: AppLocalizations.of(context)!.weeklyprogram,
                    ),
                    // CustomCardHomePage(
                    //   context,
                    //   ontap: StudentHome(),
                    //   icon: "images/Icon/addstudent.png",
                    //   title: AppLocalizations.of(context)!.student,
                    // ),
                    // CustomCardHomePage(
                    //   context,
                    //   icon: "images/Icon/management.png",
                    //   title: AppLocalizations.of(context)!.schoolmanagement,
                    // ),
                  ]),
            ],
          ),
        ],
      ),
    );
  }
}

class CardNews extends StatelessWidget {
  String? news;
  CardNews({this.news});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Card(
        elevation: 5,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Text(news!),
          ),
        )),
      ),
    );
  }
}

CustomCardHomePage(BuildContext context,
    {String? icon, String? title, Widget? ontap}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        PageTransition(child: ontap!, type: PageTransitionType.fade),
      );
    },
    child: Container(
      color: kBaseColor,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Image.asset(
              icon!,
            ),
          ),
          AutoSizeText(
            title!,
            maxLines: 1,
            minFontSize: 14,
            maxFontSize: 16,
            // style: TextStyle(color: kBaseSecondryColor, fontSize: 14),
          )
        ],
      ),
    ),
  );
}

// void openWhatsapp(
//     {required BuildContext context,
//     required String text,
//     required String number}) async {
//   var whatsapp = number; //+92xx enter like this
//   var whatsappURlAndroid = "whatsapp://send?phone=" + whatsapp + "&text=$text";
//   var whatsappURLIos = "https://wa.me/$whatsapp?text=${Uri.tryParse(text)}";

//   // android , web
//   if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
//     await launchUrl(Uri.parse(whatsappURlAndroid));
//   } else {
//     ScaffoldMessenger.of(context)
//         .showSnackBar(const SnackBar(content: Text("Whatsapp not installed")));
//   }
// }
void whatsAppOpen({phone}) async {
  try {
    if (await canLaunchUrlString(
        "https://api.whatsapp.com/send?phone=$phone=Hello")) {
      await launchUrlString("https://api.whatsapp.com/send?phone=$phone=Hello");
    } else {
      throw 'Could not launch Whatsapp';
    }
  } catch (e) {
    print(e);
  }
}
