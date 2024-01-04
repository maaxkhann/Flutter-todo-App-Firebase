import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/firebase_options.dart';
import 'package:to_do_app/view/auth_view/login_view.dart';
import 'package:to_do_app/view/tasks_view/tasks_list_view.dart';
import 'package:to_do_app/view_model/auth_view_model.dart';
import 'package:to_do_app/view_model/tasks_view_model.dart';
import 'package:to_do_app/view_model/user_profile_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  bool isLoggedIn = sharedPreferences.getBool('isLoggedIn') ?? false;
  runApp(MyApp(
    isLoggedIn: isLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => TasksViewModel()),
        ChangeNotifierProvider(create: (_) => UserProfileViewModel()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: isLoggedIn ? TasksListView() : LoginView(),
      ),
    );
  }
}
