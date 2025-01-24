import 'package:flutter/material.dart';
import 'package:localnetwork/screens/local_users.dart';
import 'package:localnetwork/screens/network_users.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class BottomNavbs extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<BottomNavbs> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [NetworkScreen(), NativeUsers()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF252c4a),
        body: _pages[_selectedIndex],
        bottomNavigationBar: Theme(
          child: BottomNavigationBar(
            backgroundColor: Color(0xFF252c4a),
            // selectedLabelStyle: TextStyle(color: Colors.white),
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  IconlyBold.user3,
                ),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark),
                label: 'Natives',
              ),
            ],
          ),
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
        ));
  }
}
