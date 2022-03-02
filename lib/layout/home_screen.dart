import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll/layout/cubit/cubit.dart';
import 'package:scroll/layout/cubit/states.dart';
import 'package:scroll/modules/add_post/new_post_screen.dart';
import 'package:scroll/modules/login/login_screen.dart';
import 'package:scroll/modules/search/search_screen.dart';
import 'package:scroll/shared/styles/icon_broken.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<MasterCubit, MasterStates>(
      listener: (context, state) {
        if (state is NewPostScreenState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const NewPostScreen(),
            ),
            (route) {
              return true;
            },
          );
        }
        if (state is SignOutSuccessState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) {
              return false;
            },
          );
        }
      },
      builder: (context, state) {
        var cubit = MasterCubit.get(context);
        String myName = '';

        if (cubit.user != null) {
          if (cubit.user!.name!.contains(' ')) {
            for (int i = 0; i < cubit.user!.name!.length; i++) {
              if (cubit.user!.name![i] == ' ') {
                break;
              }
              myName += cubit.user!.name![i];
            }
          }
        }
        return cubit.user != null
            ? Scaffold(
                appBar: AppBar(
                  title: AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText(
                        'Welcome $myName!',
                        textStyle:
                            Theme.of(context).textTheme.bodyText1?.copyWith(
                                  color: Colors.black87,
                                  fontSize: 18.0,
                                  overflow: TextOverflow.ellipsis,
                                ),
                      ),
                      WavyAnimatedText(
                        'I wish u have a good time.',
                        textStyle:
                            Theme.of(context).textTheme.bodyText1?.copyWith(
                                  color: Colors.black54,
                                  fontSize: 15.0,
                                ),
                      ),
                    ],
                    repeatForever: true,
                    isRepeatingAnimation: true,
                  ),
                  elevation: 5,
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SearchScreen(),
                            ), (route) {
                          return true;
                        });
                      },
                      icon: const Icon(
                        IconBroken.Search,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: IconButton(
                          onPressed: () {
                            cubit.signOut();
                          },
                          icon: const Icon(
                            IconBroken.Notification,
                          )),
                    ),
                  ],
                ),
                body: cubit.listOfScreens[cubit.currentIndex],
                bottomNavigationBar: Container(
                  margin: EdgeInsets.only(
                    //top: displayWidth * 0.01,
                    bottom: displayWidth * .05,
                    left: displayWidth * .02,
                    right: displayWidth * .01,
                  ),
                  height: displayWidth * .12,
                  width: displayWidth * .7,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.7),
                        blurRadius: 30,
                        spreadRadius: 5,
                        //offset: const Offset(0, 10),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(
                      right: 1,
                    ),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        cubit.changeBottomNavigationBar(index);
                        // setState(() {
                        //   cubit.currentIndex = index;
                        //   HapticFeedback.lightImpact();
                        // });
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Stack(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(seconds: 2),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width: index == cubit.currentIndex
                                ? displayWidth * .27
                                : displayWidth * .18,
                            alignment: Alignment.center,
                            child: AnimatedContainer(
                              duration: const Duration(seconds: 2),
                              curve: Curves.fastLinearToSlowEaseIn,
                              height: index == cubit.currentIndex
                                  ? displayWidth * .12
                                  : 0,
                              width: index == cubit.currentIndex
                                  ? displayWidth * .21
                                  : 0,
                              decoration: BoxDecoration(
                                color: index == cubit.currentIndex
                                    ? Colors.blueAccent.withOpacity(.2)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width: index == cubit.currentIndex
                                ? displayWidth * .31
                                : displayWidth * .18,
                            alignment: Alignment.center,
                            child: Stack(
                              children: [
                                Row(
                                  children: [
                                    AnimatedContainer(
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      width: index == cubit.currentIndex
                                          ? displayWidth * .12
                                          : 0,
                                    ),
                                    AnimatedOpacity(
                                      opacity:
                                          index == cubit.currentIndex ? 1 : 0,
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      child: Text(
                                        index == cubit.currentIndex
                                            ? cubit.listOfStrings[index]
                                            : '',
                                        style: const TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    AnimatedContainer(
                                      duration: const Duration(seconds: 2),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      width: index == cubit.currentIndex
                                          ? displayWidth * .04
                                          : 7,
                                    ),
                                    Icon(
                                      cubit.listOfIcons[index],
                                      size: displayWidth * .07,
                                      color: index == cubit.currentIndex
                                          ? Colors.blueAccent
                                          : Colors.black26,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
