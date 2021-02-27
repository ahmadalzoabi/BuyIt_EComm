import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../services/store.dart';
import '../../widgets/productView.dart';
import '../../screens/logIn_Screen.dart';
import '../../widgets/CartBarWidget.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final User userAuth = FirebaseAuth.instance.currentUser;
  int _tabBarIndex = 0;
  int _bottomBarIndex = 0;
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.shifting,
              unselectedItemColor: kUnActiveColor,
              backgroundColor: Colors.black,
              currentIndex: _bottomBarIndex,
              fixedColor: kMainColor,
              onTap: (value) async {
                if (value == 2) {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.clear();
                  await FirebaseAuth.instance.signOut();
                  Navigator.popAndPushNamed(context, LogInScreen.routeName);
                }
                setState(() {
                  _bottomBarIndex = value;
                });
              },
              items: [
                BottomNavigationBarItem(
                    backgroundColor: Colors.black,
                    label: 'Home',
                    icon: Icon(Icons.person)),
                BottomNavigationBarItem(
                    backgroundColor: Colors.black,
                    label: 'Favourite',
                    icon: Icon(Icons.favorite)),
                BottomNavigationBarItem(
                    backgroundColor: Colors.black,
                    label: 'Sign Out',
                    icon: Icon(Icons.close)),
              ],
            ),
            appBar: AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              bottom: TabBar(
                indicatorColor: kMainColor,
                onTap: (value) {
                  setState(() {
                    _tabBarIndex = value;
                  });
                },
                tabs: <Widget>[
                  Tab(
                    child: Text(
                      'Jackets',
                      style: TextStyle(
                        color: _tabBarIndex == 0 ? Colors.white : kMainColor,
                        fontSize: _tabBarIndex == 0 ? 16 : null,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Trouser',
                      style: TextStyle(
                        color: _tabBarIndex == 1 ? Colors.white : kMainColor,
                        fontSize: _tabBarIndex == 1 ? 16 : null,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'T-shirts',
                      style: TextStyle(
                        color: _tabBarIndex == 2 ? Colors.white : kMainColor,
                        fontSize: _tabBarIndex == 2 ? 16 : null,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Shoes',
                      style: TextStyle(
                        color: _tabBarIndex == 3 ? Colors.white : kMainColor,
                        fontSize: _tabBarIndex == 3 ? 16 : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                productView(_store.loadJacketProducts()),
                productView(_store.loadTrousersProducts()),
                productView(_store.loadTshirtsProducts()),
                productView(_store.loadShoesProducts()),
              ],
            ),
          ),
        ),
        CartBarWidget()
      ],
    );
  }
}
