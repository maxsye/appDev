import 'dart:io';

import 'package:flutter/material.dart';

import '../myUtility.dart';
import './exercise_lists.dart';
import '../models/exercise.dart';

class ExerciseMainScreen extends StatelessWidget {
  static const routeName = '/exercise-main-screen';

  final List<Exercise> favorites;

  ExerciseMainScreen(this.favorites);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MyUtility(context).screenHeight;
    final screenWidth = MyUtility(context).screenWidth;

    // print(DifficultyQuestionScreen.selection);
    // print(EquipmentQuestionScreen.selection);
    // print(GoalQuestionScreen.selection);
    // print(BodyQuestionScreen.gender);
    // print(BodyQuestionScreen.weight);
    // print(BodyQuestionScreen.height);
    // print(AgeSlider.age);

    final _muscleGroups = [
      {
        'text': 'Back',
        'iconLocation': 'assets/images/back.png',
        'offset': 0.16,
        'zoom': screenWidth * 0.0098,
      },
      {
        'text': 'Biceps',
        'iconLocation': 'assets/images/biceps.png',
        'offset': 0.15,
        'zoom': screenWidth * 0.008,
      },
      {
        'text': 'Trapezius',
        'iconLocation': 'assets/images/trapezius.png',
        'offset': 0.02,
        'zoom': screenWidth * 0.0078,
      },
      {
        'text': 'Chest',
        'iconLocation': 'assets/images/chest.png',
        'offset': .04,
        'zoom': screenWidth * 0.007,
      },
      {
        'text': 'Shoulders',
        'iconLocation': 'assets/images/shoulders.png',
        'offset': .04,
        'zoom': screenWidth * 0.007,
      },
      {
        'text': 'Triceps',
        'iconLocation': 'assets/images/triceps.png',
        'offset': .15,
        'zoom': screenWidth * 0.0072,
      },
      {
        'text': 'Abs',
        'iconLocation': 'assets/images/abs.png',
        'offset': .28,
        'zoom': screenWidth * 0.0085,
      },
      {
        'text': 'Lower Back',
        'iconLocation': 'assets/images/lowerBack.png',
        'offset': .35,
        'zoom': screenWidth * 0.007,
      },
      {
        'text': 'Glutes',
        'iconLocation': 'assets/images/glutes.png',
        'offset': .42,
        'zoom': screenWidth * 0.01,
      },
      {
        'text': 'Hamstrings',
        'iconLocation': 'assets/images/hamstrings.png',
        'offset': .6,
        'zoom': screenWidth * 0.01,
      },
      {
        'text': 'Quads',
        'iconLocation': 'assets/images/quadriceps.png',
        'offset': .57,
        'zoom': screenWidth * 0.01,
      },
      {
        'text': 'Calves',
        'iconLocation': 'assets/images/calves.png',
        'offset': .92,
        'zoom': screenWidth * 0.01,
      },
      {
        'text': 'Forearms',
        'iconLocation': 'assets/images/forearms.png',
        'offset': .3,
        'zoom': screenWidth * 0.01,
      },
      {
        'text': 'Neck',
        'iconLocation': 'assets/images/neck.png',
        'offset': 0.05,
        'zoom': screenWidth * 0.005,
      },
    ];

    Widget buildImageRow(int bottom, int top) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          for (var i = bottom; i < top; i++)
            MuscleGroupCard(
              _muscleGroups[i]['text'],
              _muscleGroups[i]['iconLocation'],
              _muscleGroups[i]['offset'],
              _muscleGroups[i]['zoom'],
            )
        ],
      );
    }

    Widget buildTextSection(String text, BuildContext context) {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(
          0,
          screenHeight * 0.055,
          0,
          screenHeight * 0.01,
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.body2,
          textAlign: TextAlign.center,
        ),
      );
    }

    return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(
                  0,
                  screenHeight * 0.025,
                  0,
                  screenHeight * 0.01,
                ),
                child: Text(
                  'Upper (Pull)',
                  style: Theme.of(context).textTheme.body2,
                  textAlign: TextAlign.center,
                ),
              ),
              buildImageRow(0, 3),
              buildTextSection('Upper (Push)', context),
              buildImageRow(3, 6),
              buildTextSection('Core', context),
              buildImageRow(6, 8),
              buildTextSection('Lower', context),
              buildImageRow(8, 11),
              buildTextSection('Accessory', context),
              buildImageRow(11, 14),
              SizedBox(
                height: screenHeight * 0.1,
              ),
            ],
          ),
        );
  }
}

class MuscleGroupCard extends StatelessWidget {
  final String info;
  final String imagePath;
  final double offset;
  final double zoom;

  MuscleGroupCard(
    this.info,
    this.imagePath,
    this.offset,
    this.zoom,
  );

  void selectMuscle(BuildContext context) {
    Navigator.of(context).pushNamed(
      ExerciseLists.routeName,
      arguments: {
        'title': info,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = Platform.isIOS
        ? MyUtility(context).screenHeight * 0.959
        : MyUtility(context).screenHeight * 1.37;

    return FlatButton(
      onPressed: () => selectMuscle(context),
      child: Container(
        height: screenHeight * .175,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: screenHeight *
                  .13151, //intentional, I want them to be around the same value
              width: screenHeight * .13151,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: theme.backgroundColor,
                border: Border.all(color: theme.textTheme.body1.color),
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.none,
                  image: Image.asset(imagePath, scale: zoom).image,
                  alignment: FractionalOffset(0.5, offset),
                ),
              ),
            ),
            Text(
              info,
              style: Theme.of(context).textTheme.body1,
            ),
          ],
        ),
      ),
    );
  }
}
