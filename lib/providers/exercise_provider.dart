import 'package:flutter/material.dart';

import '../models/exercise.dart';
import '../data/database.dart';

class ExerciseProvider with ChangeNotifier {
  List<Exercise> _exercises = Exercises;

  List<Exercise> get exercises {
    return [..._exercises];
  }

  Exercise findByName(String name)
  {
    return _exercises.firstWhere((exercise) => exercise.name == name);
  }


  List<Exercise> _favorites = Exercises.where((exercise) => exercise.favorite).toList();

  List<Exercise> get favorites {
    return [..._favorites];
  }

}