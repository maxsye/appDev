import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../myUtility.dart';

class DifficultyQuestionScreen extends StatefulWidget {
  static var howManyPressed = 0;
  static var mainButton = false;
  static var selection = '';

  final Function() notifyParent;
  final double appBarHeight;
  final String finalButtonText;

  DifficultyQuestionScreen(
      this.notifyParent, this.appBarHeight, this.finalButtonText);

  @override
  _DifficultyQuestionScreenState createState() =>
      _DifficultyQuestionScreenState();
}

class _DifficultyQuestionScreenState extends State<DifficultyQuestionScreen> {
  final _difficultyQuestion = const [
    {
      'text': 'Beginner',
      'description': 'I\'m just getting started',
    },
    {
      'text': 'Intermediate',
      'description': 'I have made considerable progress',
    },
    {
      'text': 'Advanced',
      'description': 'I\'ve been working out consistently for a few years',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MyUtility(context).screenHeight - widget.appBarHeight;
    final screenWidth = MyUtility(context).screenWidth;

    refresh() {
      setState(() {
        DifficultyQuestionScreen.mainButton =
            !DifficultyQuestionScreen.mainButton;
      });
    }

    Widget _buildScreen() {
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
                'How experienced are you with resistance training and cardio?',
                style: Theme.of(context).textTheme.title,
                textAlign: TextAlign.left,
              ),
            ),
            for (var i = 0; i < _difficultyQuestion.length; i++)
              Container(
                child: DifficultyCard(
                  _difficultyQuestion[i]['text'],
                  _difficultyQuestion[i]['description'],
                  refresh,
                  widget.appBarHeight,
                  ValueKey(_difficultyQuestion[i]['text']),
                ),
                margin: EdgeInsets.only(bottom: screenHeight * 0.04),
              ),
            SizedBox(
              height: screenHeight * 0.07,
            ),
            Platform.isIOS
                ? CupertinoButton(
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.012,
                        horizontal: screenWidth * 0.2),
                    color: DifficultyQuestionScreen.mainButton
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).disabledColor,
                    onPressed: () => DifficultyQuestionScreen.selection == ''
                        ? null
                        : widget.notifyParent(),
                    child: Text(widget.finalButtonText,
                        style: DifficultyQuestionScreen.mainButton
                            ? Theme.of(context).textTheme.body2
                            : Theme.of(context).textTheme.display4),
                    borderRadius: BorderRadius.circular(screenHeight * .022),
                  )
                : RaisedButton(
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.012,
                        horizontal: screenWidth * 0.2),
                    color: DifficultyQuestionScreen.mainButton
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).disabledColor,
                    onPressed: () => DifficultyQuestionScreen.selection == ''
                        ? null
                        : widget.notifyParent(),
                    child: Text(widget.finalButtonText,
                        style: DifficultyQuestionScreen.mainButton
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

class DifficultyCard extends StatefulWidget {
  final String title;
  final String description;
  final Function changeButton;
  final double appBarHeight;

  const DifficultyCard(
    this.title,
    this.description,
    this.changeButton,
    this.appBarHeight,
    Key key,
  ) : super(key: key);

  @override
  _DifficultyCardState createState() => _DifficultyCardState();
}

class _DifficultyCardState extends State<DifficultyCard> {
  var _pressed = false;

  void _firstButtonPress(String option) {
    DifficultyQuestionScreen.selection = option;
    setState(() {
      _pressed = !_pressed;
      DifficultyQuestionScreen.howManyPressed++;
    });
    widget.changeButton();
  }

  void _secondButtonPress(String option) {
    if (option != DifficultyQuestionScreen.selection) {
      return;
    } else {
      setState(() {
        _pressed = !_pressed;
        DifficultyQuestionScreen.howManyPressed--;
        DifficultyQuestionScreen.selection = '';
      });
      widget.changeButton();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MyUtility(context).screenHeight - widget.appBarHeight;
    final screenWidth = MyUtility(context).screenWidth;

    if (DifficultyQuestionScreen.selection == widget.title) {
      _pressed = true;
    }

    return OutlineButton(
      borderSide: _pressed
          ? BorderSide(
              color: theme.primaryColor,
            )
          : BorderSide.none,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          screenWidth * 0.05,
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: screenHeight * .01),
        width: screenWidth * .8,
        height: screenHeight * .15,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.title,
                style: Theme.of(context).textTheme.body2,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.description,
                style: Theme.of(context).textTheme.body1,
              ),
            ),
          ],
        ),
      ),
      onPressed: () => DifficultyQuestionScreen.howManyPressed == 0
          ? _firstButtonPress(widget.title)
          : _secondButtonPress(widget.title),
    );
  }
}
