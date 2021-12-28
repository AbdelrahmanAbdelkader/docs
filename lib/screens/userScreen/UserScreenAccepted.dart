import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/account.dart';

class UserScreen extends StatelessWidget {
  UserScreen({
    Key? key,
  }) : super(key: key);
  bool once = true;
  int i = 0;
  @override
  Widget build(BuildContext context) {
    final account = Provider.of<Account>(context);
    return Builder(builder: (context) {
      return Scaffold(
          body: account.bottomNavBarItems[account.current]['screen'],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            fixedColor: Colors.white,
            backgroundColor: Colors.green,
            items: List.generate(
              account.bottomNavBarItems.length,
              (index) => BottomNavigationBarItem(
                icon: Icon(account.bottomNavBarItems[index]['icon']),
                label: account.bottomNavBarItems[index]['label'],
              ),
            ),
            currentIndex: account.current,
            onTap: (v) => account.setCurrent(v),
          ));
    });
  }
}
