import 'package:baba_karkar/l10n/l10n.dart';
import 'package:baba_karkar/main.dart';
import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  Locale? _locale;

  Future<void> getlocale() async {
    String localeCode = await servicesProvider.getlocale();
    _locale = Locale(localeCode);
    notifyListeners();
  }

  Locale get locale => _locale ?? Locale('ar');

  void setlocale(Locale locale) async {
    if (!L10n.all.contains(locale)) return;
    _locale = locale;
    notifyListeners();
    servicesProvider.setlocale(locale.languageCode);
  }

  void clearLoacle() {
    _locale = null;
    notifyListeners();
  }
}
