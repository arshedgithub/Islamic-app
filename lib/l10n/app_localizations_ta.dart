// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get appName => 'Zikra';

  @override
  String get tabHome => 'முகப்பு';

  @override
  String get tabPrayers => 'தொழுகை நேரங்கள்';

  @override
  String get tabQuran => 'அல்-குர்ஆன்';

  @override
  String get tabGuidance => 'வழிகாட்டுதல்';

  @override
  String get tabTools => 'கருவிகள்';

  @override
  String get comingSoon => 'Coming soon';

  @override
  String get nextPrayer => 'அடுத்த தொழுகை';

  @override
  String get prayerTimesComingSoon => 'தொழுகை நேரங்கள் விரைவில்';

  @override
  String get prayerTimesUnavailableOffline =>
      'இணைப்பில்லாமல் தொழுகை நேரங்கள் கிடைக்காது';
}
