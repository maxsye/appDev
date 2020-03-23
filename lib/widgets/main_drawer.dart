import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prototype2/screens/tabs_screen.dart';
import '../quiz/questions/goalq_screen.dart';
import '../screens/exercise_main_screen.dart';

import '../screens/settings_screen.dart';
import '../myUtility.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MyUtility(context).screenHeight;
    final screenWidth = MyUtility(context).screenWidth;

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

    var theme = Theme.of(context);
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              color: theme.backgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    child: Text(
                      'Options',
                      style: theme.textTheme.title,
                    ),
                    padding: EdgeInsets.all(screenWidth * 0.1),
                  ),
                  SizedBox(
                    height: screenHeight * 0.1,
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(
                      left: screenHeight * 0.065,
                    ),
                    leading: Container(
              height: Platform.isIOS ? screenHeight * 0.0316 :  screenHeight * 0.0422,
              child: Image.asset(
                getIconGoal(GoalQuestionScreen.selection),
                fit: BoxFit.contain,
                color: Theme.of(context).textTheme.body1.color,
              ),
            ),
                    title: Text('Exercises', style: theme.textTheme.body2),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, TabsScreen.routeName);
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(
                      left: screenHeight * 0.065,
                    ),
                    leading: Icon(
                      Icons.settings,
                      size: screenWidth * 0.075,
                      color: theme.textTheme.body2.color,
                    ),
                    title: Text('Settings', style: theme.textTheme.body2),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, SettingsScreen.routeName);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
