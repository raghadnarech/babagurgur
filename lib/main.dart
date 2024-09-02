import 'dart:async';
import 'package:baba_karkar/constant/colors.dart';
import 'package:baba_karkar/controller/AuthProvider.dart';
import 'package:baba_karkar/controller/ClassroomProvider.dart';
import 'package:baba_karkar/controller/HomeworkProvider.dart';
import 'package:baba_karkar/controller/LanguageProvider.dart';
import 'package:baba_karkar/controller/NewsProvider.dart';
import 'package:baba_karkar/controller/PhoneController.dart';
import 'package:baba_karkar/controller/ScheduleProvider.dart';
import 'package:baba_karkar/controller/ServicesProvider.dart';
import 'package:baba_karkar/controller/StrudentProvider.dart';
import 'package:baba_karkar/controller/TeacherProvider.dart';

import 'package:baba_karkar/l10n/l10n.dart';
import 'package:baba_karkar/view/Splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool isLogged = preferences.getBool("isLogged") ?? false;
  String? localeCode = preferences.getString('lang');
  Locale? locale = localeCode != null ? Locale(localeCode) : null;

  print(isLogged);
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<LanguageProvider>(
          create: (context) => LanguageProvider(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider<ClassroomProvider>(
          create: (context) => ClassroomProvider(),
        ),
        ChangeNotifierProvider<ServicesProvider>(
          create: (context) => ServicesProvider(),
        ),
        ChangeNotifierProvider<StudentProvider>(
          create: (context) => StudentProvider(),
        ),
        ChangeNotifierProvider<TeacherProvider>(
          create: (context) => TeacherProvider(),
        ),
        ChangeNotifierProvider<NewsProvider>(
          create: (context) => NewsProvider(),
        ),
        ChangeNotifierProvider<HomeworkProvider>(
          create: (context) => HomeworkProvider(),
        ),
        ChangeNotifierProvider<ScheduleProvider>(
          create: (context) => ScheduleProvider(),
        ),
        ChangeNotifierProvider<PhoneController>(
          create: (context) => PhoneController(),
        ),
      ],
      child: MyApp(
        isLogged: isLogged,
        locale: locale,
      )));
}

AuthProvider authprovider = AuthProvider();
LanguageProvider languageprovider = LanguageProvider();
ClassroomProvider classroomProvider = ClassroomProvider();
ServicesProvider servicesProvider = ServicesProvider();
StudentProvider studentProvider = StudentProvider();
TeacherProvider teacherProvider = TeacherProvider();
NewsProvider newsProvider = NewsProvider();
HomeworkProvider homeworkProvider = HomeworkProvider();
ScheduleProvider scheduleProvider = ScheduleProvider();
PhoneController phoneController = PhoneController();

class MyApp extends StatefulWidget {
  bool? isLogged;
  Locale? locale;
  MyApp({this.isLogged, this.locale});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      await languageprovider.getlocale();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // didChangeDependencies();
    languageprovider = Provider.of<LanguageProvider>(context);
    return MaterialApp(
      theme: ThemeData(
        fontFamily:
            languageprovider.locale == Locale("ar") ? 'Cairo' : 'Poppins',
        primaryColor: kPrimarycolor,
        backgroundColor: kBaseColor,
        scaffoldBackgroundColor: kBaseColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => kPrimarycolor))),
        appBarTheme: AppBarTheme(backgroundColor: kPrimarycolor),
        iconTheme: IconThemeData(
          color: kPrimarycolor,
        ),
      ),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: L10n.all,
      locale: languageprovider.locale,
      debugShowCheckedModeBanner: false,
      home: Splash(isLogged: widget.isLogged),
    );
  }
}
