import 'package:flutter/material.dart';
import 'main.dart';

class CustomAppBar extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomBarItems = [];
  CustomAppBar(){
      bottomBarItems.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.home,
          color: appTheme.primaryColor,
        ),
        icon: Icon(Icons.home, color: Colors.black,),
        title: Text("Home", style: TextStyle(color: Colors.black),),
      ));

          bottomBarItems.add(BottomNavigationBarItem(
          icon: Icon(Icons.favorite, color: Colors.black,),
    title: Text("Explore", style: TextStyle(color: Colors.black),),
    ));

    bottomBarItems.add(BottomNavigationBarItem(
    icon: Icon(Icons.camera, color: Colors.black,),
    title: Text("Camera", style: TextStyle(color: Colors.black),),
    ));

    bottomBarItems.add(BottomNavigationBarItem(
    icon: Icon(Icons.notifications, color: Colors.black,),
    title: Text("Notification", style: TextStyle(color: Colors.black),),
    ));

  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10.0,
      child: BottomNavigationBar(
        items: bottomBarItems,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
