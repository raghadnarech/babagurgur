import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:baba_karkar/constant/API-Url.dart';
import 'package:baba_karkar/constant/colors.dart';
import 'package:baba_karkar/controller/ClassroomProvider.dart';
import 'package:baba_karkar/controller/HomeworkProvider.dart';
import 'package:baba_karkar/controller/LanguageProvider.dart';
import 'package:baba_karkar/controller/NewsProvider.dart';
import 'package:baba_karkar/main.dart';

import 'package:baba_karkar/view/Admin/Home/HomePageAdmin.dart';

import 'package:baba_karkar/widgets/ListSkelatonList.dart';
import 'package:baba_karkar/widgets/textinputall.dart';

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class AllHMStudent extends StatefulWidget {
  @override
  State<AllHMStudent> createState() => _AllHMStudentState();
}

class _AllHMStudentState extends State<AllHMStudent> {
  final textnotifications = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      await homeworkProvider.allmyhomework();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    classroomProvider = Provider.of<ClassroomProvider>(context);
    languageprovider = Provider.of<LanguageProvider>(context);
    homeworkProvider = Provider.of<HomeworkProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.hw),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
                Colors.grey.withOpacity(0.5), BlendMode.dstATop),
            child: Image.asset(
              "images/Splash.png",
              height: height,
              fit: BoxFit.cover,
            ),
          ),
          ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              children: [
                homeworkProvider.isloadinggetmyhomework
                    ? ListSkelatonList(
                        height: height,
                        width: width,
                      )
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: homeworkProvider.listmyhomework.length,
                        itemBuilder: (context, index) => Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              children: [
                                Text(
                                  "${AppLocalizations.of(context)!.idhomework}: ${homeworkProvider.listmyhomework[index].id}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                AutoSizeText(
                                  "${homeworkProvider.listmyhomework[index].text}",
                                  // maxLines: 4,
                                  softWrap: true,
                                ),
                                homeworkProvider.listmyhomework[index].image ==
                                        null
                                    ? Center(
                                        child: Image.asset(
                                        'images/noimage.png',
                                        width: width * 0.2,
                                        fit: BoxFit.fitWidth,
                                      ))
                                    : Center(
                                        child: InstaImageViewer(
                                          child: Image.network(
                                            "${AppApi.IMAGEURL}${homeworkProvider.listmyhomework[index].image}",
                                            width: width * 0.9,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                      )
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
