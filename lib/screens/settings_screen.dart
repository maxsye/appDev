import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../providers/exercise_provider.dart';
import '../myUtility.dart';
import '../widgets/main_drawer.dart';
import '../quiz/questions/difficultyq_screen.dart';
import '../quiz/questions/equipmentq_screen.dart';
import '../quiz/questions/goalq_screen.dart';
import '../quiz/questions/bodyq_screen.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings-screen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MyUtility(context).screenHeight;
    //final screenWidth = MyUtility(context).screenWidth;

    final appBar = AppBar(title: Text('Settings'));

    Widget _buildListTile(String title, String subtitle, Function newPage) {
      return Padding(
        child: ListTile(
          title: Text(title, style: Theme.of(context).textTheme.body2),
          subtitle: Text(subtitle, style: Theme.of(context).textTheme.body1),
          trailing: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenHeight * 0.015),
            ),
            color: Theme.of(context).primaryColor,
            child: Text(
              'Edit',
              style: Theme.of(context).textTheme.body2,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                Platform.isIOS
                    ? CupertinoPageRoute(builder: newPage)
                    : MaterialPageRoute(builder: newPage),
              );
            },
          ),
        ),
        padding: EdgeInsets.all(screenHeight * 0.03),
      );
    }

    String _getEquipment() {
      var sortedList = EquipmentQuestionScreen.selection
        ..sort((a, b) => a.toString().compareTo(b.toString()));
      //do not necessarily need to sort but might be useful later
      if (sortedList.length == 8) {
        return 'Full gym';
      } else if (sortedList.length == 7 || sortedList.length == 6) {
        return 'High';
      } else if (sortedList.length == 5 || sortedList.length == 4) {
        return 'Medium';
      } else {
        return 'Low';
      }
    }

    String _getBodyStats() {
      if (!BodyQuestionScreen.metric) {
        return '${BodyQuestionScreen.weight} lbs, ${(BodyQuestionScreen.height / 12).truncate()}\'${BodyQuestionScreen.height % 12}\", ${BodyQuestionScreen.age} years';
      } else {
        return '${BodyQuestionScreen.weight} kgs, ${BodyQuestionScreen.height} cm, ${BodyQuestionScreen.age} years';
      }
    }

    return Scaffold(
      appBar: appBar,
      drawer: MainDrawer(),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: <Widget>[
          _buildListTile(
            'Experience Level',
            DifficultyQuestionScreen.selection,
            (context) => DifficultyQuestionScreen(
              () {
                Provider.of<ExerciseProvider>(context, listen: false).setSettings();
                Navigator.pushReplacementNamed(
                    context, SettingsScreen.routeName);
              },
              appBar.preferredSize.height,
              'Save',
            ),
          ),
          _buildListTile(
            'Equipment Availability',
            _getEquipment(),
            (context) => EquipmentQuestionScreen(
              () {
                Provider.of<ExerciseProvider>(context, listen: false).setSettings();
                Navigator.pushReplacementNamed(
                    context, SettingsScreen.routeName);
              },
              appBar.preferredSize.height,
              'Save',
            ),
          ),
          _buildListTile(
            'Primary Goal',
            GoalQuestionScreen.selection,
            (context) => GoalQuestionScreen(
              () {
                //saveGoalSettings();
                Navigator.pushReplacementNamed(
                    context, SettingsScreen.routeName);
              },
              appBar.preferredSize.height,
              'Save',
            ),
          ),
          _buildListTile(
            'Body Stats',
            _getBodyStats(),
            (context) => BodyQuestionScreen(
              () {
                //saveBodySettings();
                Navigator.pushReplacementNamed(
                    context, SettingsScreen.routeName);
              },
              appBar.preferredSize.height,
              'Save',
            ),
          ),
        ],
      ),
    );
  }
}
