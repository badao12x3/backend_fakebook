import 'package:fakebook_frontend/blocs/auth/auth_bloc.dart';
import 'package:fakebook_frontend/blocs/auth/auth_event.dart';
import 'package:fakebook_frontend/constants/assets/palette.dart';
import 'package:fakebook_frontend/screens/friend/friend_screen.dart';
import 'package:fakebook_frontend/screens/home/home_screen.dart';
import 'package:fakebook_frontend/screens/menu/menu_screen.dart';
import 'package:fakebook_frontend/screens/notification/noti_screen.dart';
import 'package:fakebook_frontend/screens/personal/personal_screen.dart';
import 'package:fakebook_frontend/screens/watch/watch_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notification/widgets/noti_container.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  State<NavScreen> createState() => _NavScreenState();
}


class _NavScreenState extends State<NavScreen> with TickerProviderStateMixin{
  late TabController _tabController;
  static final List<IconData> _icons = const [
    Icons.home,
    Icons.people,
    Icons.ondemand_video,
    Icons.account_circle,
    Icons.notifications,
    Icons.menu
  ];
  static final List<Widget> _screens = [
    HomeScreen(),
    FriendScreen(),
    WatchTab(),
    PersonalScreen(),
    NotificationScreen(),
    MenuScreen(),
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
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final user = BlocProvider.of<AuthBloc>(context).state.authUser;
    // final token = user.token;
    // final userId = user.id;
    // print("$token, $userId");
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: _screens,
        // physics: NeverScrollableScrollPhysics()
      ),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        tabs: _screenTabs,
        indicator: const BoxDecoration(
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
