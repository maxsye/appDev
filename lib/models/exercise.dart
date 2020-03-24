import 'package:flutter/material.dart';

enum ExerciseType {
  Cardio,
  Resistance,
  Both,
  Stretching,
}

enum Level {
  Beginner,
  Intermediate,
  Advanced,
}

enum AxialCompression {
  Compression,
  Decompression,
  None,
}

enum Equipment {
  YogaMat,
  Bands,
  PullUpBar,
  Dumbbells,
  Barbells,
  DualCables,
  CardioMachine,
  WeightMachine,
  Bench,
}

enum Muscle {
  Back,
  Biceps,
  Trapezius,
  Chest,
  Shoulders,
  Triceps,
  Abs,
  LowerBack,
  Glutes,
  Hamstrings,
  Quads,
  Calves,
  Forearms,
  Neck,
}

class Exercise with ChangeNotifier{
  final String name; //name of the exercise
  final double overall; //overall rating 1-10
  final String image; //image link
  final String animation;
  final Level level; //the difficulty/complexity
  final List<Equipment> equipment; //the equipment needed
  final Muscle major; //major muscle
  final List<Muscle> minor; //minor muscles
  final bool compound; //whether the movement is compound or isolation movement, true = compound
  final ExerciseType exerciseType; //whether is it cardio or resistance
  final AxialCompression axialCompression; //whether there is spinal compression, good for teenagers or people with back issues
  final List<String> steps; //how to perform exercise
  final List<String> commonMistakes;
  final List<String> tips;
  bool favorite;

  Exercise(
    this.name,
    this.overall,
    this.image,
    this.animation,
    this.level,
    this.equipment,
    this.major,
    this.minor,
    this.compound,
    this.exerciseType,
    this.axialCompression,
    this.steps,
    this.commonMistakes,
    this.tips,
    {this.favorite = false}
  );

    void toggleFavoriteStatus() {
      favorite = !favorite;
      notifyListeners();
  }
}
