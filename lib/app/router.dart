import 'package:go_router/go_router.dart';

import '../core/main_shell.dart';
import '../features/qibla/presentation/qibla_screen.dart';
import '../features/hijri/presentation/hijri_calendar_screen.dart';
import '../features/mosques/presentation/nearby_mosques_screen.dart';
import '../shared/widgets/home_hijri_location_card.dart';
import 'routes.dart';

final appRouter = GoRouter(
  initialLocation: Routes.home,
  routes: [
    // The 5-tab shell — uses the existing MainShell for now.
    // Sprint 1 will replace MainShell with a proper StatefulShellRoute
    // so each tab has its own navigation stack.
    GoRoute(
      path: Routes.home,
      builder: (_, _) => const MainShell(),
    ),

    // Push routes opened from within tabs
    GoRoute(
      path: Routes.qibla,
      builder: (_, _) => const QiblaScreen(
        topWidget: HomeHijriLocationCard(),
      ),
    ),
    GoRoute(
      path: Routes.hijriCalendar,
      builder: (_, _) => const HijriCalendarScreen(),
    ),
    GoRoute(
      path: Routes.nearbyMosques,
      builder: (_, _) => const NearbyMosquesScreen(),
    ),
  ],
);
