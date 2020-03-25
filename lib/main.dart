import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './quiz/questions/equipmentq_screen.dart';
import './providers/exercise_provider.dart';
import './models/exercise.dart';
import './data/database.dart';
import './screens/settings_screen.dart';
import './screens/tabs_screen.dart';
import './quiz/quizMain.dart';
import './screens/exercise_lists.dart';
import './screens/exercise_detail_screen.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Exercise> _availableExercises = Exercises;

  List<String> _getEquipmentNeeded(List<Equipment> equipment) {
    List<String> output = List<String>();
    for (int i = 0; i < equipment.length; i++) {
      if(equipment[i].toString().substring(10) == 'WeightMachine') {
        output.add('Weight machine');
      }
      else if(equipment[i].toString().substring(10) == 'CardioMachine') {
        output.add('Cardio machine');
      }
      else if(equipment[i].toString().substring(10) == 'DualCables') {
        output.add('Cables');
      }
      else if(equipment[i].toString().substring(10) == 'YogaMat') {
        output.add('Yoga mat');
      }
      else if(equipment[i].toString().substring(10) == 'PullUpBar') {
        output.add('Pull-up bar');
      }
      else if (!(equipment[i].toString().substring(10) == 'Bench')) {
        output.add(equipment[i].toString().substring(10));
      }
    }
    return output;
  }

  void _setEquipmentSettings() {
    setState(() {
      _availableExercises = Exercises.where((exercise) {
        if (_getEquipmentNeeded(exercise.equipment).isEmpty)
        {
          return true;
        }
        else if (EquipmentQuestionScreen.selection.contains(_getEquipmentNeeded(exercise.equipment)[0])){
          return true;
        }
        return false;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: null,
      builder: (context) => ExerciseProvider(),
          child: MaterialApp(
        title: 'Workout',
        theme: ThemeData(
          primarySwatch: Colors.red,
          backgroundColor: Color.fromRGBO(30, 30, 30, 1), //black
          disabledColor: Color.fromRGBO(76, 4, 4, 1),
          fontFamily: 'OpenSans',
          textTheme: ThemeData.dark().textTheme.copyWith(
                //main text theme
                title: TextStyle(
                  //header
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Color.fromRGBO(240, 240, 240, 1),
                ),
                body1: TextStyle(
                  //body
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  color: Color.fromRGBO(240, 240, 240, 1),
                ),
                body2: TextStyle(
                    //subheader
                    fontFamily: 'OpenSans',
                    fontSize: 21,
                    color: Color.fromRGBO(240, 240, 240, 1),
                    fontWeight: FontWeight.w600),
                display4: TextStyle(
                  //disabled subheader text (for a button)
                  fontFamily: 'OpenSans',
                  fontSize: 21,
                  color: Colors.grey[800],
                ),
              ),
          appBarTheme: AppBarTheme(
            //app bar text theme
            textTheme: ThemeData.dark().textTheme.copyWith(
                  title: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(240, 240, 240, 1),
                  ),
                ),
          ),
        ),
        home: QuizMain(),
        // routes: {
        //   ExerciseLists.routeName: (context) => ExerciseLists(),
        //   ExerciseMainScreen.routeName: (context) => ExerciseMainScreen(),
        //   ExerciseDetailScreen.routeName: (context) => ExerciseDetailScreen(),
        // },
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case TabsScreen.routeName:
              return Platform.isIOS
                  ? CupertinoPageRoute(
                      builder: (_) => TabsScreen(), settings: settings)
                  : MaterialPageRoute(
                      builder: (_) => TabsScreen(), settings: settings);
            case ExerciseLists.routeName:
              return Platform.isIOS
                  ? CupertinoPageRoute(
                      builder: (_) => ExerciseLists(),
                      settings: settings)
                  : MaterialPageRoute(
                      builder: (_) => ExerciseLists(),
                      settings: settings);
            case ExerciseDetailScreen.routeName:
              return Platform.isIOS
                  ? CupertinoPageRoute(
                      builder: (_) => ExerciseDetailScreen(), settings: settings)
                  : MaterialPageRoute(
                      builder: (_) => ExerciseDetailScreen(), settings: settings);
            case SettingsScreen.routeName:
              return Platform.isIOS
                  ? CupertinoPageRoute(
                      builder: (_) => SettingsScreen(),
                      settings: settings)
                  : MaterialPageRoute(
                      builder: (_) => SettingsScreen(),
                      settings: settings);
            default:
              return Platform.isIOS
                  ? CupertinoPageRoute(
                      builder: (_) => QuizMain(), settings: settings)
                  : CupertinoPageRoute(
                      builder: (_) => QuizMain(), settings: settings);
          }
        },
      ),
    );
  }
}

// CupertinoApp(
//       title: 'TBA',
//       theme: CupertinoThemeData(
//         primaryColor: CupertinoColors.systemRed,
//         brightness: Brightness.dark,
//         scaffoldBackgroundColor: CupertinoColors.black, //Color.fromRGBO(30, 30, 30, 1), //black
//         textTheme: CupertinoTextThemeData(
//           primaryColor: CupertinoColors.white,
//           textStyle: TextStyle(
//                 //body
//                 fontFamily: 'OpenSans',
//                 fontSize: 18,
//                 color: Color.fromRGBO(240, 240, 240, 1),
//               ),
//               navTitleTextStyle: TextStyle(
//                 //header
//                 fontFamily: 'Montserrat',
//                 fontWeight: FontWeight.bold,
//                 fontSize: 28,
//                 color: Color.fromRGBO(240, 240, 240, 1),
//               ),
//               tabLabelTextStyle: TextStyle(
//                   //subheader
//                   fontFamily: 'OpenSans',
//                   fontSize: 21,
//                   color: Color.fromRGBO(240, 240, 240, 1),
//                   fontWeight: FontWeight.w600),
//               navLargeTitleTextStyle: TextStyle(
//                   fontFamily: 'Montserrat',
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Color.fromRGBO(240, 240, 240, 1),
//                 ),
//               // display4: TextStyle(
//               //   //disabled subheader text (for a button)
//               //   fontFamily: 'OpenSans',
//               //   fontSize: 21,
//               //   color: Colors.grey[800],
//               // ),
//             ),
//       ),
//       home: QuizMain(),
//       routes: {
//         ExerciseLists.routeName: (context) => ExerciseLists(),
//         ExerciseMainScreen.routeName: (context) => ExerciseMainScreen(),
//         ExerciseDetailScreen.routeName: (context) => ExerciseDetailScreen(),
//       }
//     )
