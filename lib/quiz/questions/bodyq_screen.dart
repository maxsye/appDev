import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../myUtility.dart';

class BodyQuestionScreen extends StatefulWidget {
  static var mainButton = false;
  static String gender = '';
  static var weight = 180;
  static var height = 69;
  static var age = 40;
  static var howManyPressed = 0;
  static bool metric = false;

  final double appBarHeight;
  final Function() passTheQuiz;
  final String finalButtonText;

  BodyQuestionScreen(
    this.passTheQuiz,
    this.appBarHeight,
    this.finalButtonText,
  );

  @override
  _BodyQuestionScreenState createState() => _BodyQuestionScreenState();
}

class _BodyQuestionScreenState extends State<BodyQuestionScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = Platform.isIOS
        ? MyUtility(context).screenHeight - widget.appBarHeight
        : (MyUtility(context).screenHeight - widget.appBarHeight) * 0.9;
    final screenWidth = MyUtility(context).screenWidth;

    void _changeWeightDisplay() {
      setState(() {
        BodyQuestionScreen.weight = BodyQuestionScreen.weight;
      });
    }

    void _changeHeightDisplay() {
      setState(() {
        BodyQuestionScreen.height = BodyQuestionScreen.height;
      });
    }

    void _changeAgeDisplay() {
      setState(() {
        BodyQuestionScreen.age = BodyQuestionScreen.age;
      });
    }

    refresh() {
      setState(() {
        BodyQuestionScreen.mainButton = !BodyQuestionScreen.mainButton;
      });
    }

    void changeUnits() {
      setState(() {
        BodyQuestionScreen.metric = !BodyQuestionScreen.metric;
        BodyQuestionScreen.weight = BodyQuestionScreen.metric ? 80 : 180;
        BodyQuestionScreen.height = BodyQuestionScreen.metric ? 175 : 69;
        WeightSlider(_changeWeightDisplay);
        HeightSlider(_changeHeightDisplay);
      });
    }

    var theme = Theme.of(context);

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
              'Help us better personalize your app',
              style: Theme.of(context).textTheme.title,
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(
              vertical: screenHeight * 0.001,
            ),
            child: Center(
              child: Text(
                BodyQuestionScreen.metric ? 'Metric' : 'Customary',
                style: Theme.of(context).textTheme.body2,
              ),
            ),
          ),
          Switch.adaptive(
              value: BodyQuestionScreen.metric,
              onChanged: (_) => changeUnits()),
          Container(
            margin: EdgeInsets.fromLTRB(
              screenWidth * 0.07,
              0,
              screenWidth * 0.07,
              screenHeight * 0.05,
            ),
            child: Column(
              children: <Widget>[
                Align(
                  child: Text(
                    BodyQuestionScreen.metric
                        ? 'Weight: ${BodyQuestionScreen.weight} kg'
                        : 'Weight: ${BodyQuestionScreen.weight} lbs',
                    style: theme.textTheme.body2,
                  ),
                  alignment: Alignment(-0.92, 0),
                ),
                Padding(
                  child: WeightSlider(_changeWeightDisplay),
                  padding: EdgeInsets.only(
                    bottom: screenHeight * 0.03,
                  ),
                ),
                Align(
                  child: Text(
                    BodyQuestionScreen.metric
                        ? 'Height: ${BodyQuestionScreen.height} cm'
                        : 'Height: ${(BodyQuestionScreen.height / 12).truncate()}\'${BodyQuestionScreen.height % 12}\"',
                    style: theme.textTheme.body2,
                  ),
                  alignment: Alignment(-0.92, 0),
                ),
                Padding(
                  child: HeightSlider(_changeHeightDisplay),
                  padding: EdgeInsets.only(
                    bottom: screenHeight * 0.03,
                  ),
                ),
                Align(
                  child: Text(
                    'Age: ${BodyQuestionScreen.age} years',
                    style: theme.textTheme.body2,
                  ),
                  alignment: Alignment(-0.92, 0),
                ),
                Padding(
                  child: AgeSlider(_changeAgeDisplay),
                  padding: EdgeInsets.only(
                    bottom: screenHeight * 0.03,
                  ),
                ),
                Align(
                  child: Text(
                    'Gender',
                    style: theme.textTheme.body2,
                  ),
                  alignment: Alignment(-0.92, 0),
                ),
                Wrap(
                  direction: Axis.horizontal,
                  spacing: screenWidth * 0.14,
                  children: <Widget>[
                    GenderCard(
                      'Male',
                      'assets/icons/maleSign.png',
                      refresh,
                      widget.appBarHeight,
                      ValueKey('Male'),
                    ),
                    GenderCard(
                      'Female',
                      'assets/icons/femaleSign.png',
                      refresh,
                      widget.appBarHeight,
                      ValueKey('Female'),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.06,
                ),
                Platform.isIOS
                    ? CupertinoButton(
                        padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.012,
                            horizontal: screenWidth * 0.2),
                        color: BodyQuestionScreen.mainButton
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).disabledColor,
                        onPressed: () => BodyQuestionScreen.gender == ''
                            ? null
                            : widget.passTheQuiz(),
                        child: Text(widget.finalButtonText,
                            style: BodyQuestionScreen.mainButton
                                ? Theme.of(context).textTheme.body2
                                : Theme.of(context).textTheme.display4),
                        borderRadius:
                            BorderRadius.circular(screenHeight * .022),
                      )
                    : RaisedButton(
                        padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.012,
                            horizontal: screenWidth * 0.2),
                        color: BodyQuestionScreen.mainButton
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).disabledColor,
                        onPressed: () => BodyQuestionScreen.gender == ''
                            ? null
                            : widget.passTheQuiz(),
                        child: Text(widget.finalButtonText,
                            style: BodyQuestionScreen.mainButton
                                ? Theme.of(context).textTheme.body2
                                : Theme.of(context).textTheme.display4),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(screenHeight * .022),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
    }

    return widget.finalButtonText == 'Finish'
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

class WeightSlider extends StatefulWidget {
  final Function changeNumDisplay;

  WeightSlider(this.changeNumDisplay);

  @override
  _WeightSliderState createState() => _WeightSliderState();
}

class _WeightSliderState extends State<WeightSlider> {
  @override
  Widget build(BuildContext context) {
    return Slider(
      value: BodyQuestionScreen.weight.toDouble(),
      min: BodyQuestionScreen.metric ? 35 : 80,
      max: BodyQuestionScreen.metric ? 125 : 280,
      divisions: BodyQuestionScreen.metric ? 91 : 201, //max - min + 1
      label: BodyQuestionScreen.metric
          ? '${BodyQuestionScreen.weight} kg'
          : '${BodyQuestionScreen.weight} lbs',
      onChanged: (newValue) {
        setState(() {
          BodyQuestionScreen.weight = newValue.round();
        });
        widget.changeNumDisplay();
      },
    );
  }
}

class HeightSlider extends StatefulWidget {
  final Function changeNumDisplay;

  HeightSlider(this.changeNumDisplay);

  @override
  _HeightSliderState createState() => _HeightSliderState();
}

class _HeightSliderState extends State<HeightSlider> {
  @override
  Widget build(BuildContext context) {
    return Slider(
      value: BodyQuestionScreen.height.toDouble(),
      min: BodyQuestionScreen.metric ? 135 : 54,
      max: BodyQuestionScreen.metric ? 215 : 84,
      divisions: BodyQuestionScreen.metric ? 81 : 52,
      label: BodyQuestionScreen.metric
          ? '${BodyQuestionScreen.height} cm'
          : '${(BodyQuestionScreen.height / 12).truncate()}\'${BodyQuestionScreen.height % 12}\"',
      onChanged: (newValue) {
        setState(() {
          BodyQuestionScreen.height = newValue.round();
        });
        widget.changeNumDisplay();
      },
    );
  }
}

class AgeSlider extends StatefulWidget {
  final Function changeNumDisplay;

  AgeSlider(this.changeNumDisplay);

  

  @override
  _AgeSliderState createState() => _AgeSliderState();
}

class _AgeSliderState extends State<AgeSlider> {
  @override
  Widget build(BuildContext context) {
    return Slider(
      value: BodyQuestionScreen.age.toDouble(),
      min: 10,
      max: 70,
      divisions: 61,
      label: '${BodyQuestionScreen.age}',
      onChanged: (newValue) {
        setState(() {
          BodyQuestionScreen.age = newValue.round();
        });
        widget.changeNumDisplay();
      },
      onChangeEnd: (newValue) {},
    );
  }
}

class GenderCard extends StatefulWidget {
  final String gender;
  final String iconLocation;
  final Function changeButton;
  final double appBarHeight;

  GenderCard(
    this.gender,
    this.iconLocation,
    this.changeButton,
    this.appBarHeight,
    Key key,
  ) : super(key: key);

  @override
  _GenderCardState createState() => _GenderCardState();
}

class _GenderCardState extends State<GenderCard> {
  var _pressed = false;

  void _firstButtonPress(String option) {
    BodyQuestionScreen.gender = option;
    setState(() {
      _pressed = !_pressed;
      BodyQuestionScreen.howManyPressed++;
    });
    widget.changeButton();
  }

  void _secondButtonPress(String option) {
    if (option != BodyQuestionScreen.gender) {
      return;
    } else {
      setState(() {
        _pressed = !_pressed;
        BodyQuestionScreen.howManyPressed--;
        BodyQuestionScreen.gender = null;
      });
      widget.changeButton();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = Platform.isIOS
        ? MyUtility(context).screenHeight - widget.appBarHeight
        : (MyUtility(context).screenHeight - widget.appBarHeight) * 0.9;
    final screenWidth = MyUtility(context).screenWidth;

    if (BodyQuestionScreen.gender == widget.gender) {
      _pressed = true;
    }

    return Container(
      margin: EdgeInsets.only(top: screenHeight * 0.02),
      child: OutlineButton(
        borderSide: _pressed
            ? BorderSide(color: Theme.of(context).primaryColor)
            : BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenWidth * 0.048),
        ),
        child: Container(
          padding: EdgeInsets.all(screenHeight * 0.009),
          width: screenWidth * .217,
          height: screenHeight * .16,
          child: Column(
            children: <Widget>[
              Text(widget.gender, style: Theme.of(context).textTheme.body1),
              Container(
                margin: EdgeInsets.all(screenHeight * .008),
                height: screenHeight * .07,
                width: screenWidth * .135,
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
        onPressed: () => BodyQuestionScreen.howManyPressed == 0
            ? _firstButtonPress(widget.gender)
            : _secondButtonPress(widget.gender),
      ),
    );
  }
}
