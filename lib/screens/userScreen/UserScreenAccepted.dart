import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/bottomnav.dart';

class UserScreen extends StatelessWidget {
  UserScreen({
    Key? key,
  }) : super(key: key);
  bool once = true;
  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = Provider.of<Account>(context);
    return Builder(builder: (context) {
      return Scaffold(
        body: bottomNavProvider.bottomNavBarItems[bottomNavProvider.current]
            ['screen'],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: bottomNavProvider.current,
          onTap: (v) => bottomNavProvider.setCurrent(v),
          items: List.generate(
            bottomNavProvider.bottomNavBarItems.length,
            (index) => BottomNavigationBarItem(
              icon: Icon(
                bottomNavProvider.bottomNavBarItems[index]['icon'],
              ),
              label: bottomNavProvider.bottomNavBarItems[index]['label'],
            ),
          ),
        ),
      );
    });
  }
}
