import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/exercise.dart';
import '../myUtility.dart';
import '../screens/exercise_detail_screen.dart';

class ExerciseCard extends StatefulWidget {
  // final String title;
  // final double overall;
  // final String imagePath;
  // final Level level;

  // ExerciseCard(this.title, this.overall, this.imagePath, this.level);

  @override
  _ExerciseCardState createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  @override
  Widget build(BuildContext context) {
    final exercise = Provider.of<Exercise>(context, listen: false);
    final screenHeight = Platform.isIOS
        ? MyUtility(context).screenHeight
        : MyUtility(context).screenHeight * 1.35;
    final screenWidth = MyUtility(context).screenWidth;

    void selectExercise(BuildContext context) {
      Navigator.of(context).pushNamed(
        ExerciseDetailScreen.routeName,
        arguments: {
          'title': exercise.name,
        },
      );
    }

    String levelText(level) {
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
                    exercise.image,
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
                        exercise.name,
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
                    'Overall: ${exercise.overall}',
                  ),
                  Text(
                    '${levelText(exercise.level)}',
                  ),
                  IconButton(
                    color: Theme.of(context).textTheme.body1.color,
                      icon: Icon(
                          exercise.favorite ? Icons.star : Icons.star_border),
                      onPressed: () {
                        setState(() {
                          exercise.toggleFavoriteStatus();
                        });
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
