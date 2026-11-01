// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Zikra';

  @override
  String get tabHome => 'Home';

  @override
  String get tabPrayers => 'Prayers';

  @override
  String get tabQuran => 'Quran';

  @override
  String get tabGuidance => 'Guidance';

  @override
  String get tabTools => 'Tools';

  @override
  String get comingSoon => 'Coming soon';

  @override
  String get nextPrayer => 'Next prayer';

  @override
  String get prayerTimesComingSoon => 'Prayer times coming soon';

  @override
  String get prayerTimesUnavailableOffline =>
      'Prayer times unavailable offline';
}
