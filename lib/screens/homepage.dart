import 'package:flutter/material.dart';
import 'package:flutter_graphql_api_integration/screens/historyview.dart';
import 'package:flutter_graphql_api_integration/screens/upcomingview.dart';
import 'package:flutter_graphql_api_integration/screens/userview.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);

  void _onItemTapped(int index) {
    _selectedIndex.value = index;
  }

  List<Widget> bottomNavBarWidgets = [
    UserView(),
    UpcomingView(),
    HistoryView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(
          "SpaceX Land",
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: 25),
        ),
      ),
      body: ValueListenableBuilder(
          valueListenable: _selectedIndex,
          builder: (context, value, child) => bottomNavBarWidgets[value]),
      bottomNavigationBar: ValueListenableBuilder(
          valueListenable: _selectedIndex,
          builder: (context, value, child) {
            return BottomNavigationBar(
              currentIndex: _selectedIndex.value,
              onTap: _onItemTapped,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Users',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.business),
                  label: 'Upcoming',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.school),
                  label: 'History',
                ),
              ],
            );
          }),
    );
  }
}
