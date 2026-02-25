import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:glass_one_nav_bar/glass_one_nav_bar.dart';

class ScaffoldWithNavbar extends StatelessWidget {
  const ScaffoldWithNavbar({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.paddingOf(context).bottom;
    final double gradientHeight =
        bottomPadding + kBottomNavigationBarHeight + 20;

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          navigationShell,

          // Gradient to fade content behind navbar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: gradientHeight,
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Theme.of(context).scaffoldBackgroundColor,
                      Theme.of(context)
                          .scaffoldBackgroundColor
                          .withValues(alpha: 0.5),
                      Theme.of(context)
                          .scaffoldBackgroundColor
                          .withValues(alpha: 0.0),
                    ],
                    stops: const [0.0, 0.4, 0.7],
                  ),
                ),
              ),
            ),
          ),

          // Glass Navigation Bar
          Positioned(
            bottom: bottomPadding > 0 ? bottomPadding : 16,
            left: 0,
            right: 0,
            child: Center(
              child: GlassOneNavBar(
                currentIndex: navigationShell.currentIndex,
                onTap: _onTap,
                items: const [
                  GlassOneNavItem(
                    icon: Icons.dashboard_outlined,
                    activeIcon: Icons.dashboard_rounded,
                    label: 'Home',
                  ),
                  GlassOneNavItem(
                    icon: Icons.explore_outlined,
                    activeIcon: Icons.explore_rounded,
                    label: 'Explore',
                  ),
                  GlassOneNavItem(
                    icon: Icons.analytics_outlined,
                    activeIcon: Icons.analytics_rounded,
                    label: 'Analytics',
                  ),
                  // GlassOneNavItem(
                  //   icon: Icons.people_outline,
                  //   activeIcon: Icons.people_rounded,
                  //   label: 'Community',
                  // ),
                  GlassOneNavItem(
                    icon: Icons.settings_outlined,
                    activeIcon: Icons.settings_rounded,
                    label: 'Settings',
                  ),
                ],
                style: const GlassOneStyle(
                  height: kBottomNavigationBarHeight + 4,
                  blurSigma: 2,
                  itemPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  borderRadius: 32,
                  showLabels: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
