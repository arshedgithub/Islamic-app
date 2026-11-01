import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../app/routes.dart';
import '../features/quran/presentation/quran_screen.dart';
import 'services/location_cache_service.dart';
import '../shared/widgets/zikra_bottom_nav_bar.dart';
import '../shared/widgets/app_side_menu_drawer.dart';
import '../shared/widgets/home_hijri_location_card.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  static const List<ZikraNavItem> _tabs = [
    ZikraNavItem(label: 'Home', icon: Icons.home_rounded),
    ZikraNavItem(label: 'Prayers', icon: Icons.mosque_rounded),
    ZikraNavItem(label: 'Quran', icon: Icons.menu_book_rounded),
    ZikraNavItem(label: 'Guidance', icon: Icons.tips_and_updates_rounded),
    ZikraNavItem(label: 'Tools', icon: Icons.widgets_rounded),
  ];

  @override
  void initState() {
    super.initState();
    unawaited(LocationCacheService.instance.warmUp());
  }

  List<Widget> _buildPages() {
    return [
      _SectionPage(
        entries: const [
          _EntryData(
            'Prayer times',
            'Prayer times coming soon',
            Icons.access_time_filled_rounded,
          ),
          _EntryData(
            'Reminders',
            'Coming soon',
            Icons.notifications_active_rounded,
          ),
        ],
        topWidget: const HomeHijriLocationCard(),
        onEntryTap: _onEntryTap,
      ),
      _PrayersTabContent(
        topWidget: const HomeHijriLocationCard(),
        onOpenQibla: () => context.push(Routes.qibla),
        onOpenMosques: () => context.push(Routes.nearbyMosques),
      ),
      const QuranScreen(),
      _SectionPage(
        entries: [
          _EntryData('Duas', 'Curated daily duas', Icons.favorite_rounded),
          _EntryData(
            'Adhkar',
            'Morning and evening adhkar',
            Icons.menu_book_rounded,
          ),
          _EntryData(
            'Tasbih',
            'Digital tasbih counter',
            Icons.radio_button_checked_rounded,
          ),
          _EntryData(
            'Fasting',
            'Track fasting days',
            Icons.nights_stay_rounded,
          ),
          _EntryData(
            'Sadaqah',
            'Manage charity intentions',
            Icons.volunteer_activism_rounded,
          ),
          _EntryData(
            'Reflections',
            'Short spiritual reflections',
            Icons.lightbulb_rounded,
          ),
          _EntryData(
            'Learning',
            'Bite-sized Islamic lessons',
            Icons.school_rounded,
          ),
        ],
        onEntryTap: _onEntryTap,
      ),
      _SectionPage(
        entries: [
          _EntryData(
            'Hijri Calendar',
            'Check Hijri dates',
            Icons.calendar_month_rounded,
            action: _EntryAction.openHijriCalendar,
          ),
          _EntryData(
            'Qibla',
            'Find the Qibla direction',
            Icons.explore_rounded,
            action: _EntryAction.openQibla,
          ),
          _EntryData(
            'Zakat Calculator',
            'Estimate zakat quickly',
            Icons.calculate_rounded,
          ),
        ],
        onEntryTap: _onEntryTap,
      ),
    ];
  }

  void _onEntryTap(_EntryData entry) {
    switch (entry.action) {
      case _EntryAction.openHijriCalendar:
        context.push(Routes.hijriCalendar);
        break;
      case _EntryAction.openQibla:
        context.push(Routes.qibla);
        break;
      case null:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppSideMenuDrawer(
        onItemSelected: (itemTitle) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('$itemTitle coming soon')));
        },
      ),
      appBar: AppBar(
        title: Text(_tabs[_selectedIndex].label),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_rounded),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications coming soon')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle_rounded),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile coming soon')),
              );
            },
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: _buildPages()[_selectedIndex],
      bottomNavigationBar: ZikraBottomNavBar(
        selectedIndex: _selectedIndex,
        items: _tabs,
        onDestinationSelected: (int index) =>
            setState(() => _selectedIndex = index),
      ),
    );
  }
}

class _PrayersTabContent extends StatelessWidget {
  final Widget? topWidget;
  final VoidCallback onOpenQibla;
  final VoidCallback onOpenMosques;

  const _PrayersTabContent({
    this.topWidget,
    required this.onOpenQibla,
    required this.onOpenMosques,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (topWidget case final widget?) ...[
          const SizedBox(height: 2),
          widget,
        ],
        Card(
          elevation: 0,
          color: colors.tertiaryContainer.withValues(alpha: 0.30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(color: colors.outlineVariant),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 24),
            child: Row(
              children: [
                Icon(
                  Icons.access_time_filled_rounded,
                  color: colors.onTertiaryContainer,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  'Prayer times coming soon',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colors.onTertiaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: onOpenQibla,
                icon: const Icon(Icons.explore_rounded),
                label: const Text('Find Qibla'),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onOpenMosques,
                icon: const Icon(Icons.location_city_rounded),
                label: const Text('Mosques near me'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}


class _SectionPage extends StatelessWidget {
  final List<_EntryData> entries;
  final Widget? topWidget;
  final ValueChanged<_EntryData>? onEntryTap;

  const _SectionPage({required this.entries, this.topWidget, this.onEntryTap});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (topWidget case final widget?) ...[
          const SizedBox(height: 2),
          widget,
        ],
        ...entries.map((entry) {
          final iconBackground = colors.surface;
          final iconColor = colors.primaryFixed;

          return Card(
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 10),
            color: colors.tertiaryContainer.withValues(alpha: 0.30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: BorderSide(color: colors.outlineVariant),
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 18,
                backgroundColor: iconBackground,
                child: Icon(entry.icon, color: iconColor),
              ),
              title: Text(entry.title),
              subtitle: Text(entry.subtitle),
              trailing: Icon(
                Icons.chevron_right_rounded,
                color: colors.secondary,
              ),
              onTap: () => onEntryTap?.call(entry),
            ),
          );
        }),
      ],
    );
  }
}

class _EntryData {
  final String title;
  final String subtitle;
  final IconData icon;
  final _EntryAction? action;

  const _EntryData(this.title, this.subtitle, this.icon, {this.action});
}

enum _EntryAction { openHijriCalendar, openQibla }
