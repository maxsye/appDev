import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../myUtility.dart';

class GoalQuestionScreen extends StatefulWidget {
  static var howManyPressed = 0;
  static var mainButton = false;
  static var selection = '';

  final Function() notifyParent;
  final double appBarHeight;
  final String finalButtonText;

  GoalQuestionScreen(this.notifyParent, this.appBarHeight, this.finalButtonText);

  @override
  _GoalQuestionScreenState createState() => _GoalQuestionScreenState();
}

class _GoalQuestionScreenState extends State<GoalQuestionScreen> {
  final _goalQuestion = const [
    {
      'text': 'Muscle',
      'iconLocation': 'assets/icons/increaseMuscleMass.png',
    },
    {
      'text': 'Lose fat',
      'iconLocation': 'assets/icons/loseWeight.png',
    },
    {
      'text': 'Feel better',
      'iconLocation': 'assets/icons/feelBetter.png',
    },
    {
      'text': 'Athleticism',
      'iconLocation': 'assets/icons/athleticPerformance.png',
    },
    {
      'text': 'Strength',
      'iconLocation': 'assets/icons/getStronger.png',
    },
    {
      'text': 'Variety',
      'iconLocation': 'assets/icons/newExercises.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MyUtility(context).screenHeight - widget.appBarHeight;
    final screenWidth = MyUtility(context).screenWidth;

    refresh() {
      setState(() {
        GoalQuestionScreen.mainButton = !GoalQuestionScreen.mainButton;
      });
    }

    Widget _buildScreen()
    {
      return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(
              vertical: screenHeight * 0.03,
              horizontal: screenWidth * .07,
            ),
            child: Text(
              'What is your primary goal?',
              style: Theme.of(context).textTheme.title,
              textAlign: TextAlign.left,
            ),
          ),
          Wrap(
            spacing: screenWidth * 0.1,
            runSpacing: screenHeight * 0.035,
            children: <Widget>[
              for (var i = 0; i < _goalQuestion.length; i++)
                GoalCard(
                  _goalQuestion[i]['text'],
                  _goalQuestion[i]['iconLocation'],
                  refresh,
                  widget.appBarHeight,
                  ValueKey(_goalQuestion[i]['text']),
                ),
            ],
            direction: Axis.horizontal,
          ),
          SizedBox(
            height: screenHeight * 0.1,
          ),
          Platform.isIOS
              ? CupertinoButton(
                  padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.012,
                      horizontal: screenWidth * 0.2),
                  color: GoalQuestionScreen.mainButton
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).disabledColor,
                  onPressed: () => GoalQuestionScreen.selection == ''
                      ? null
                      : widget.notifyParent(),
                  child: Text(widget.finalButtonText,
                      style: GoalQuestionScreen.mainButton
                          ? Theme.of(context).textTheme.body2
                          : Theme.of(context).textTheme.display4),
                  borderRadius: BorderRadius.circular(screenHeight * .022),
                )
              : RaisedButton(
                  padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.012,
                      horizontal: screenWidth * 0.2),
                  color: GoalQuestionScreen.mainButton
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).disabledColor,
                  onPressed: () => GoalQuestionScreen.selection == ''
                      ? null
                      : widget.notifyParent(),
                  child: Text(widget.finalButtonText,
                      style: GoalQuestionScreen.mainButton
                          ? Theme.of(context).textTheme.body2
                          : Theme.of(context).textTheme.display4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenHeight * .022),
                  ),
                ),
        ],
      ),
    );
    }

    return widget.finalButtonText == 'Next'
        ? _buildScreen()
        : Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
              title: Text(
                'Questions',
              ),
              backgroundColor: Theme.of(context).primaryColorDark,
            ),
            body: _buildScreen());
  }
}

class GoalCard extends StatefulWidget {
  final String question;
  final String iconLocation;
  final Function changeButton;
  final double appBarHeight;

  GoalCard(
    this.question,
    this.iconLocation,
    this.changeButton,
    this.appBarHeight,
    Key key,
  ) : super(key: key);

  @override
  _GoalCardState createState() => _GoalCardState();
}

class _GoalCardState extends State<GoalCard> {
  var _pressed = false;

  void _firstButtonPress(String option) {
    GoalQuestionScreen.selection = option;
    setState(() {
      _pressed = !_pressed;
      GoalQuestionScreen.howManyPressed++;
    });
    widget.changeButton();
  }

  void _secondButtonPress(String option) {
    if (option != GoalQuestionScreen.selection) {
      return;
    } else {
      setState(() {
        _pressed = !_pressed;
        GoalQuestionScreen.howManyPressed--;
        GoalQuestionScreen.selection = '';
      });
      widget.changeButton();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (GoalQuestionScreen.selection == widget.question) {
      _pressed = true;
    }
    final theme = Theme.of(context);
    final screenHeight = MyUtility(context).screenHeight - widget.appBarHeight;
    final screenWidth = MyUtility(context).screenWidth;

    return OutlineButton(
        borderSide: _pressed
            ? BorderSide(
                color: theme.primaryColor,
              )
            : BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            screenWidth * 0.048,
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(screenHeight * 0.009),
          width: screenWidth * .27,
          height: screenHeight * .18,
          child: Column(
            children: <Widget>[
              Text(
                widget.question,
                style: Theme.of(context).textTheme.body1,
              ),
              Container(
                margin: EdgeInsets.all(screenHeight * .0112),
                height: screenHeight * .0893,
                width: screenWidth * .193,
                alignment: Alignment.center,
                child: Image.asset(
                  widget.iconLocation,
                  color: Theme.of(context).primaryColorLight,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
        onPressed: () => GoalQuestionScreen.howManyPressed == 0
            ? _firstButtonPress(widget.question)
            : _secondButtonPress(widget.question),
      );
  }
}
