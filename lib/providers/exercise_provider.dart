import 'package:flutter/material.dart';

import '../models/exercise.dart';
import '../data/database.dart';
import '../quiz/questions/equipmentq_screen.dart';
import '../quiz/questions/difficultyq_screen.dart';

class ExerciseProvider with ChangeNotifier {
  List<Exercise> _exercises = MuscleExercises;
  List<Exercise> _availableExercises = MuscleExercises;

  List<Exercise> get exercises {
    return [..._exercises];
  }

  Exercise findByName(String name) {
    return _exercises.firstWhere((exercise) => exercise.name == name);
  }

  List<Exercise> get favorites {
    return _exercises.where((exercise) => exercise.favorite).toList();
  }

  List<String> _getEquipmentNeeded(List<Equipment> equipment) {
    List<String> output = List<String>();
    for (int i = 0; i < equipment.length; i++) {
      if (equipment[i].toString().substring(10) == 'WeightMachine') {
        output.add('Weight machine');
      } else if (equipment[i].toString().substring(10) == 'CardioMachine') {
        output.add('Cardio machine');
      } else if (equipment[i].toString().substring(10) == 'DualCables') {
        output.add('Cables');
      } else if (equipment[i].toString().substring(10) == 'YogaMat') {
        output.add('Yoga mat');
      } else if (equipment[i].toString().substring(10) == 'PullUpBar') {
        output.add('Pull-up bar');
      } else if (!(equipment[i].toString().substring(10) == 'Bench')) {
        output.add(equipment[i].toString().substring(10));
      }
    }
    return output;
  }

  int _getExerciseLevel(Level level) {
    switch (level) {
      case Level.Advanced:
        return 2;
      case Level.Intermediate:
        return 1;
      case Level.Beginner:
        return 0;
      default:
        return -1;
    }
  }

  int _convertLevelSelected(String level) {
    switch (level) {
      case 'Advanced':
        return 2;
      case 'Intermediate':
        return 1;
      case 'Beginner':
        return 0;
      default:
        return -1;
    }
  }

  List<Exercise> get filteredExercises {
    return [..._availableExercises];
  }

  setSettings() {
    _availableExercises = _availableExercises.where((exercise) {
      if (_getEquipmentNeeded(exercise.equipment).isEmpty ||
          EquipmentQuestionScreen.selection
              .contains(_getEquipmentNeeded(exercise.equipment)[0])) {
        if (_convertLevelSelected(DifficultyQuestionScreen.selection) >=
            _getExerciseLevel(exercise.level)) {
          return true;
        }
      }
      return false;
    }).toList();
  }
}
