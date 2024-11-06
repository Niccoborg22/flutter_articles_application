import 'package:flutter/material.dart';
import '../_football_page.dart';
import '../_motorsport_page.dart';
import '../_other_sports_page.dart';
import '../_homepage.dart';


// NAVIGATION BAR + PAGE ROUTING
class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  var selectedIndex = 0;

  // PAGE RETURN FUNCTION
  Widget _getPage(int index) {
    if (index == 0) {
      return const HomePage();
    }
    if (index == 1) {
      return FootballPage();
    }
    if (index == 2) {
      return MotorsportPage();
    } else {
      return OtherSportsPage();
    }
  }

  // FUNCTION TO CHANGE PAGE INDEX
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  // COLOR CHANGE NAVIGATION RAIL
  Color getRailBackgroundColor(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return Colors.red; // Home
      case 1:
        return Colors.green; // Football
      case 2:
        return Colors.purple; // Motorsport
      case 3:
        return Colors.blue; // Other Sports
      default:
        return Colors.grey; // Default if index is out of bounds
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        // BOTTOM NAVIGATION BAR
        bottomNavigationBar: screenWidth < 600
            ? BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                    backgroundColor: Colors.red,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.sports_soccer),
                    label: 'Football',
                    backgroundColor: Colors.green,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.directions_car),
                    label: 'Motorsport',
                    backgroundColor: Colors.purple,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.sports),
                    label: 'Other Sports',
                    backgroundColor: Colors.blue,
                  ),
                ],
                currentIndex: selectedIndex,
                selectedItemColor: Colors.black,
                onTap: _onItemTapped,
              )
            : null,

        // PAGE SHOWN
        body: Row(
          children: [
            if (screenWidth >= 600)
              SafeArea(
                  child: NavigationRail(
                      backgroundColor: getRailBackgroundColor(selectedIndex),
                      extended: screenWidth > 900,
                      selectedIconTheme: const IconThemeData(
                        color: Colors.black,
                        size: 37,
                      ),
                      unselectedIconTheme: const IconThemeData(
                        color: Colors.white,
                        size: 25,
                      ),
                      selectedLabelTextStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                      unselectedLabelTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                      destinations: const [
                        NavigationRailDestination(
                            icon: Icon(Icons.home),
                            label: Text("Home"),
                            indicatorColor: Colors.red),
                        NavigationRailDestination(
                            icon: Icon(Icons.sports_soccer),
                            label: Text("Football")),
                        NavigationRailDestination(
                            icon: Icon(Icons.directions_car),
                            label: Text("Motorsport")),
                        NavigationRailDestination(
                            icon: Icon(Icons.sports),
                            label: Text("Other Sports")),
                      ],
                      selectedIndex: selectedIndex,
                      onDestinationSelected: (value) {
                        setState(() {
                          selectedIndex = value;
                        });
                      })),
            Expanded(child: _getPage(selectedIndex)),
          ],
        ));
  }
}
