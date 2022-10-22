import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:side_navigation/side_navigation.dart';

void main() {
  group('Structural tests', () {
    testWidgets('Plain bar without header or footer',
        (WidgetTester tester) async {
      List<Widget> views = const [
        Center(
          child: Text('Dashboard page'),
        ),
        Center(
          child: Text('Profile page'),
        )
      ];
      int selectedIndex = 0;
      String startText = 'Dashboard';
      String endText = 'Profile';
      MaterialApp materialApp = MaterialApp(
        // Allow setting of state for tests
        home: StatefulBuilder(builder: (context, setState) {
          return Scaffold(
            body: Row(
              children: [
                SideNavigationBar(
                    selectedIndex: selectedIndex,
                    items: <SideNavigationBarItem>[
                      SideNavigationBarItem(
                          icon: Icons.dashboard, label: startText),
                      SideNavigationBarItem(icon: Icons.person, label: endText)
                    ],
                    onTap: (newIndex) {
                      setState(() {
                        selectedIndex = newIndex;
                      });
                    }),
                Expanded(child: views.elementAt(selectedIndex))
              ],
            ),
          );
        }),
      );

      await tester.pumpWidget(materialApp);

      // Check initial state
      expect(find.text(startText), findsOneWidget);
      expect(find.byIcon(Icons.dashboard), findsOneWidget);
      expect(find.text('Dashboard page'), findsOneWidget);
    });

    testWidgets('Bar with header', (WidgetTester tester) async {
      List<Widget> views = const [
        Center(
          child: Text('Dashboard page'),
        ),
        Center(
          child: Text('Profile page'),
        )
      ];
      int selectedIndex = 0;
      String titleText = 'Title';
      String subtitleText = 'Subtitle';
      MaterialApp materialApp = MaterialApp(
        // Allow setting of state for tests
        home: StatefulBuilder(builder: (context, setState) {
          return Scaffold(
            body: Row(
              children: [
                SideNavigationBar(
                    header: SideNavigationBarHeader(
                      image: const CircleAvatar(
                        child: Icon(Icons.account_balance),
                      ),
                      title: Text(titleText),
                      subtitle: Text(subtitleText),
                    ),
                    selectedIndex: selectedIndex,
                    items: const <SideNavigationBarItem>[
                      SideNavigationBarItem(
                          icon: Icons.dashboard, label: 'Dashboard'),
                      SideNavigationBarItem(icon: Icons.person, label: 'Person')
                    ],
                    onTap: (newIndex) {
                      setState(() {
                        selectedIndex = newIndex;
                      });
                    }),
                Expanded(child: views.elementAt(selectedIndex))
              ],
            ),
          );
        }),
      );

      await tester.pumpWidget(materialApp);

      // Check Header data
      expect(find.text(titleText), findsOneWidget);
      expect(find.text(subtitleText), findsOneWidget);
      expect(find.byIcon(Icons.account_balance), findsOneWidget);
    });

    testWidgets('Bar with header and footer', (WidgetTester tester) async {
      List<Widget> views = const [
        Center(
          child: Text('Dashboard page'),
        ),
        Center(
          child: Text('Profile page'),
        )
      ];
      int selectedIndex = 0;
      String footerText = 'Label';
      MaterialApp materialApp = MaterialApp(
        // Allow setting of state for tests
        home: StatefulBuilder(builder: (context, setState) {
          return Scaffold(
            body: Row(
              children: [
                SideNavigationBar(
                    header: const SideNavigationBarHeader(
                      image: CircleAvatar(
                        child: Icon(Icons.account_balance),
                      ),
                      title: Text('Title'),
                      subtitle: Text('Subtitle'),
                    ),
                    footer: SideNavigationBarFooter(label: Text(footerText)),
                    selectedIndex: selectedIndex,
                    items: const <SideNavigationBarItem>[
                      SideNavigationBarItem(
                          icon: Icons.dashboard, label: 'Dashboard'),
                      SideNavigationBarItem(icon: Icons.person, label: 'Person')
                    ],
                    onTap: (newIndex) {
                      setState(() {
                        selectedIndex = newIndex;
                      });
                    }),
                Expanded(child: views.elementAt(selectedIndex))
              ],
            ),
          );
        }),
      );

      await tester.pumpWidget(materialApp);

      // Check Footer data
      expect(find.text(footerText), findsOneWidget);
      expect(find.byIcon(Icons.account_balance), findsOneWidget);
    });
  });

  group('State tests', () {
    testWidgets('Tapping an item displays page', (WidgetTester tester) async {
      List<Widget> views = const [
        Center(
          child: Text('Dashboard page'),
        ),
        Center(
          child: Text('Profile page'),
        )
      ];
      int selectedIndex = 0;
      String startText = 'Dashboard';
      String endText = 'Profile';
      MaterialApp materialApp = MaterialApp(
        // Allow setting of state for tests
        home: StatefulBuilder(builder: (context, setState) {
          return Scaffold(
            body: Row(
              children: [
                SideNavigationBar(
                    selectedIndex: selectedIndex,
                    items: <SideNavigationBarItem>[
                      SideNavigationBarItem(
                          icon: Icons.dashboard, label: startText),
                      SideNavigationBarItem(icon: Icons.person, label: endText)
                    ],
                    onTap: (newIndex) {
                      setState(() {
                        selectedIndex = newIndex;
                      });
                    }),
                Expanded(child: views.elementAt(selectedIndex))
              ],
            ),
          );
        }),
      );

      await tester.pumpWidget(materialApp);

      // Check initial state
      expect(find.text(startText), findsOneWidget);
      expect(find.byIcon(Icons.dashboard), findsOneWidget);
      expect(find.text('Dashboard page'), findsOneWidget);

      await tester.tap(find.widgetWithText(ListTile, endText));
      await tester.pumpAndSettle();

      expect(find.text('Dashboard page'), findsNothing);
      expect(find.text('Profile page'), findsOneWidget);
    });

    testWidgets('Toggling the bar changes state', (WidgetTester tester) async {
      List<Widget> views = const [
        Center(
          child: Text('Dashboard page'),
        ),
        Center(
          child: Text('Profile page'),
        )
      ];
      int selectedIndex = 0;
      String startText = 'Dashboard';
      String endText = 'Profile';
      MaterialApp materialApp = MaterialApp(
        // Allow setting of state for tests
        home: StatefulBuilder(builder: (context, setState) {
          return Scaffold(
            body: Row(
              children: [
                SideNavigationBar(
                    selectedIndex: selectedIndex,
                    items: <SideNavigationBarItem>[
                      SideNavigationBarItem(
                          icon: Icons.dashboard, label: startText),
                      SideNavigationBarItem(icon: Icons.person, label: endText)
                    ],
                    onTap: (newIndex) {
                      setState(() {
                        selectedIndex = newIndex;
                      });
                    }),
                Expanded(child: views.elementAt(selectedIndex))
              ],
            ),
          );
        }),
      );

      await tester.pumpWidget(materialApp);

      // Check initial state
      expect(find.text(startText), findsOneWidget);
      expect(find.byIcon(Icons.dashboard), findsOneWidget);
      expect(find.text('Dashboard page'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.arrow_left));
      await tester.pumpAndSettle();

      expect(find.widgetWithText(ListTile, startText), findsNothing);
      expect(find.widgetWithIcon(IconButton, Icons.dashboard), findsOneWidget);
    });
  });

  group('Style tests', () {
    testWidgets('Passing custom background color', (WidgetTester tester) async {
      List<Widget> views = const [
        Center(
          child: Text('Dashboard page'),
        ),
        Center(
          child: Text('Profile page'),
        )
      ];
      int selectedIndex = 0;
      Color expectedColor = Colors.grey;
      MaterialApp materialApp = MaterialApp(
        // Allow setting of state for tests
        home: StatefulBuilder(builder: (context, setState) {
          return Scaffold(
            body: Row(
              children: [
                SideNavigationBar(
                  selectedIndex: selectedIndex,
                  items: const <SideNavigationBarItem>[
                    SideNavigationBarItem(
                        icon: Icons.dashboard, label: 'Dashboard'),
                    SideNavigationBarItem(icon: Icons.person, label: 'Profile')
                  ],
                  onTap: (newIndex) {
                    setState(() {
                      selectedIndex = newIndex;
                    });
                  },
                  theme: SideNavigationBarTheme(
                      backgroundColor: expectedColor,
                      itemTheme: SideNavigationBarItemTheme.standard(),
                      togglerTheme: SideNavigationBarTogglerTheme.standard(),
                      dividerTheme: SideNavigationBarDividerTheme.standard()),
                ),
                Expanded(child: views.elementAt(selectedIndex))
              ],
            ),
          );
        }),
      );

      await tester.pumpWidget(materialApp);

      expect(
          ((tester.widget(find.byType(Container).at(0)) as Container).decoration
                  as BoxDecoration)
              .color,
          expectedColor);
    });

    testWidgets('Passing custom item theme', (WidgetTester tester) async {
      List<Widget> views = const [
        Center(
          child: Text('Dashboard page'),
        ),
        Center(
          child: Text('Profile page'),
        )
      ];
      int selectedIndex = 0;
      double exIconSize = 32.5;
      double exFontSize = 20.0;
      Color exUnselectedColor = Colors.black;
      Color exSelectedColor = Colors.yellow;
      MaterialApp materialApp = MaterialApp(
        // Allow setting of state for tests
        home: StatefulBuilder(builder: (context, setState) {
          return Scaffold(
            body: Row(
              children: [
                SideNavigationBar(
                  selectedIndex: selectedIndex,
                  items: const <SideNavigationBarItem>[
                    SideNavigationBarItem(
                        icon: Icons.dashboard, label: 'Dashboard'),
                    SideNavigationBarItem(icon: Icons.person, label: 'Profile')
                  ],
                  onTap: (newIndex) {
                    setState(() {
                      selectedIndex = newIndex;
                    });
                  },
                  theme: SideNavigationBarTheme(
                    itemTheme: SideNavigationBarItemTheme(
                        unselectedItemColor: exUnselectedColor,
                        selectedItemColor: exSelectedColor,
                        iconSize: exIconSize,
                        labelTextStyle: TextStyle(
                          fontSize: exFontSize,
                        )),
                    togglerTheme: SideNavigationBarTogglerTheme.standard(),
                    dividerTheme: SideNavigationBarDividerTheme.standard(),
                  ),
                ),
                Expanded(child: views.elementAt(selectedIndex))
              ],
            ),
          );
        }),
      );

      await tester.pumpWidget(materialApp);

      // Checking passed colors and sizes
      expect(
          ((tester.widget(find.widgetWithText(ListTile, 'Dashboard'))
                      as ListTile)
                  .title as Text)
              .style
              ?.color,
          exSelectedColor);
      expect(
          ((tester.widget(find.widgetWithText(ListTile, 'Dashboard'))
                      as ListTile)
                  .title as Text)
              .style
              ?.fontSize,
          exFontSize);
      expect(
          ((tester.widget(find.widgetWithText(ListTile, 'Dashboard'))
                      as ListTile)
                  .leading as Icon)
              .size,
          exIconSize);
      expect(
          ((tester.widget(find.widgetWithText(ListTile, 'Profile')) as ListTile)
                  .title as Text)
              .style
              ?.color,
          exUnselectedColor);
      expect(
          ((tester.widget(find.widgetWithText(ListTile, 'Profile')) as ListTile)
                  .title as Text)
              .style
              ?.fontSize,
          exFontSize);
      expect(
          ((tester.widget(find.widgetWithText(ListTile, 'Profile')) as ListTile)
                  .leading as Icon)
              .size,
          exIconSize);
    });

    testWidgets(
        'Passing custom item theme - custom text style color gets overridden',
        (WidgetTester tester) async {
      List<Widget> views = const [
        Center(
          child: Text('Dashboard page'),
        ),
        Center(
          child: Text('Profile page'),
        )
      ];
      int selectedIndex = 0;
      MaterialApp materialApp = MaterialApp(
        // Allow setting of state for tests
        home: StatefulBuilder(builder: (context, setState) {
          return Scaffold(
            body: Row(
              children: [
                SideNavigationBar(
                  selectedIndex: selectedIndex,
                  items: const <SideNavigationBarItem>[
                    SideNavigationBarItem(
                        icon: Icons.dashboard, label: 'Dashboard'),
                    SideNavigationBarItem(icon: Icons.person, label: 'Profile')
                  ],
                  onTap: (newIndex) {
                    setState(() {
                      selectedIndex = newIndex;
                    });
                  },
                  theme: SideNavigationBarTheme(
                    itemTheme: SideNavigationBarItemTheme(
                        labelTextStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                    )),
                    togglerTheme: SideNavigationBarTogglerTheme.standard(),
                    dividerTheme: SideNavigationBarDividerTheme.standard(),
                  ),
                ),
                Expanded(child: views.elementAt(selectedIndex))
              ],
            ),
          );
        }),
      );

      await tester.pumpWidget(materialApp);

      expect(
          ((tester.widget(find.widgetWithText(ListTile, 'Dashboard'))
                      as ListTile)
                  .title as Text)
              .style
              ?.color,
          isNot(equals(Colors.red)));
      expect(
          ((tester.widget(find.widgetWithText(ListTile, 'Profile')) as ListTile)
                  .title as Text)
              .style
              ?.color,
          isNot(equals(Colors.red)));
    });

    testWidgets('Passing custom toggler theme', (WidgetTester tester) async {
      List<Widget> views = const [
        Center(
          child: Text('Dashboard page'),
        ),
        Center(
          child: Text('Profile page'),
        )
      ];
      int selectedIndex = 0;
      Color exExpandColor = Colors.red;
      Color exShrinkColor = Colors.yellow;
      MaterialApp materialApp = MaterialApp(
        // Allow setting of state for tests
        home: StatefulBuilder(builder: (context, setState) {
          return Scaffold(
            body: Row(
              children: [
                SideNavigationBar(
                  selectedIndex: selectedIndex,
                  items: const <SideNavigationBarItem>[
                    SideNavigationBarItem(
                        icon: Icons.dashboard, label: 'Dashboard'),
                    SideNavigationBarItem(icon: Icons.person, label: 'Profile')
                  ],
                  onTap: (newIndex) {
                    setState(() {
                      selectedIndex = newIndex;
                    });
                  },
                  theme: SideNavigationBarTheme(
                    itemTheme: SideNavigationBarItemTheme.standard(),
                    togglerTheme: SideNavigationBarTogglerTheme(
                      expandIconColor: exExpandColor,
                      shrinkIconColor: exShrinkColor,
                    ),
                    dividerTheme: SideNavigationBarDividerTheme.standard(),
                  ),
                ),
                Expanded(child: views.elementAt(selectedIndex))
              ],
            ),
          );
        }),
      );

      await tester.pumpWidget(materialApp);

      // Check shrinkIcon
      expect((tester.widget(find.byIcon(Icons.arrow_left)) as Icon).color,
          exShrinkColor);

      // Collapse
      await tester.tap(find.widgetWithIcon(IconButton, Icons.arrow_left));
      await tester.pumpAndSettle();

      // Check expandIcon
      expect((tester.widget(find.byIcon(Icons.arrow_right)) as Icon).color,
          exExpandColor);
    });

    testWidgets('Passing custom divider theme', (WidgetTester tester) async {
      List<Widget> views = const [
        Center(
          child: Text('Dashboard page'),
        ),
        Center(
          child: Text('Profile page'),
        )
      ];
      int selectedIndex = 0;
      MaterialApp materialApp = MaterialApp(
        // Allow setting of state for tests
        home: StatefulBuilder(builder: (context, setState) {
          return Scaffold(
            body: Row(
              children: [
                SideNavigationBar(
                  selectedIndex: selectedIndex,
                  items: const <SideNavigationBarItem>[
                    SideNavigationBarItem(
                        icon: Icons.dashboard, label: 'Dashboard'),
                    SideNavigationBarItem(icon: Icons.person, label: 'Profile')
                  ],
                  onTap: (newIndex) {
                    setState(() {
                      selectedIndex = newIndex;
                    });
                  },
                  theme: SideNavigationBarTheme(
                    itemTheme: SideNavigationBarItemTheme.standard(),
                    togglerTheme: SideNavigationBarTogglerTheme.standard(),
                    dividerTheme: const SideNavigationBarDividerTheme(
                      showFooterDivider: true,
                      showHeaderDivider: true,
                      showMainDivider: true,
                      footerDividerColor: Colors.red,
                      footerDividerThickness: 2,
                      mainDividerColor: Colors.orange,
                      mainDividerThickness: 3,
                      headerDividerColor: Colors.green,
                      headerDividerThickness: 4,
                    ),
                  ),
                ),
                Expanded(child: views.elementAt(selectedIndex))
              ],
            ),
          );
        }),
      );

      await tester.pumpWidget(materialApp);

      expect(
          ((((tester.widget(find.byType(Container).at(0)) as Container)
                          .decoration as BoxDecoration)
                      .border as Border)
                  .right)
              .color,
          Colors.orange);
    });
  });
}
