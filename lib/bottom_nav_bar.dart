import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users_model/providers/app_provider.dart';
import 'package:users_model/screens/hive_crud_screen/hive_crud_screen.dart';
import 'package:users_model/screens/post_screen/post_screen.dart';
import 'package:users_model/screens/user_screen/user_screen.dart';

//! Defining BottomNavBar widget
class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavBarState createState() => _BottomNavBarState();
}

//! State class for BottomNavBar widget
class _BottomNavBarState extends State<BottomNavBar> {
  List<Widget> navChildren = [];

  @override
  void initState() {
    super.initState();

    //! Initializing navigation children with UserScreen and PostScreen
    navChildren = [
      const UserScreen(),
      const PostScreen(),
      const HiveCrudScreen(),
    ];
  }

  //! Method to handle navigation taps
  void navTap(index) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    // setState(() {
    appProvider.setCurrentNavIndex = index;
    // showNavbar = true;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
        //! Using Consumer to rebuild parts of the UI
        builder: (context, appProvider, child) {
      return Scaffold(
          // body: showNavbar ? navChildren[currentNavIndex] : Container(),
          body: IndexedStack(
            index: appProvider.getCurrentNavIndex,
            children: const [
              UserScreen(),
              PostScreen(),
              HiveCrudScreen(),
            ],
          ),
          // body: navChildren[currentNavIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color.fromARGB(255, 218, 120, 54),
            selectedItemColor: Colors.white,
            selectedLabelStyle: const TextStyle(fontSize: 0),
            unselectedLabelStyle: const TextStyle(fontSize: 0),
            currentIndex: appProvider.getCurrentNavIndex,
            onTap: navTap,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'User'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.post_add), label: 'Post'),
                  BottomNavigationBarItem(
                  icon: Icon(Icons.hive), label: 'Hive'),
            ],
          ));
    });
  }
}
