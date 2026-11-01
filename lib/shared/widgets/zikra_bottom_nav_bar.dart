import 'package:flutter/material.dart';

class ZikraNavItem {
  final String label;
  final IconData icon;

  const ZikraNavItem({required this.label, required this.icon});
}

class ZikraBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final List<ZikraNavItem> items;
  final ValueChanged<int> onDestinationSelected;

  const ZikraBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.items,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return ColoredBox(
      color: colors.surface,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(height: 1, color: colors.outlineVariant),
          NavigationBar(
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            indicatorColor: colors.primaryContainer,
            backgroundColor: colors.surface,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            destinations: items
                .map(
                  (item) => NavigationDestination(
                    icon: Icon(item.icon),
                    label: item.label,
                  ),
                )
                .toList(growable: false),
          ),
        ],
      ),
    );
  }
}
