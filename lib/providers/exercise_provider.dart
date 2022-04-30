import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prototype2/quiz/questions/bodyq_screen.dart';
import 'package:prototype2/quiz/questions/goalq_screen.dart';

import '../models/exercise.dart';
import '../data/database.dart';
import '../quiz/questions/equipmentq_screen.dart';
import '../quiz/questions/difficultyq_screen.dart';
import 'package:http/http.dart' as http;

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

  String _decodeExerciseLevel(int level) {
    switch (level) {
      case 0:
        return 'Beginner';
      case 1:
        return 'Intermediate';
      case 2:
        return 'Advanced';
      default:
       return 'Error';
    }
  }

  int _decodeCustomaryHeight(String customary)
  {
    return 1;
    //return int.parse(customary.substring(0,1)) * 12 + int.parse(customary.substring(2,3));
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

  Future<void> setSettings() async {
    const url = 'https://workoutapp-bb0ea.firebaseio.com/settings.json';

    _availableExercises = _exercises.where((exercise) {
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
    await http.patch(
      url,
      body: json.encode(
        {
          'difficultySetting': _convertLevelSelected(DifficultyQuestionScreen.selection),
          'goalSetting': GoalQuestionScreen.selection,
          'equipmentSetting': EquipmentQuestionScreen.selection,
          'gender': BodyQuestionScreen.gender,
          'weight': BodyQuestionScreen.metric ? '${BodyQuestionScreen.weight}kg' : '${BodyQuestionScreen.weight}lb',
          'height': BodyQuestionScreen.metric ? '${BodyQuestionScreen.height}cm' : '${(BodyQuestionScreen.height / 12).truncate()}\'${BodyQuestionScreen.height % 12}',
          'age': BodyQuestionScreen.age,
          'metric': BodyQuestionScreen.metric,
        },
      ),
    );
  }

  Future<void> fetchSettings() async {
      const url = 'https://workoutapp-bb0ea.firebaseio.com/settings.json';

      try {
        final response = await http.get(url);
        final extractedData = json.decode(response.body) as Map<String, dynamic>;
        if (extractedData == null) {
          return;
        }
        
        extractedData.forEach((key, value) {
          DifficultyQuestionScreen.selection = _decodeExerciseLevel(value['difficultySetting']);
          GoalQuestionScreen.selection = value['goalSetting'];
          EquipmentQuestionScreen.selection = value['equipmentSetting'];
          BodyQuestionScreen.gender = value['gender'];
          BodyQuestionScreen.weight = value['weight'];
          BodyQuestionScreen.metric = value['metric'];
          BodyQuestionScreen.height = BodyQuestionScreen.metric ? value['height'] : _decodeCustomaryHeight(value['height']);
          BodyQuestionScreen.age = value['age'];

        });
        print('fetched data');
        print(response.body);
      }
      catch (error)
      {
        throw error;
      }
    }
}
