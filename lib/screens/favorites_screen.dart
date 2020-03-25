import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/exercise_provider.dart';
import '../widgets/exercise_card.dart';
import '../models/exercise.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    List<Exercise> favorites = Provider.of<ExerciseProvider>(context).favorites;
    return favorites.isEmpty
        ? Center(
            child: Text('Favorite an exercise by clicking on the star'),
          )
        : ListView.builder(
        itemBuilder: (ctx, index) {
          return ChangeNotifierProvider.value(
            value: favorites[index],
                      child: ExerciseCard(
              // favorites[index].name,
              // favorites[index].overall,
              // favorites[index].image,
              // favorites[index].level,
            ),
          );
        },
        itemCount: favorites.length,
      );
  }
}
