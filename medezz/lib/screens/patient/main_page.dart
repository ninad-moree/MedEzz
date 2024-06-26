import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/colors.dart';
import 'add_daily_data/add_daily_data.dart';
import 'analytics/analytics.dart';
import 'chatbot/chatbot.dart';
import 'home/home.dart';
import 'notifications/notification_form.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, this.index = 2});

  final int index;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 2;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      const AnalyticsScreen(),
      const DataPage(),
      const HomeScreenPatient(),
      const NotificationForm(),
      const ChatBot(),
    ];
    return Scaffold(
      body: Center(child: widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        fixedColor: Colors.white,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: CustomColors.primaryColor,
        selectedLabelStyle: const TextStyle(color: CustomColors.primaryColor),
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics, size: 30),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.fire, size: 30),
            label: 'Streak',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 35),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, size: 35),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat, size: 35),
            label: 'Chatbot',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
