import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
import 'package:scroll/shared/network/remote/dio_helper.dart';
import 'package:scroll/shared/styles/themes.dart';

import 'models/notificationModel.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //makeToast('On Background Messaging App : ${message.data.toString()}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  await DioHelper.init();

  var token = await FirebaseMessaging.instance.getToken();

  debugPrint(token.toString());

  // handle firebase Messaging FCM ............
  FirebaseMessaging.onMessage.listen((event) {
    NotificationModel model = NotificationModel(
        senderName: event.data['senderUser'],
        senderImage: event.data['senderImage'],
        dateTime: event.data['dateTime']);
    notificationList.add(model);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    NotificationModel model = NotificationModel(
        senderName: event.data['senderUser'],
        senderImage: event.data['senderImage'],
        dateTime: event.data['dateTime']);
    notificationList.add(model);
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Widget widget;
  uId = CacheHelper.getData(key: 'uId');
  //CacheHelper.removeData(key: 'uId');
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
            ..getUserData()
            ..getNotifications(),
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
                  //return const Test();
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
