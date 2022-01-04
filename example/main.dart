import 'package:flutter/material.dart';
import 'package:side_navigation/api/side_navigation_bar_footer.dart';
import 'package:side_navigation/api/side_navigation_bar_header.dart';
import 'package:side_navigation/side_navigation.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData.light(),
      home: const MainView(),
    ),
  );
}

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  /// Views to display
  List<Widget> views = const [
    Center(
      child: Text('Dashboard'),
    ),
    Center(
      child: Text('Account'),
    ),
    Center(
      child: Text('Settings'),
    ),
  ];

  /// The currently selected index of the bar
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// You can use an AppBar if you want to
      //appBar: AppBar(
      //  title: const Text('App'),
      //),

      // The row is needed to display the current view
      body: Row(
        children: [
          /// Pretty similar to the BottomNavigationBar!
          SideNavigationBar(
            selectedIndex: selectedIndex,
            header: SideNavigationBarHeader(
              image: const IconButton(
                onPressed: null,
                icon: Icon(Icons.person, size: 40),
              ),
              title: const Text('Max Mustermann'),
              subtitle: Row(
                children: const [
                  Text('Edit something'),
                  IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.edit,
                      size: 16,
                    ),
                  )
                ],
              ),
            ),
            footer: const SideNavigationBarFooter(
              label: Text('Footer label'),
            ),
            items: const [
              SideNavigationBarItem(
                icon: Icons.dashboard,
                label: 'Dashboard',
              ),
              SideNavigationBarItem(
                icon: Icons.person,
                label: 'Account',
              ),
              SideNavigationBarItem(
                icon: Icons.settings,
                label: 'Settings',
              ),
            ],
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),

          /// Make it take the rest of the available width
          Expanded(
            child: views.elementAt(selectedIndex),
          )
        ],
      ),
    );
  }
}
