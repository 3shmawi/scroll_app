import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll/layout/cubit/cubit.dart';
import 'package:scroll/layout/cubit/states.dart';
import 'package:scroll/modules/comments/reply_comment_screen.dart';
import 'package:scroll/modules/likes/liked_screen.dart';
import 'package:scroll/shared/styles/icon_broken.dart';

import '../../shared/components/constants.dart';

class CommentScreen extends StatefulWidget {
  String postId;
  int index;

  CommentScreen(this.index, this.postId, {Key? key}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  var commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MasterCubit, MasterStates>(
      listener: (context, state) {
        if (state is SetCommentsSuccessState) {
          commentController.clear();
          MasterCubit.get(context).updateCountOfComments(
              widget.postId, MasterCubit.get(context).comments.length);
        }
      },
      builder: (context, state) {
        var cubit = MasterCubit.get(context);
        var userModel = MasterCubit.get(context).user;
        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 5.0,
                      ),
                      cubit.allPosts[widget.index].postLikes.isNotEmpty
                          ? Expanded(
                              child: InkWell(
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.favorite,
                                      color: Colors.redAccent,
                                      size: 22,
                                    ),
                                    Text(
                                      '  ${cubit.allPosts[widget.index].postLikes.length} ',
                                    ),
                                    const Icon(
                                      IconBroken.Arrow___Right_2,
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LikedScreen(),
                                    ),
                                    (route) {
                                      return true;
                                    },
                                  );
                                },
                              ),
                            )
                          : Text(
                              'Be the first to like this',
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        fontSize: 16.0,
                                      ),
                            ),
                      if (cubit.allPosts[widget.index].postLikes.isEmpty)
                        const Spacer(),
                      IconButton(
                        onPressed: () {
                          cubit.likeUnlikePost(
                              cubit.allPosts[widget.index].postID);
                        },
                        icon: Icon(
                          cubit.allPosts[widget.index].postLikes.contains(uId)
                              ? Icons.favorite_outlined
                              : IconBroken.Heart,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey[300],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    child: CircleAvatar(
                                      radius: 25.0,
                                      backgroundImage: NetworkImage(
                                        '${cubit.comments[index].commentUser!.image}',
                                      ),
                                    ),
                                    onTap: () {},
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Card(
                                          color: Colors.grey[200],
                                          clipBehavior: Clip.antiAlias,
                                          elevation: 3.0,
                                          margin: const EdgeInsets.all(3.0),
                                          borderOnForeground: true,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 3.0,
                                                  left: 5.0,
                                                ),
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                      child: Text(
                                                        '  ${cubit.comments[index].commentUser!.name}  ',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle1,
                                                      ),
                                                      onTap: () {},
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                    InkWell(
                                                      child: Text(
                                                        'follow',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .caption
                                                            ?.copyWith(
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                      ),
                                                      onTap: () {},
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0,
                                                    left: 25.0,
                                                    top: 0.0),
                                                child: ExpandableText(
                                                  '${cubit.comments[index].commentText}',
                                                  expandText: 'Show more',
                                                  collapseText: 'Show less',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Text(
                                                daysBetween(DateTime.parse(cubit
                                                    .comments[index].dateTime
                                                    .toString())),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption,
                                              ),
                                            ),
                                            const Spacer(),
                                            InkWell(
                                              child: Text(
                                                '  Reply  ',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption
                                                    ?.copyWith(
                                                      color: Colors.blue,
                                                    ),
                                              ),
                                              onTap: () {
                                                cubit.getReplyComments(
                                                  commentId: cubit
                                                      .comments[index]
                                                      .commentID!,
                                                  postId: widget.postId,
                                                );
                                                Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ReplyCommentScreen(
                                                          cubit.comments[index],
                                                            widget.postId,
                                                            cubit
                                                                .comments[index]
                                                                .commentID!,),
                                                  ),
                                                  (route) {
                                                    return true;
                                                  },
                                                );
                                              },
                                              borderRadius:
                                                  BorderRadius.circular(3.0),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 10.0,
                              ),
                              itemCount: cubit.comments.length,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // const Spacer(),
                  Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey[300],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          IconBroken.Camera,
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
                              controller: commentController,
                              decoration: const InputDecoration(
                                hintText: 'Write a public comment',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          cubit.setComments(
                              text: commentController.text,
                              user: userModel!,
                              postId: widget.postId);
                        },
                        icon: const Icon(
                          IconBroken.Send,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
