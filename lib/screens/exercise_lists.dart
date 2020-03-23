import 'dart:io';
import 'dart:core';

import 'package:flutter/material.dart';

import './exercise_detail_screen.dart';
import '../models/exercise.dart';
import '../myUtility.dart';

class ExerciseLists extends StatelessWidget {
  static const routeName = '/exercise-lists';

  final List<Exercise> _availableExercises;
  ExerciseLists(this._availableExercises);

  String muscleText(Muscle muscle) {
    switch (muscle) {
      case Muscle.Abs:
        return 'Abs';
      case Muscle.Back:
        return 'Back';
      case Muscle.Biceps:
        return 'Biceps';
      case Muscle.Calves:
        return 'Calves';
      case Muscle.Chest:
        return 'Chest';
      case Muscle.Forearms:
        return 'Forearms';
      case Muscle.Glutes:
        return 'Glutes';
      case Muscle.Hamstrings:
        return 'Hamstrings';
      case Muscle.LowerBack:
        return 'Lower Back';
      case Muscle.Neck:
        return 'Neck';
      case Muscle.Quads:
        return 'Quads';
      case Muscle.Shoulders:
        return 'Shoulders';
      case Muscle.Trapezius:
        return 'Trapezius';
      case Muscle.Triceps:
        return 'Triceps';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeArguments =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;

    final rawExerciseMuscle = routeArguments['title'];
    //final exerciseMuscle = (rawExerciseMuscle as String).split(' ').join('');
    //takes the spaces out of the muscle name

    var exercisesList = _availableExercises.where((exercise) {
      return muscleText(exercise.major) == rawExerciseMuscle;
    }).toList();
    exercisesList = (exercisesList
          ..sort((a, b) => a.overall.compareTo(b.overall)))
        .reversed
        .toList();

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text(rawExerciseMuscle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return ExerciseCard(
            exercisesList[index].name,
            exercisesList[index].overall,
            exercisesList[index].image,
            exercisesList[index].level,
          );
        },
        itemCount: exercisesList.length,
      ),
    );
  }
}

class ExerciseCard extends StatelessWidget {
  final String title;
  final double overall;
  final String imagePath;
  final Level level;

  ExerciseCard(this.title, this.overall, this.imagePath, this.level);

  String get levelText {
    switch (level) {
      case Level.Beginner:
        return 'Beginner';
        break;
      case Level.Intermediate:
        return 'Intermediate';
        break;
      case Level.Advanced:
        return 'Advanced';
        break;
      default:
        return 'Unknown';
    }
  }

  void selectExercise(BuildContext context) {
    Navigator.of(context).pushNamed(
      ExerciseDetailScreen.routeName,
      arguments: {
        'title': title,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = Platform.isIOS
        ? MyUtility(context).screenHeight
        : MyUtility(context).screenHeight * 1.35;
    final screenWidth = MyUtility(context).screenWidth;

    return InkWell(
      onTap: () => selectExercise(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenWidth * 0.048),
        ),
        elevation: 4,
        margin: EdgeInsets.all(screenHeight * .028),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(screenWidth * 0.048),
                    topRight: Radius.circular(screenWidth * 0.048),
                  ),
                  child: Image.asset(
                    imagePath,
                    height: screenHeight * 0.2,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  bottom: screenHeight * 0.015,
                  right: screenWidth * 0.03,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(screenHeight * 0.01),
                      ),
                      color: Colors.black54,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.003,
                      horizontal: screenWidth * 0.03,
                    ),
                    child: Center(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.body2,
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(screenWidth * 0.048),
                  bottomRight: Radius.circular(screenWidth * 0.048),
                ),
                color: Theme.of(context).primaryColorDark,
              ),
              padding: EdgeInsets.all(screenHeight * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'Overall: $overall',
                  ),
                  Text(
                    '$levelText',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
