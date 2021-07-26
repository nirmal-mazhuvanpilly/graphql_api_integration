import 'package:flutter/material.dart';
import 'package:flutter_graphql_api_integration/historyview.dart';
import 'package:flutter_graphql_api_integration/adduser.dart';
import 'package:flutter_graphql_api_integration/upcomingview.dart';
import 'package:flutter_graphql_api_integration/userview.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
      body: bottomNavBarWidgets[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
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
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context)
                .push(
              MaterialPageRoute(
                builder: (_) => AddUser(),
              ),
            )
                .then((_) {
              setState(() {});
            });
          }),
    );
  }
}
