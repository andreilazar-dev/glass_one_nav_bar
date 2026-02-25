import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glass_one_nav_bar/glass_one_nav_bar.dart';

void main() {
  group('GlassOneNavItem Unit Tests', () {
    test('Constructor assigns values correctly', () {
      const item = GlassOneNavItem(
        icon: Icons.home,
        activeIcon: Icons.home_filled,
        label: 'Home',
      );

      expect(item.icon, Icons.home);
      expect(item.activeIcon, Icons.home_filled);
      expect(item.label, 'Home');
    });
  });

  group('GlassOneStyle Unit Tests', () {
    test('Default values are correct', () {
      const style = GlassOneStyle();
      expect(style.height, 72.0);
      expect(style.borderRadius, 28.0);
      expect(style.blurSigma, 10.0);
      expect(style.enableHaptics, true);
      expect(style.itemPadding,
          const EdgeInsets.symmetric(vertical: 8, horizontal: 8));
      expect(style.borderWidth, 0.4);
      expect(style.iconSize, 24.0);
      expect(style.showLabels, true);
    });

    test('Custom values are correctly assigned', () {
      const style = GlassOneStyle(
        height: 80.0,
        borderRadius: 20.0,
        blurSigma: 5.0,
        enableHaptics: false,
        itemPadding: EdgeInsets.all(10),
        borderWidth: 1.0,
        iconSize: 30.0,
        showLabels: false,
      );
      expect(style.height, 80.0);
      expect(style.borderRadius, 20.0);
      expect(style.blurSigma, 5.0);
      expect(style.enableHaptics, false);
      expect(style.itemPadding, const EdgeInsets.all(10));
      expect(style.borderWidth, 1.0);
      expect(style.iconSize, 30.0);
      expect(style.showLabels, false);
    });
  });

  group('GlassOneNavBar Widget Tests', () {
    const items = [
      GlassOneNavItem(icon: Icons.home, activeIcon: Icons.home, label: 'Home'),
      GlassOneNavItem(
          icon: Icons.search, activeIcon: Icons.search, label: 'Search'),
      GlassOneNavItem(
          icon: Icons.person, activeIcon: Icons.person, label: 'Profile'),
    ];

    testWidgets('Renders all items with labels', (WidgetTester tester) async {
      int tappedIndex = -1;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: GlassOneNavBar(
              items: items,
              currentIndex: 0,
              onTap: (index) => tappedIndex = index,
            ),
          ),
        ),
      );

      // Verify icons are present
      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);

      // Verify labels are present
      expect(find.text('Home'), findsWidgets); // Might find Tooltip and Text
      expect(find.text('Search'), findsWidgets);
      expect(find.text('Profile'), findsWidgets);

      // Verify first item is selected (bold check is hard, but we can check if it exists)
      expect(find.text('Home'), findsWidgets);

      // Test tap
      await tester.tap(find.text('Search').first);
      expect(tappedIndex, 1);
    });

    testWidgets('Does not render labels when showLabels is false',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: GlassOneNavBar(
              items: items,
              currentIndex: 0,
              onTap: (_) {},
              style: const GlassOneStyle(showLabels: false),
            ),
          ),
        ),
      );

      // Icons should still be there
      expect(find.byIcon(Icons.home), findsOneWidget);

      // Text should NOT be found as a Text widget (it will still be in Tooltip message, but Tooltip doesn't render it as a Text child)
      // Actually, Tooltip message is just a string, it doesn't render a Text widget until long pressed.
      // However, we added a Tooltip wrapper. The Text widget itself is conditional:
      // if (widget.style.showLabels) ...

      expect(find.byType(Text), findsNothing);
    });

    testWidgets('Accessibility labels are present',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: GlassOneNavBar(
              items: items,
              currentIndex: 0,
              onTap: (_) {},
            ),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.text('Home').first);
      expect(semantics.getSemanticsData().label, 'Home');
      expect(
          semantics
              .getSemanticsData()
              .flagsCollection
              .isSelected
              .toBoolOrNull(),
          isTrue);

      final searchSemantics = tester.getSemantics(find.text('Search').first);
      expect(searchSemantics.getSemanticsData().label, 'Search');
      expect(
          searchSemantics
              .getSemanticsData()
              .flagsCollection
              .isSelected
              .toBoolOrNull(),
          isFalse);
    });

    testWidgets('Selection logic works correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: GlassOneNavBar(
              items: items,
              currentIndex: 1, // Search selected
              onTap: (_) {},
            ),
          ),
        ),
      );

      final searchSemantics = tester.getSemantics(find.text('Search').first);
      expect(
          searchSemantics
              .getSemanticsData()
              .flagsCollection
              .isSelected
              .toBoolOrNull(),
          isTrue);

      final homeSemantics = tester.getSemantics(find.text('Home').first);
      expect(
          homeSemantics
              .getSemanticsData()
              .flagsCollection
              .isSelected
              .toBoolOrNull(),
          isFalse);
    });

    testWidgets('Custom colors and styles are applied',
        (WidgetTester tester) async {
      const activeColor = Colors.red;
      const inactiveColor = Colors.blue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: GlassOneNavBar(
              items: items,
              currentIndex: 0,
              onTap: (_) {},
              style: const GlassOneStyle(
                activeColor: activeColor,
                inactiveColor: inactiveColor,
                iconSize: 32.0,
              ),
            ),
          ),
        ),
      );

      final homeIcon = tester.widget<Icon>(find.byIcon(Icons.home));
      expect(homeIcon.color, activeColor);
      expect(homeIcon.size, 32.0);

      final searchIcon = tester.widget<Icon>(find.byIcon(Icons.search));
      expect(searchIcon.color, inactiveColor);
    });
  });
}
