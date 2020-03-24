import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/exercise.dart';
import '../widgets/exercise_card.dart';

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
          return ChangeNotifierProvider.value(
            value: exercisesList[index],
                      child: ExerciseCard(
              // exercisesList[index].name,
              // exercisesList[index].overall,
              // exercisesList[index].image,
              // exercisesList[index].level,
            ),
          );
        },
        itemCount: exercisesList.length,
      ),
    );
  }
}
