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

class ScheduleWeek extends StatefulWidget {
  const ScheduleWeek({super.key});

  @override
  State<ScheduleWeek> createState() => _ScheduleWeekState();
}

class _ScheduleWeekState extends State<ScheduleWeek> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      scheduleProvider.get_schedule_weekly();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    scheduleProvider = Provider.of<ScheduleProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.weeklyprogram),
        centerTitle: true,
      ),
      body: scheduleProvider.isloadinggetscheduleweek
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
                scheduleProvider.scheduleweek.image == null
                    ? Center(
                        child:
                            Text(AppLocalizations.of(context)!.noweekprogram))
                    : InstaImageViewer(
                        child: Image.network(
                            "${AppApi.IMAGEURL}${scheduleProvider.scheduleweek.image}"),
                      ),
              ],
            ),
    );
  }
}
