import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:baba_karkar/constant/colors.dart';
import 'package:baba_karkar/controller/ClassroomProvider.dart';
import 'package:baba_karkar/controller/LanguageProvider.dart';
import 'package:baba_karkar/controller/NewsProvider.dart';
import 'package:baba_karkar/main.dart';

import 'package:baba_karkar/view/Admin/Home/HomePageAdmin.dart';

import 'package:baba_karkar/widgets/ListSkelatonList.dart';
import 'package:baba_karkar/widgets/textinputall.dart';

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class AllNotificarionsStudent extends StatefulWidget {
  @override
  State<AllNotificarionsStudent> createState() =>
      _AllNotificarionsStudentState();
}

class _AllNotificarionsStudentState extends State<AllNotificarionsStudent> {
  final textnotifications = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      await newsProvider.get_my_news();
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
                newsProvider.isloadinggetmynews
                    ? ListSkelatonList(
                        height: height,
                        width: width,
                      )
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: newsProvider.listnews.length,
                        itemBuilder: (context, index) => Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              children: [
                                Text(
                                  "${AppLocalizations.of(context)!.idmessage}: ${newsProvider.listnews[index].id}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                AutoSizeText(
                                  "${newsProvider.listnews[index].text}",
                                  // maxLines: 4,
                                  softWrap: true,
                                ),
                              ],
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
