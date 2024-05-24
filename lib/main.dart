import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:users_model/hive/hive_boxes/shopping_box.dart';
import 'package:users_model/screens/post_description_screen/post_description_screen.dart';
import 'bottom_nav_bar.dart';
import 'models/hive_model.dart';
import 'providers/app_provider.dart';
import 'providers/hive_provider.dart';
import 'providers/user_provider.dart';
import 'providers/post_provider.dart';
// import 'services/api_service.dart';
import 'services/user_service.dart';
import 'services/post_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(HiveModelAdapter());
  await Hive.openBox('shopping_box');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //! Creating a single instance of ApiService to be used by other services.
    //! Alternatively, if you declare apiService as a parameter in the providers below
    // final apiService = ApiService();

    //! Wrapping the app with MultiProvider to provide multiple services.
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppProvider(),),

        //! Providing UserProvider to the widget tree.
        ChangeNotifierProvider(
          create: (_) => UserProvider(userService: UserService()),

          //! Alternatively, if you declare apiService as a parameter
          // UserProvider(userService: UserService(apiService: apiService)),
        ),
        //! Providing PostProvider to the widget tree.
        ChangeNotifierProvider(
          create: (_) => PostProvider(postService: PostService()),),

          ChangeNotifierProvider(
          create: (_) => HiveProvider(shoppingBox: ShoppingBox()),

          //! Alternatively, if you declare apiService as a parameter
          // PostProvider(postService: PostService(apiService: apiService)),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const BottomNavBar(), //! Setting the home screen of the app.
        routes: <String, WidgetBuilder>{
          '/root': (BuildContext context) => const BottomNavBar(),
          '/postDescription': (BuildContext context) =>
              const PostDescriptionScreen(),
        },
      ),
    );
  }
}
