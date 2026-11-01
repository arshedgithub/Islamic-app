import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zikra/l10n/app_localizations.dart';

// Minimal stub app that mirrors the real ZikraApp's locale wiring without
// needing go_router or real platform channels.
class _TestApp extends StatelessWidget {
  const _TestApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: Builder(
          builder: (context) {
            final l10n = AppLocalizations.of(context);
            return Column(
              children: [
                Text(l10n.tabHome),
                Text(l10n.tabPrayers),
                Text(l10n.tabQuran),
                Text(l10n.tabGuidance),
                Text(l10n.tabTools),
              ],
            );
          },
        ),
      ),
    );
  }
}

void main() {
  testWidgets('app builds with ProviderScope and shows all 5 tab labels',
      (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: _TestApp()),
    );
    await tester.pump(); // allow localisation to resolve

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Prayers'), findsOneWidget);
    expect(find.text('Quran'), findsOneWidget);
    expect(find.text('Guidance'), findsOneWidget);
    expect(find.text('Tools'), findsOneWidget);
  });
}
