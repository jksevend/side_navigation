# Flutter Side Navigation

This package provides support to navigate on your app. It was inspired from both the ```BottomNavigationBar``` and ```Drawer```. You can think of it as an Drawer which is always open but on the right side of the screen. Kind of like a CEO dashboard web application.


> **NOTE**: If you are looking for a Flutter implementation of this navigation approach check out `NavigationRail` which I recently stumbled upon after publishing this package.  
## Preview 

![Alt Text](https://media.giphy.com/media/YP458pCN80KKe5iWSI/giphy.gif)
## Getting started
First add the dependency into your ```pubspec.yaml```:
```
dependencies:
    side_navigation: ^0.0.4
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

**Desktop:**

Personally on Desktop I like it more without the ```AppBar```

<a href="https://ibb.co/X7dPyyJ"><img src="https://i.ibb.co/qN48001/desktop-example.png" alt="desktop-example" border="0"></a>

**Android Tablet:**

On the tablet on the other hand an AppBar blends right in!

<a href="https://ibb.co/nQFZcQx"><img src="https://i.ibb.co/vLSgPL0/tablet-example.png" alt="tablet-example" border="0"></a>

**Android Phone:**

For phones I would recommend only using this type of navigation when the device is in ```landscape``` mode. Since the content is displayed very small when in ```portrait```

<a href="https://ibb.co/QbLshyK"><img src="https://i.ibb.co/p0cCNYL/phone-example.png" alt="phone-example" border="0"></a>


## Future Updates
Currently the plan is to add support for

* Adding a header component when building the bar
* Adding more style customizations
* Maybe choose the position of the bar. Either right or left?

## Bugs, Errors etc.
If you find any weird behaviour, bugs or errors please let me know.
Also an image or a gif will help a lot if the UI behaves differently.