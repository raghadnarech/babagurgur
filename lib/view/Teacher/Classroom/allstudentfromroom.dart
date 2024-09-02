import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:baba_karkar/constant/colors.dart';
import 'package:baba_karkar/controller/ClassroomProvider.dart';
import 'package:baba_karkar/controller/StrudentProvider.dart';
import 'package:baba_karkar/main.dart';
import 'package:baba_karkar/view/Admin/Home/HomePageAdmin.dart';
import 'package:baba_karkar/view/Admin/Student/ProfileStudentFromAdmin.dart';
import 'package:baba_karkar/widgets/GridSkelaton.dart';
import 'package:baba_karkar/widgets/textinputall.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AllStudentFromRoom extends StatefulWidget {
  AllStudentFromRoom({super.key});

  @override
  State<AllStudentFromRoom> createState() => _AllStudentFromRoomState();
}

class _AllStudentFromRoomState extends State<AllStudentFromRoom> {
  final namecontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      // studentProvider.get_all_student();
      // classroomProvider.get_all_class();
      // await classroomProvider.get_all_room();
    });
    super.initState();
  }

  int? idroom;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    studentProvider = Provider.of<StudentProvider>(context);
    // classroomProvider = Provider.of<ClassroomProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.student),
        centerTitle: true,
      ),
      body: Stack(children: [
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
        studentProvider.isloadinggetallstudentfromroom
            ? GridSkelaton(
                height: height,
                width: width,
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.8, crossAxisCount: 2),
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: studentProvider.liststudentfromroom.length,
                  itemBuilder: (context, index) => SizedBox(
                    // height: height * 0.5,
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              size: 40,
                              color: kPrimarycolor,
                            ),
                            Expanded(
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: AutoSizeText(
                                          AppLocalizations.of(context)!.name)),
                                  AutoSizeText(
                                    softWrap: true,
                                    "${studentProvider.liststudentfromroom[index].name}",
                                    maxLines: 1,
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.transparent,
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: AutoSizeText(
                                          AppLocalizations.of(context)!.phone)),
                                  AutoSizeText(
                                    softWrap: true,
                                    "${studentProvider.liststudentfromroom[index].phone}",
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.transparent,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: () async {
                                    whatsAppOpen(studentProvider
                                        .liststudentfromroom[index].phone);
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.chat),
                                      VerticalDivider(
                                        color: Colors.transparent,
                                      ),
                                      Expanded(
                                        child: AutoSizeText(
                                          AppLocalizations.of(context)!
                                              .whatsapp,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
      ]),
    );
  }
}

void whatsAppOpen(String? phone) async {
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
