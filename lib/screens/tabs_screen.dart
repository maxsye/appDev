import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/exercise_provider.dart';
import '../myUtility.dart';
import '../quiz/questions/goalq_screen.dart';
import '../screens/exercise_main_screen.dart';
import '../screens/favorites_screen.dart';
import '../widgets/main_drawer.dart';
import '../models/exercise.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs-screen';

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Exercise> favorites;

  Future<List<Exercise>> getFavorites() async {
    return Future.delayed(Duration(seconds: 1),
        () => Provider.of<ExerciseProvider>(context).favorites);
  }

  @override
  void initState() {
    super.initState();
    getFavorites().then((values) {
      setState(() {
        favorites = values;
      });
    });
  }

  final List<Map<String, Object>> _pages = [
    {'title': 'Exercises'},
    {'title': 'Favorites'},
  ];

  Widget getPage(int index) {
    if (index == 0) {
      return ExerciseMainScreen(favorites);
    }
    if (index == 1) {
      return FavoritesScreen(favorites);
    }
    return ExerciseMainScreen(favorites);
  }

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
      body: getPage(_selectedPageIndex),
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
              height: Platform.isIOS
                  ? screenHeight * 0.0316
                  : screenHeight * 0.0422,
              child: Image.asset(
                getIconGoal(GoalQuestionScreen.selection),
                fit: BoxFit.contain,
                color: _selectedPageIndex == 0
                    ? Theme.of(context).backgroundColor
                    : Theme.of(context).textTheme.body1.color,
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
