import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll/layout/cubit/cubit.dart';
import 'package:scroll/layout/cubit/states.dart';
import 'package:scroll/shared/styles/icon_broken.dart';

import '../../shared/components/constants.dart';
import '../comments/comment_screen.dart';
import '../likes/liked_screen.dart';
import '../show_expanded_photo/show_expanded_photo.dart';
import '../show_user_profile/show_user_profile.dart';

// class SizeTransition1 extends PageRouteBuilder {
//   final Widget page;
//
//   SizeTransition1(this.page)
//       : super(
//     pageBuilder: (context, animation, anotherAnimation) => page,
//     transitionDuration: const Duration(milliseconds: 1000),
//     reverseTransitionDuration: const Duration(milliseconds: 200),
//     transitionsBuilder: (context, animation, anotherAnimation, child) {
//       animation = CurvedAnimation(
//           curve: Curves.fastLinearToSlowEaseIn,
//           parent: animation,
//           reverseCurve: Curves.fastOutSlowIn);
//       return Align(
//         alignment: Alignment.bottomCenter,
//         child: SizeTransition(
//           sizeFactor: animation,
//           child: page,
//           axisAlignment: 0,
//         ),
//       );
//     },
//   );
// }

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MasterCubit, MasterStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MasterCubit.get(context);
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        IconBroken.Arrow___Left_2,
                        color: Colors.red,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 40.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.grey[300],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: TextFormField(
                            controller: searchController,
                            decoration: const InputDecoration(
                              hintText: 'Search',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        cubit.search(searchController.text);
                      },
                      icon: const Icon(
                        IconBroken.Send,
                        color: Colors.red,
                      ),
                    ),

                  ],
                ),
                state is SearchLoadingState ?
                const Center(
                  child: CircularProgressIndicator(),
                ) :ListView.separated(
                  shrinkWrap: true,
                  // reverse: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 10.0,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                child: CircleAvatar(
                                  radius: 25.0,
                                  backgroundImage: NetworkImage(
                                    '${cubit.searchResult[index].uImage}',
                                  ),
                                ),
                                onTap: () {
                                  cubit
                                      .getProfileUser(
                                      cubit.searchResult[index].uId!)
                                      .then(
                                        (value) {
                                      cubit.profileUser!.uId == uId
                                          ? cubit
                                          .changeBottomNavigationBar(4)
                                          : Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ShowUserProfile(
                                                cubit.profileUser!,
                                              ),
                                        ),
                                            (route) {
                                          return true;
                                        },
                                      );
                                    },
                                  );
                                },
                                borderRadius: BorderRadius.circular(25),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    child: Text(
                                      '${cubit.searchResult[index].uName}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2
                                          ?.copyWith(
                                        height: 1.4,
                                        fontSize: 15.50,
                                      ),
                                    ),
                                    onTap: () {
                                      cubit
                                          .getProfileUser(
                                          cubit.searchResult[index].uId!)
                                          .then(
                                            (value) {
                                          cubit.profileUser!.uId == uId
                                              ? cubit
                                              .changeBottomNavigationBar(4)
                                              : Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ShowUserProfile(
                                                    cubit.profileUser!,
                                                  ),
                                            ),
                                                (route) {
                                              return true;
                                            },
                                          );
                                        },
                                      );
                                    },
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  Text(
                                    daysBetween(DateTime.parse(cubit
                                        .searchResult[index].dateTime
                                        .toString())),
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        ?.copyWith(
                                        height: 1.4, fontSize: 10),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              PopupMenuButton(
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Icon(
                                          Icons.delete_outline,
                                          size: 18,
                                        ),
                                        Text(
                                          ' delete',
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        )
                                      ],
                                    ),
                                    onTap: () {},
                                  ),
                                ],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                color: Colors.grey[100],
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 15.0),
                            child: Container(
                              width: double.infinity,
                              height: 1.0,
                              color: Colors.grey[300],
                            ),
                          ),
                          Text(
                            '${cubit.searchResult[index].postText}',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          if (cubit.searchResult[index].postImage != null)
                            const SizedBox(
                              height: 10.0,
                            ),
                          if (cubit.searchResult[index].postImage != null)
                            Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              elevation: 5.0,
                              margin: const EdgeInsets.all(0),
                              child: InkWell(
                                child: Image(
                                  image: NetworkImage(
                                    '${cubit.searchResult[index].postImage}',
                                  ),
                                  fit: BoxFit.cover,
                                  height: 330.0,
                                  width: double.infinity,
                                ),
                                onTap: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ShowExpandedPhoto(
                                            cubit.searchResult[index].postImage,
                                          ),
                                    ),
                                        (route) {
                                      return true;
                                    },
                                  );
                                },
                              ),
                            ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: (cubit.searchResult[index].postLikes
                                      .isEmpty)
                                      ? const SizedBox()
                                      : InkWell(
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.symmetric(
                                          vertical: 5.0),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.favorite_outlined,
                                            size: 16.0,
                                            color: Colors.red,
                                          ),
                                          const SizedBox(
                                            width: 5.0,
                                          ),
                                          Text(
                                            '${cubit.searchResult[index].postLikes.length}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption,
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      cubit.getPostUsersLikes(cubit
                                          .searchResult[index].postID);
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                          const LikedScreen(),
                                        ),
                                            (route) {
                                          return true;
                                        },
                                      );
                                    },
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        children: [
                                          const Icon(
                                            IconBroken.Chat,
                                            size: 16.0,
                                            color: Colors.amber,
                                          ),
                                          const SizedBox(
                                            width: 5.0,
                                          ),
                                          Text(
                                            '${cubit.countOfComments[cubit.searchResult[index].postID] ?? 0} comment',
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption,
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      cubit.getComments(
                                          postId: cubit
                                              .searchResult[index].postID!);
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CommentScreen(
                                                index,
                                                cubit.searchResult[index].postID!,
                                              ),
                                        ),
                                            (route) {
                                          return true;
                                        },
                                      );
                                    },
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Container(
                              width: double.infinity,
                              height: 1.0,
                              color: Colors.grey[300],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 18.0,
                                        backgroundImage: NetworkImage(
                                          '${cubit.user!.image}',
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15.0,
                                      ),
                                      Text(
                                        'write a comment ...',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption,
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    cubit.getComments(
                                        postId:
                                        cubit.searchResult[index].postID!);
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CommentScreen(
                                            index,
                                            cubit.searchResult[index].postID!),
                                      ),
                                          (route) {
                                        return true;
                                      },
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              InkWell(
                                child: Row(
                                  children: [
                                    Icon(
                                      cubit.searchResult[index].postLikes
                                          .contains(uId)
                                          ? Icons.favorite_outlined
                                          : IconBroken.Heart,
                                      size: 18.0,
                                      color: Colors.red,
                                    ),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    cubit.searchResult[index].postLikes
                                        .contains(uId)
                                        ? const Text(
                                      'Liked',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )
                                        : const Text(
                                      'Like',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  cubit.likeUnlikePost(
                                      cubit.searchResult[index].postID);
                                },
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  itemCount: cubit.searchResult.length,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
