import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';
import 'package:notes_app/bin/video_player.dart';
import 'package:notes_app/helpers/auth_path.dart';
import 'package:notes_app/screens/auth/login.dart';
import 'package:notes_app/screens/auth/signUp.dart';
import 'package:notes_app/screens/batches/completed_classes_screen.dart';
import 'package:notes_app/screens/course/select_course.dart';
import 'package:notes_app/screens/explore.dart';
import 'package:notes_app/screens/home/home.dart';
import 'package:notes_app/screens/home/question_bank_screen.dart';
import 'package:notes_app/screens/payments/checkout_page.dart';
import 'package:notes_app/screens/profile.dart';
import 'package:provider/provider.dart';

import './screens/tabs_screen.dart';
import './provider/data_provider.dart';
import './screens/tests/test_solutions.dart';
import './screens/tests/completed_tests_screen.dart';
import './screens/batches/live_video_play_screen.dart';
import './screens/batches/batch_details_screen.dart';
import './screens/batches/batches_screen.dart';
import './screens/batches/live_classes_screen.dart';
import './screens/batches/teacher_details_screen.dart';
import './screens/tests/tests_screen.dart';
import './screens/tests/full_length_tests_screen.dart';
import './screens/tests/level_up_screen.dart';
import './screens/tests/live_tests_screen.dart';
import './screens/tests/test_start_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Data(),
        )
      ],
      child: GetMaterialApp(
        title: 'Q-Box',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Bai',
          dividerColor: Colors.transparent,
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
          }),
          primaryColor: const Color(0xFFFFC600),
          primarySwatch: Colors.amber,
        ),
        home: AuthPath(),
        routes: {
          SelectCourse.routeName: (context) => SelectCourse(),
          TabsScreen.routeName: (_) => const TabsScreen(),
          Home.routeName: (_) => Home(),
          QuestionsBank.routeName: (_) => const QuestionsBank(),
          BatchesScreen.routeName: (_) => const BatchesScreen(),
          BatcheDetailsScreen.routeName: (_) => BatcheDetailsScreen(),
          TeacherDetailsScreen.routeName: (_) => const TeacherDetailsScreen(),
          TestsScreen.routeName: (_) => const TestsScreen(),
          LevelUpTestsScreen.routeName: (_) => LevelUpTestsScreen(),
          FullLengthTestsScreen.routeName: (_) => const FullLengthTestsScreen(),
          LiveTestsScreen.routeName: (_) => LiveTestsScreen(),
          TestStartScreen.routeName: (_) => const TestStartScreen(),
          TestSolutionsScreen.routeName: (_) => const TestSolutionsScreen(),
          LiveClassesScreen.routeName: (_) => const LiveClassesScreen(),
          LiveVideoPlayScreen.routeName: (_) => const LiveVideoPlayScreen(),
          CompletedTestsScreen.routeName: (_) => const CompletedTestsScreen(),
          DefaultPlayer.routeName: (_) => const DefaultPlayer(),
          Login.routeName: (_) => Login(),
          SignUp.routeName: (_) => SignUp(),
          Explore.routeName: (_) => Explore(),
          Profile.routeName: (_) => Profile(),
          AuthPath.routeName: (_) => AuthPath(),
          CompletedClassesScreen.routeName: (_) => CompletedClassesScreen(),
          // PaymentOption.routeName: (_) => PaymentOption(),
          CheckOut.routeName: (_) => CheckOut(),
        },
      ),
    );
  }
}