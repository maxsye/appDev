import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/tabs_screen.dart';
import '../providers/exercise_provider.dart';
import './questions/difficultyq_screen.dart';
import './questions/equipmentq_screen.dart';
import './questions/goalq_screen.dart';
import './questions/bodyq_screen.dart';

class QuizMain extends StatefulWidget {
  static var _index = 0;

  @override
  _QuizMainState createState() => _QuizMainState();
}

class _QuizMainState extends State<QuizMain> {
 var _firstTime = true;

 var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_firstTime) {
      setState(() {
        _isLoading = true;
        Provider.of<ExerciseProvider>(context).fetchSettings().then((_) {
          _isLoading = false;
        });
      });
      if (EquipmentQuestionScreen.selection.isNotEmpty)
    {
      Navigator.of(context).pushReplacementNamed(
        TabsScreen.routeName,
        arguments: {},
      );
    }
    }
    _firstTime = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    void goBack() {
      setState(() {
        QuizMain._index--;
      });
    }

    final topAppBar = AppBar(
      leading: QuizMain._index == 0 ? null : IconButton(
        icon: Platform.isIOS
            ? Icon(Icons.arrow_back_ios)
            : Icon(Icons.arrow_back),
        onPressed: () => goBack(),
      ),
      title: Text(
        'FitAssist',
      ),
      backgroundColor: theme.primaryColorDark,
    );

    refresh() {
      setState(() {
        QuizMain._index++;
      });
      Provider.of<ExerciseProvider>(context, listen: false).setSettings();
    }

    void finishQuiz() {
      Navigator.of(context).pushReplacementNamed(
        TabsScreen.routeName,
        arguments: {},
      );
      Provider.of<ExerciseProvider>(context).setSettings();
    }

    double height = topAppBar.preferredSize.height;

    var _questionScreens = [
      DifficultyQuestionScreen(refresh, height, 'Next'),
      EquipmentQuestionScreen(refresh, height, 'Next'),
      GoalQuestionScreen(refresh, height, 'Next'),
      BodyQuestionScreen(finishQuiz, height, 'Finish'),
    ];

    return Scaffold(
      appBar: topAppBar,
      backgroundColor: theme.backgroundColor,
      body: _questionScreens[QuizMain._index],
    );
  }
}
