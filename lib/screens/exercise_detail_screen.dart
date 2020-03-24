import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/database.dart';
import '../models/exercise.dart';
import '../providers/exercise_provider.dart';

import '../myUtility.dart';

class ExerciseDetailScreen extends StatefulWidget {
  static const routeName = '/exercise-details';

  @override
  _ExerciseDetailScreenState createState() => _ExerciseDetailScreenState();
}
//made a stateful widget so I can use initState

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  //to determine the height of dynamically generated column
  //so I can apply that height to another column
  final GlobalKey _minorMusclesList = GlobalKey();
  double _minorListHeight;

  //function to return the height of that column
  getHeightOfMinorMusclesList() {
    RenderBox _dynamicMinorMusclesBox =
        _minorMusclesList.currentContext.findRenderObject();
    _minorListHeight = _dynamicMinorMusclesBox.size.height;
    setState(() {
      _minorListHeight = _minorListHeight;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => getHeightOfMinorMusclesList());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MyUtility(context).screenHeight;

    final arguments =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    final exerciseName = arguments['title'];

    final selectedExercise =
        Provider.of<ExerciseProvider>(context)
            .findByName(exerciseName);

    final topAppBar = AppBar(
      title: Text(exerciseName),
      backgroundColor: Theme.of(context).primaryColorDark,
      actions: <Widget>[
        IconButton(
          icon: Icon(selectedExercise.favorite ? Icons.star : Icons.star_border),
          onPressed: () {
            setState(() {
              selectedExercise.toggleFavoriteStatus();
            });
            }
        ),
      ],
    );

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

    List<Muscle> sortedMinorMuscles = (selectedExercise.minor).toList();
    sortedMinorMuscles = sortedMinorMuscles
      ..sort((a, b) => a.toString().compareTo(b.toString()));

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: topAppBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(screenHeight * 0.02),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(screenHeight * 0.03),
                child:
                    Image.asset(selectedExercise.animation, fit: BoxFit.cover),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: _minorListHeight,
                    child: Column(
                      children: <Widget>[
                        Text('Primary', style: theme.textTheme.body2),
                        Text(
                          muscleText(selectedExercise.major),
                          style: theme.textTheme.body1,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    key: _minorMusclesList,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Secondary',
                        style: theme.textTheme.body2,
                      ),
                      for (int i = 0; i < sortedMinorMuscles.length; i++)
                        Text(
                          muscleText(sortedMinorMuscles[i]),
                          style: theme.textTheme.body1,
                        ),
                      if (sortedMinorMuscles.length == 0)
                        Text('None', style: theme.textTheme.body1)
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * .04),
            Text('Steps', style: theme.textTheme.body2),
            for (int i = 0; i < selectedExercise.steps.length; i++)
              ListTile(
                dense: true,
                leading: CircleAvatar(
                  child: Text('${i + 1}.', style: theme.textTheme.body2),
                  backgroundColor: Colors.red,
                ),
                title: Text(
                  selectedExercise.steps[i],
                  style: theme.textTheme.body1,
                ),
              ),
            SizedBox(height: screenHeight * .04),
            Text('Common Mistakes', style: theme.textTheme.body2),
            for (int i = 0; i < selectedExercise.commonMistakes.length; i++)
              ListTile(
                dense: true,
                leading: CircleAvatar(
                  child: Text(
                    '-',
                    style: theme.textTheme.body2,
                  ),
                  backgroundColor: Colors.transparent,
                ),
                title: Text(
                  selectedExercise.commonMistakes[i],
                  style: theme.textTheme.body1,
                ),
              ),
            SizedBox(height: screenHeight * .04),
            Text('Tips', style: theme.textTheme.body2),
            for (int i = 0; i < selectedExercise.tips.length; i++)
              ListTile(
                dense: true,
                leading: CircleAvatar(
                  child: Text(
                    '-',
                    style: theme.textTheme.body2,
                  ),
                  backgroundColor: Colors.transparent,
                ),
                title: Text(
                  selectedExercise.tips[i],
                  style: theme.textTheme.body1,
                ),
              ),
            SizedBox(height: screenHeight * .04),
          ],
        ),
      ),
    );
  }
}
