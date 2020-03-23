import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../myUtility.dart';

class EquipmentQuestionScreen extends StatefulWidget {
  static var mainButton = false;
  static List<String> selection = [];
  static var timesPressed = 0;

  final Function() notifyParent;
  final double appBarHeight;
  final String finalButtonText;

  EquipmentQuestionScreen(
      this.notifyParent, this.appBarHeight, this.finalButtonText);

  @override
  _EquipmentQuestionScreenState createState() =>
      _EquipmentQuestionScreenState();
}

class _EquipmentQuestionScreenState extends State<EquipmentQuestionScreen> {
  final _equipmentQuestion = const [
    {
      'text': 'Yoga mat',
      'iconLocation': 'assets/icons/yogaMat.png',
    },
    {
      'text': 'Bands',
      'iconLocation': 'assets/icons/resistanceBands.png',
    },
    {
      'text': 'Pull-up bar',
      'iconLocation': 'assets/icons/pullUpBar.png',
    },
    {
      'text': 'Dumbbells',
      'iconLocation': 'assets/icons/dumbbells.png',
    },
    {
      'text': 'Barbells',
      'iconLocation': 'assets/icons/barbells.png',
    },
    {
      'text': 'Cables',
      'iconLocation': 'assets/icons/cableMachine.png',
    },
    {
      'text': 'Cardio machine',
      'iconLocation': 'assets/icons/cardio.png',
    },
    {
      'text': 'Weight machine',
      'iconLocation': 'assets/icons/weightMachine.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MyUtility(context).screenHeight - widget.appBarHeight;
    final screenWidth = MyUtility(context).screenWidth;

    refresh() {
      setState(() {
        EquipmentQuestionScreen.mainButton =
            !EquipmentQuestionScreen.mainButton;
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
                'What is your equipment availability?',
                style: Theme.of(context).textTheme.title,
                textAlign: TextAlign.left,
              ),
            ),
            Wrap(
              spacing: screenWidth * 0.07,
              runSpacing: screenHeight * 0.03,
              children: <Widget>[
                for (var i = 0; i < _equipmentQuestion.length; i++)
                  EquipmentCard(
                    _equipmentQuestion[i]['text'],
                    _equipmentQuestion[i]['iconLocation'],
                    refresh,
                    widget.appBarHeight,
                    ValueKey(_equipmentQuestion[i]['text']),
                  ),
              ],
              direction: Axis.horizontal,
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            Platform.isIOS
                ? CupertinoButton(
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.012,
                        horizontal: screenWidth * 0.2),
                    color: EquipmentQuestionScreen.mainButton
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).disabledColor,
                    onPressed: () => EquipmentQuestionScreen.selection.isEmpty
                        ? null
                        : widget.notifyParent(),
                    child: Text(widget.finalButtonText,
                        style: EquipmentQuestionScreen.mainButton
                            ? Theme.of(context).textTheme.body2
                            : Theme.of(context).textTheme.display4),
                    borderRadius: BorderRadius.circular(screenHeight * .022),
                  )
                : RaisedButton(
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.012,
                        horizontal: screenWidth * 0.2),
                    color: EquipmentQuestionScreen.mainButton
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).disabledColor,
                    onPressed: () => EquipmentQuestionScreen.selection.isEmpty
                        ? null
                        : widget.notifyParent(),
                    child: Text(widget.finalButtonText,
                        style: EquipmentQuestionScreen.mainButton
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

class EquipmentCard extends StatefulWidget {
  final String question;
  final String iconLocation;
  final Function changeButton;
  final double appBarHeight;

  const EquipmentCard(
    this.question,
    this.iconLocation,
    this.changeButton,
    this.appBarHeight,
    Key key,
  ) : super(key: key);

  @override
  _EquipmentCardState createState() => _EquipmentCardState();
}

class _EquipmentCardState extends State<EquipmentCard> {
  var _pressed = false;

  void _firstButtonPress(String option) {
    if (EquipmentQuestionScreen.selection.isEmpty) {
      widget.changeButton();
    }
    EquipmentQuestionScreen.selection.add(option);
    setState(() {
      _pressed = !_pressed;
      EquipmentQuestionScreen.timesPressed++;
    });
  }

  void _secondButtonPress(String option) {
    if (_pressed) {
      EquipmentQuestionScreen.selection.remove(option);
      EquipmentQuestionScreen.selection.join(', ');
      EquipmentQuestionScreen.timesPressed--;
      setState(() {
        _pressed = !_pressed;
      });
      if (EquipmentQuestionScreen.selection.isEmpty) {
        widget.changeButton();
      }
    } else {
      EquipmentQuestionScreen.selection.add(option);
      setState(() {
        _pressed = !_pressed;
        EquipmentQuestionScreen.timesPressed++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (EquipmentQuestionScreen.selection.contains(widget.question)) {
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
        borderRadius: BorderRadius.circular(screenWidth * 0.048),
      ),
      child: Container(
        padding:
            EdgeInsets.symmetric(vertical: screenHeight * 0.003, horizontal: 0),
        width: screenWidth * .333,
        height: screenHeight * .14,
        child: Column(
          children: <Widget>[
            Text(
              widget.question,
              style: Theme.of(context).textTheme.body1,
            ),
            Container(
              margin: EdgeInsets.all(screenHeight * .0084),
              height: screenHeight * .068,
              width: screenWidth * .145,
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
      onPressed: () => EquipmentQuestionScreen.timesPressed == 0
          ? _firstButtonPress(widget.question)
          : _secondButtonPress(widget.question),
    );
  }
}
