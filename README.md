# Flutter Side Navigation
This package provides support to navigate on your app. It was inspired from both the ```BottomNavigationBar``` and ```Drawer```. You can think of it as an Drawer which is always open but on the right side of the screen. Kind of like a CEO dashboard web application.

## Getting started
First add the dependency into your ```pubspec.yaml```:
```
dependencies:
    side_navigation: ^0.0.1
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
return Scaffold(
    body: Row(
        children: [
            SideNavigationBar(
                selectedIndex: selectedIndex,
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
          Expanded(
            child: views.elementAt(selectedIndex),
          )
        ],
    ),
);
```

Check the image to see the result of this on a desktop application

![image info](img/desktop_example.png)


## Future Updates
Currently the plan is to add support for
* Making the ```SideNavigationBar``` expandable
* Adding a header component when building the bar
* Adding more style customizations
* Maybe choose the position of the bar. Either right or left?

## Bugs, Errors etc.
If you find any weird behaviour, bugs or errors please let me know.
Also an image or a gif will help a lot if the UI behaves differently.