import 'package:flutter/material.dart';
import 'package:medezz/constants/colors.dart';
import 'package:medezz/screens/patient/add_daily_data/screens/add_daily_data.dart';
import 'package:medezz/screens/patient/chatbot/chatbot.dart';
import 'package:medezz/screens/patient/gamification/plant_screen.dart';
import 'package:medezz/screens/patient/home/home.dart';
import 'package:medezz/screens/patient/notifications/notification_form.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, this.index = 0});

  final int index;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

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
      // const PatientFormScreen(),
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
            icon: Icon(
              Icons.last_page_outlined,
              size: 35,
            ),
            label: 'Daily Log',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 35,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              size: 35,
            ),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
              size: 35,
            ),
            label: 'Chatbot',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
