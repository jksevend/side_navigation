import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:side_navigation/api/side_navigation_bar.dart';
import 'package:side_navigation/api/side_navigation_bar_header.dart';

import 'package:side_navigation/side_navigation.dart';

void main() {
  testWidgets(
      'SideNavigationBar displays its items correctly. No extra item color passed, using default one',
      (widgetTester) async {
    // Define initial index and views
    int selectedIndex = 0;
    List<Widget> views = const [
      Expanded(
        child: Center(
          child: Text('Dashboard view'),
        ),
      )
    ];
    // Given bar
    SideNavigationBar sideNavigationBar = SideNavigationBar(
        header: const SideNavigationBarHeader(
          leading: Icon(Icons.person),
          title: Text('Max Mustermann'),
        ),
        selectedIndex: selectedIndex,
        items: const [
          SideNavigationBarItem(icon: Icons.dashboard, label: 'Dashboard')
        ],
        onTap: (index) {
          selectedIndex = index;
        });

    // App context
    MaterialApp app = MaterialApp(
      home: Scaffold(
        body: Row(
          children: [sideNavigationBar, views.elementAt(selectedIndex)],
        ),
      ),
    );

    await widgetTester.pumpWidget(app);
    expect(find.byType(SideNavigationBar), findsOneWidget);
    expect(find.byIcon(Icons.dashboard), findsOneWidget);
    expect(
        (widgetTester.firstWidget(find.byIcon(Icons.dashboard)) as Icon).color,
        Colors.blue[200]);
    expect(find.byType(ListTile), findsWidgets);
  });

  testWidgets(
      'SideNavigationBar displays its items correctly. Extra item color passed.',
      (widgetTester) async {
    // Define initial index and views
    int selectedIndex = 0;
    List<Widget> views = const [
      Expanded(
        child: Center(
          child: Text('Dashboard view'),
        ),
      )
    ];
    // Given bar
    SideNavigationBar sideNavigationBar = SideNavigationBar(
      header: const SideNavigationBarHeader(
        leading: Icon(Icons.person),
        title: Text('Max Mustermann'),
      ),
      selectedIndex: selectedIndex,
      items: const [
        SideNavigationBarItem(icon: Icons.dashboard, label: 'Dashboard')
      ],
      onTap: (index) {
        selectedIndex = index;
      },
      selectedItemColor: Colors.pink,
    );

    // App context
    MaterialApp app = MaterialApp(
      home: Scaffold(
        body: Row(
          children: [sideNavigationBar, views.elementAt(selectedIndex)],
        ),
      ),
    );

    await widgetTester.pumpWidget(app);
    expect(find.byType(SideNavigationBar), findsOneWidget);
    expect(find.byIcon(Icons.dashboard), findsOneWidget);
    expect(
        (widgetTester.firstWidget(find.byIcon(Icons.dashboard)) as Icon).color,
        Colors.pink);
    expect(find.byType(ListTile), findsWidgets);
  });

  testWidgets(
      'SideNavigationBar changes the index of the selected tile when the onTap is performed',
      (widgetTester) async {
    // Define initial index and views
    int selectedIndex = 0;
    List<Widget> views = const [
      Expanded(
        child: Center(
          child: Text('Dashboard view'),
        ),
      ),
      Expanded(
        child: Center(
          child: Text('Account view'),
        ),
      )
    ];
    // Given bar
    SideNavigationBar sideNavigationBar = SideNavigationBar(
        header: const SideNavigationBarHeader(
          leading: Icon(Icons.person),
          title: Text('Max Mustermann'),
        ),
        selectedIndex: selectedIndex,
        items: const [
          SideNavigationBarItem(icon: Icons.dashboard, label: 'Dashboard'),
          SideNavigationBarItem(icon: Icons.person, label: 'Account')
        ],
        onTap: (index) {
          selectedIndex = index;
        });

    // App context
    MaterialApp app = MaterialApp(
      home: Scaffold(
        body: Row(
          children: [sideNavigationBar, views.elementAt(selectedIndex)],
        ),
      ),
    );

    await widgetTester.pumpWidget(app);
    await widgetTester.tap(find.widgetWithText(ListTile, 'Account'));

    expect(selectedIndex, 1);

    await widgetTester.pump();
    expect(find.widgetWithText(Center, 'Dashboard view'), findsOneWidget);
  });

  testWidgets('Collapsing the bar changes its width.', (widgetTester) async {
    // Define initial index and views
    int selectedIndex = 0;
    List<Widget> views = const [
      Expanded(
        child: Center(
          child: Text('Dashboard view'),
        ),
      ),
      Expanded(
        child: Center(
          child: Text('Account view'),
        ),
      )
    ];
    // Given bar
    SideNavigationBar sideNavigationBar = SideNavigationBar(
        header: const SideNavigationBarHeader(
          leading: Icon(Icons.person),
          title: Text('Max Mustermann'),
        ),
        selectedIndex: selectedIndex,
        items: const [
          SideNavigationBarItem(icon: Icons.dashboard, label: 'Dashboard'),
          SideNavigationBarItem(icon: Icons.person, label: 'Account')
        ],
        onTap: (index) {
          selectedIndex = index;
        });

    // App context
    MaterialApp app = MaterialApp(
      home: Scaffold(
        body: Row(
          children: [sideNavigationBar, views.elementAt(selectedIndex)],
        ),
      ),
    );

    await widgetTester.pumpWidget(app);
    // Collapse the bar
    await widgetTester.tap(find.byIcon(Icons.arrow_left));
    await widgetTester.pump();
    await widgetTester.binding.delayed(const Duration(milliseconds: 350));
    await widgetTester.pump();
    // Width is always one higher
    expect(widgetTester.getSize(find.byType(Container).first).width, 51);
  });
}
