import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll/layout/cubit/cubit.dart';
import 'package:scroll/layout/cubit/states.dart';
import 'package:scroll/modules/comments/comment_screen.dart';
import 'package:scroll/modules/likes/liked_screen.dart';
import 'package:scroll/shared/components/constants.dart';
import 'package:scroll/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return BlocConsumer<MasterCubit, MasterStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = MasterCubit.get(context);
            return cubit.allPosts.isEmpty ||
                    state is GetUsersDataPostsLoadingState
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () {
                      cubit.getUsersDataPosts();
                      return cubit.getUserData();
                    },
                    child: ListView.separated(
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
                                        '${cubit.allPosts[index].uImage}',
                                      ),
                                    ),
                                    onTap: () {
                                      cubit.changeBottomNavigationBar(4);
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
                                          '${cubit.allPosts[index].uName}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2
                                              ?.copyWith(
                                                height: 1.4,
                                                fontSize: 15.50,
                                              ),
                                        ),
                                        onTap: () {
                                          cubit.changeBottomNavigationBar(4);
                                        },
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      Text(
                                        daysBetween(DateTime.parse(cubit
                                            .allPosts[index].dateTime
                                            .toString())),
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            ?.copyWith(
                                                height: 1.4, fontSize: 10),
                                      ),
                                      // Text(
                                      //   '${cubit.allPosts[index].dateTime}',
                                      //   style: Theme.of(context)
                                      //       .textTheme
                                      //       .caption
                                      //       ?.copyWith(height: 1.4, fontSize: 10),
                                      // ),
                                    ],
                                  ),
                                  const Spacer(),
                                  // SizedBox(
                                  //   width: 10,
                                  //   child: PopupMenuButton(
                                  //     itemBuilder: (context) => [
                                  //       PopupMenuItem(
                                  //         child: Row(
                                  //           children: const [
                                  //             Text(
                                  //               'delete',
                                  //             ),
                                  //             Icon(Icons.delete_outline,)
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ],
                                  //     child: const Icon(
                                  //       Icons.more_vert,
                                  //     ),
                                  //     elevation: 10,
                                  //     offset: Offset.zero,
                                  //   ),
                                  // ),
                                  // const SizedBox(
                                  //   width: 20.0,
                                  // ),
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
                                '${cubit.allPosts[index].postText}',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(
                              //     bottom: 10.0,
                              //     top: 5.0,
                              //   ),
                              //   child: SizedBox(
                              //     width: double.infinity,
                              //     child: Wrap(
                              //       children: [
                              //         Padding(
                              //           padding: const EdgeInsetsDirectional.only(
                              //               end: 6.0),
                              //           child: SizedBox(
                              //             height: 25.0,
                              //             child: MaterialButton(
                              //               onPressed: () {},
                              //               minWidth: 1.0,
                              //               padding: EdgeInsets.zero,
                              //               child: Text(
                              //                 '#software',
                              //                 style: Theme.of(context)
                              //                     .textTheme
                              //                     .caption
                              //                     ?.copyWith(
                              //                       color: defaultColor,
                              //                     ),
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //         Padding(
                              //           padding: const EdgeInsetsDirectional.only(
                              //               end: 6.0),
                              //           child: SizedBox(
                              //             height: 25.0,
                              //             child: MaterialButton(
                              //               onPressed: () {},
                              //               minWidth: 1.0,
                              //               padding: EdgeInsets.zero,
                              //               child: Text(
                              //                 '#flutter',
                              //                 style: Theme.of(context)
                              //                     .textTheme
                              //                     .caption
                              //                     ?.copyWith(
                              //                       color: defaultColor,
                              //                     ),
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              if (cubit.allPosts[index].postImage != null)
                                const SizedBox(
                                  height: 10.0,
                                ),
                              if (cubit.allPosts[index].postImage != null)
                                Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  elevation: 5.0,
                                  margin: const EdgeInsets.all(0),
                                  child: Image(
                                    image: NetworkImage(
                                      '${cubit.allPosts[index].postImage}',
                                    ),
                                    fit: BoxFit.cover,
                                    height: 180.0,
                                    width: double.infinity,
                                  ),
                                ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: (cubit.allPosts[index].postLikes
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
                                                      '${cubit.allPosts[index].postLikes.length}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              onTap: () {
                                                cubit.getPostUsersLikes(cubit
                                                    .allPosts[index].postID);
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
                                                '${cubit.countOfComments[cubit.allPosts[index].postID] ?? 0} comment',
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
                                                  .allPosts[index].postID!);
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CommentScreen(
                                                index,
                                                cubit.allPosts[index].postID!,
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
                                                cubit.allPosts[index].postID!);
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => CommentScreen(
                                                index,
                                                cubit.allPosts[index].postID!),
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
                                          cubit.allPosts[index].postLikes
                                                  .contains(uId)
                                              ? Icons.favorite_outlined
                                              : IconBroken.Heart,
                                          size: 18.0,
                                          color: Colors.red,
                                        ),
                                        const SizedBox(
                                          width: 5.0,
                                        ),
                                        cubit.allPosts[index].postLikes
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
                                          cubit.allPosts[index].postID);
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
                      itemCount: cubit.allPosts.length,
                    ),
                  );
          },
        );
      },
    );
  }
}
