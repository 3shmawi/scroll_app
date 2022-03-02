import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll/layout/cubit/cubit.dart';
import 'package:scroll/layout/cubit/states.dart';
import 'package:scroll/layout/home_screen.dart';
import 'package:scroll/modules/login/login_screen.dart';
import 'package:scroll/modules/splash/splash.dart';
import 'package:scroll/shared/bloc_observer.dart';
import 'package:scroll/shared/components/constants.dart';
import 'package:scroll/shared/network/local/cache_helper.dart';
import 'package:scroll/shared/styles/themes.dart';
import 'package:scroll/unused/az_sencs_22_calculator/az_sencs_22.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();

  Widget widget;
  uId = CacheHelper.getData(key: 'uId');


  if (uId != null) {
    widget = const Home();
  } else {
    widget = const LoginScreen();
  }
  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  final Widget startWidget;

  MyApp({Key? key, required this.startWidget}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MasterCubit()
            ..getUsersDataPosts()
            ..getUserData(),
        ),
      ],
      child: BlocConsumer<MasterCubit, MasterStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: FutureBuilder(
              future: _fbApp,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  debugPrint(
                    'You have an error! ${snapshot.error.toString()}',
                  );
                  return const Text(
                    'Something went wrong!',
                  );
                } else if (snapshot.hasData) {
                  //return const Calculator();
                  return SecondPage(startWidget: startWidget);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
