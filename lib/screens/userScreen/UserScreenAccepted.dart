import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/bottomnav.dart';

class UserScreen extends StatelessWidget {
  UserScreen(this.role, {Key? key}) : super(key: key);
  final String role;
  bool once = true;
  int i =0;
  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = Provider.of<BottomNav>(context);
    Provider.of<BottomNav>(context).setRole(role);
    return Builder(builder: (context) {
      return Scaffold(
        body: bottomNavProvider.bottomNavBarItems[bottomNavProvider.current]
            ['screen'],
        bottomNavigationBar
        :BottomNavigationBar(
          type:BottomNavigationBarType.fixed,
          fixedColor: Colors.white,
          backgroundColor: Colors.green,
          items: List.generate(
            bottomNavProvider.bottomNavBarItems.length,
            (index) => BottomNavigationBarItem(
              icon: Icon(bottomNavProvider.bottomNavBarItems[index]['icon']),
              label: bottomNavProvider.bottomNavBarItems[index]['label'],
            ),
          ),
          currentIndex: bottomNavProvider.current,
          onTap: (v)=>bottomNavProvider.set(v),

        )
      );
    });
  }
}
