import 'package:baba_karkar/constant/API-Url.dart';
import 'package:baba_karkar/constant/colors.dart';
import 'package:baba_karkar/controller/ScheduleProvider.dart';
import 'package:baba_karkar/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScheduleExam extends StatefulWidget {
  const ScheduleExam({super.key});

  @override
  State<ScheduleExam> createState() => _ScheduleExamState();
}

class _ScheduleExamState extends State<ScheduleExam> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      scheduleProvider.get_schedule_exam();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    scheduleProvider = Provider.of<ScheduleProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.examprogram),
        centerTitle: true,
      ),
      body: scheduleProvider.isloadinggetscheduleexam
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: kPrimarycolor,
                    ),
                  ],
                ),
              ],
            )
          : ListView(
              shrinkWrap: true,
              children: [
                scheduleProvider.scheduleexam.image == null
                    ? Center(
                        child:
                            Text(AppLocalizations.of(context)!.noexamprogram))
                    : InstaImageViewer(
                        child: Image.network(
                            "${AppApi.IMAGEURL}${scheduleProvider.scheduleexam.image}"),
                      ),
              ],
            ),
    );
  }
}
