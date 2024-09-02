import 'package:baba_karkar/controller/LanguageProvider.dart';
import 'package:baba_karkar/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    languageprovider = Provider.of<LanguageProvider>(context);
    final locale = Localizations.localeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    languageprovider.setlocale(Locale("ar"));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("images/Flag/ar_flag.png"),
                      Text("العربية"),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    languageprovider.setlocale(Locale("en"));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("images/Flag/en_flag.png"),
                      Text("English"),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
