import 'package:fakebook_frontend/constants/Palette.dart';
import 'package:fakebook_frontend/screens/home/HomeScreen.dart';
import 'package:flutter/material.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  State<NavScreen> createState() => _NavScreenState();
}


class _NavScreenState extends State<NavScreen> with TickerProviderStateMixin{
  late TabController _tabController;
  static final List<IconData> _icons = const [
    Icons.home, Icons.people, Icons.ondemand_video, Icons.account_circle, Icons.notifications, Icons.menu
  ];
  static final List<Widget> _screens = [
    HomeScreen(),
    // FriendScreen(),
    // ProfileScreen(),
    // NotificationScreen(),
    // MenuScreen(),
    Center(
      child: Text("It's cloudy here"),
    ),
    Center(
      child: Text("It's rainy here"),
    ),
    Center(
      child: Text("It's sunny here"),
    ),
    Center(
      child: Text("It's not rainy here"),
    ),
    Center(
      child: Text("It's not sunny here"),
    ),
  ];

  final List<Tab> _screenTabs = _icons.map((icon) => Tab(
    icon: Icon(icon,size: 30)
  )).toList();

  @override
  void initState() {
    super.initState();
    // _tabController = TabController(vsync: this, length: 6, animationDuration: Duration.zero); // error due to animationDuration on Flutter 3.3.2
    _tabController = TabController(vsync: this, length: _screens.length);
  }
  @override
  void dispose() {
    print("dispose");
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: _screens,
        physics: NeverScrollableScrollPhysics()
      ),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        tabs: _screenTabs,
        indicator: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Palette.facebookBlue,
              width: 3
            )
          )
        ),
        indicatorColor: Colors.blueAccent,
        unselectedLabelColor: Colors.black45,
        labelColor: Colors.blueAccent,
      ),
    );
  }
}
