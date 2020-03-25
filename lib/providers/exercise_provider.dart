import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/exercise.dart';
import '../data/database.dart';
import '../quiz/questions/equipmentq_screen.dart';

class ExerciseProvider with ChangeNotifier {
  List<Exercise> _exercises = Exercises;
  List<Exercise> _availableExercises = Exercises;

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

  List<Exercise> get filteredExercises {
    _availableExercises = Exercises.where((exercise) {
      if (_getEquipmentNeeded(exercise.equipment).isEmpty) {
        return true;
      } else if (EquipmentQuestionScreen.selection
          .contains(_getEquipmentNeeded(exercise.equipment)[0])) {
        return true;
      }
      return false;
    }).toList();
    return _availableExercises;
  }

  setEquipmentSettings() {
    print('setcalled');
    _availableExercises = Exercises.where((exercise) {
      if (_getEquipmentNeeded(exercise.equipment).isEmpty) {
        return true;
      } else if (EquipmentQuestionScreen.selection
          .contains(_getEquipmentNeeded(exercise.equipment)[0])) {
        return true;
      }
      return false;
    }).toList();
  }
}
