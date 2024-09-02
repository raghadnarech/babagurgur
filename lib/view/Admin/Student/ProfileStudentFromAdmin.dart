import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:baba_karkar/constant/colors.dart';
import 'package:baba_karkar/controller/AuthProvider.dart';
import 'package:baba_karkar/controller/StrudentProvider.dart';
import 'package:baba_karkar/main.dart';
import 'package:baba_karkar/view/Admin/Home/HomePageAdmin.dart';
import 'package:baba_karkar/view/Auth/Login.dart';
import 'package:baba_karkar/view/Student/Home/HomePageStudent.dart';
import 'package:baba_karkar/widgets/SkelatonCardList.dart';
import 'package:baba_karkar/widgets/textinputall.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ProfileStudentfromAdmin extends StatefulWidget {
  int? id;
  ProfileStudentfromAdmin({this.id});
  @override
  State<ProfileStudentfromAdmin> createState() =>
      _ProfileStudentfromAdminState();
}

class _ProfileStudentfromAdminState extends State<ProfileStudentfromAdmin> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      await authprovider.get_profile_user_from_admin(widget.id);
      namecontroller.text = await authprovider.profilestudent.name!;
      phonecontroller.text = await authprovider.profilestudent.phone!;
    });

    super.initState();
  }

  final namecontroller = TextEditingController();

  final phonecontroller = TextEditingController();

  final passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    authprovider = Provider.of<AuthProvider>(context);
    studentProvider = Provider.of<StudentProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.profile),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: authprovider.isloadinggetprofileadmin
                  ? SkelatonCardList(width: width, height: height)
                  : Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: kPrimarycolor,
                              radius: 30,
                              child: Icon(
                                Icons.person,
                                color: kBaseColor,
                                size: 40,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                        AppLocalizations.of(context)!.name),
                                    VerticalDivider(
                                      color: Colors.transparent,
                                    ),
                                    AutoSizeText(
                                        AppLocalizations.of(context)!.phone),
                                  ],
                                ),
                                VerticalDivider(),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                        authprovider.profilestudent.name!),
                                    VerticalDivider(
                                      color: Colors.transparent,
                                    ),
                                    AutoSizeText(
                                        authprovider.profilestudent.phone!),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            Divider(
              color: kPrimarycolor,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => StatefulBuilder(
                      builder: (context, setState) => AlertDialog(
                        title: Text(AppLocalizations.of(context)!.editprofile),
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextInpuAll(
                                label: AppLocalizations.of(context)!.name,
                                controller: namecontroller,
                                isPassword: false,
                              ),
                              TextInpuAll(
                                label: AppLocalizations.of(context)!.phone,
                                controller: phonecontroller,
                                isPassword: false,
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                              onPressed: () async {
                                setState(
                                  () {},
                                );
                                if (await authprovider.update_user_from_admin(
                                    id: widget.id,
                                    name: namecontroller.text,
                                    phone: phonecontroller.text)) {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.success,
                                    animType: AnimType.scale,
                                    title: AppLocalizations.of(context)!
                                        .messageeditprofile,
                                    // desc: "سيتم مراجعة طلبك في أقرب وقت",
                                    btnOkOnPress: () {},
                                    btnOkText: AppLocalizations.of(context)!.ok,
                                  ).show();
                                } else {
                                  setState(
                                    () {},
                                  );
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
                              child: authprovider
                                      .isloadingupdateprofilestudentfromadmin
                                  ? Text(AppLocalizations.of(context)!.editing)
                                  : Text(AppLocalizations.of(context)!.edit)),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                  overlayColor: MaterialStateColor.resolveWith(
                                      (states) =>
                                          kPrimarycolor.withAlpha(100))),
                              child: Text(
                                AppLocalizations.of(context)!.close,
                                style: TextStyle(color: kBaseSecondryColor),
                              ))
                        ],
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.edit),
                label: Text(AppLocalizations.of(context)!.editprofile)),
            ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateColor.resolveWith((states) => Colors.red)),
                onPressed: () async {
                  if (await studentProvider.delete_user(
                    userid: widget.id,
                  )) {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.success,
                      animType: AnimType.scale,
                      title: AppLocalizations.of(context)!.messagedelete,
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
                    setState(
                      () {},
                    );
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.scale,
                      title: AppLocalizations.of(context)!.titleerrordialog,
                      desc: AppLocalizations.of(context)!.messageerrordialog,
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
                  }
                },
                icon: Icon(Icons.delete),
                label: studentProvider.isloadingdeleteuser
                    ? Text(AppLocalizations.of(context)!.deleting)
                    : Text(AppLocalizations.of(context)!.delete)),
          ],
        ),
      ),
    );
  }
}
