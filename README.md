# Flutter Side Navigation

This package provides support to navigate on your app. It was inspired from both the ```BottomNavigationBar``` and ```Drawer```. You can think of it as a drawer which is always open. Kind of like a CEO dashboard web application.


> **NOTE**: If you are looking for a Flutter implementation of this navigation approach check out `NavigationRail` which I recently stumbled upon after publishing this package.  
## Preview
![Side Navigation Bar Preview](https://media.giphy.com/media/1f9GQyybLR4N722oyU/giphy.gif)
## Getting started
First add the dependency into your ```pubspec.yaml```:
```
dependencies:
    side_navigation: ^0.0.6
```

**OR**
Add the dependency via terminal:
```
flutter pub add side_navigation
```

When making use of the package:
```
import 'package:side_navigation/side_navigation.dart';
```

## Usage
Right now it is recommended to wrap the ```SideNavigationBar``` in a ```Row``` and put an ```Expanded``` widget around the content to make it expand the rest of the available width. You can also use an ```AppBar``` within the Scaffold. 


Example:
```
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
```

**Desktop:**

Personally on Desktop I like it more without the ```AppBar```

<a href="https://ibb.co/3zVcrnQ"><img src="https://i.ibb.co/fvZH1sL/005-desktop.png" alt="005-desktop" border="0"></a>
**Android Tablet:**

On the tablet on the other hand an AppBar blends right in!

<a href="https://ibb.co/3MZQs9w"><img src="https://i.ibb.co/D82TbHN/005-tablet.png" alt="005-tablet" border="0"></a>
**Android Phone:**

For phones, I would recommend only using this type of navigation when the device is in ```landscape``` mode. Since the content is displayed very small when in ```portrait```

<a href="https://ibb.co/4SfG8QY"><img src="https://i.ibb.co/3FsqpJM/005-phone.png" alt="005-phone" border="0"></a>

## Future Updates
Currently, the plan is to add support for

* Adding a style component
* Choosable position of the toggler

## Bugs, Errors etc.
If you find any weird behaviour, bugs or errors please let me know.
Also, an image or a gif will help a lot if the UI behaves differently.