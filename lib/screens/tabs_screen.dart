import 'dart:io';

import 'package:flutter/material.dart';

import '../myUtility.dart';
import '../quiz/questions/goalq_screen.dart';
import '../screens/exercise_main_screen.dart';
import '../screens/favorites_screen.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs-screen';

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, Object>> _pages = [
    {'page': ExerciseMainScreen(), 'title': 'Exercises'},
    {'page': FavoritesScreen(), 'title': 'Favorites'},
  ];

  var _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  String getIconGoal(String goal) {
    switch (goal) {
      case 'Muscle':
        return 'assets/icons/increaseMuscleMass.png';
      case 'Lose fat':
        return 'assets/icons/loseWeight.png';
      case 'Feel better':
        return 'assets/icons/feelBetter.png';
      case 'Athleticism':
        return 'assets/icons/athleticPerformance.png';
      case 'Strength':
        return 'assets/icons/getStronger.png';
      case 'Variety':
        return 'assets/icons/newExercises.png';
      default:
        return 'unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MyUtility(context).screenHeight;

    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      drawer: MainDrawer(),
      backgroundColor: Theme.of(context).backgroundColor,
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).textTheme.body1.color,
        selectedItemColor: Theme.of(context).backgroundColor,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Container(
              height: Platform.isIOS ? screenHeight * 0.0316 :  screenHeight * 0.0422,
              child: Image.asset(
                getIconGoal(GoalQuestionScreen.selection),
                fit: BoxFit.contain,
                color: _selectedPageIndex == 0 ? Theme.of(context).backgroundColor : Theme.of(context).textTheme.body1.color,
              ),
            ),
            title: Text(GoalQuestionScreen.selection),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            title: Text('Favorites'),
          ),
        ],
      ),
    );
  }
}
