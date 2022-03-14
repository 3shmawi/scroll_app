import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll/layout/cubit/cubit.dart';
import 'package:scroll/layout/cubit/states.dart';
import 'package:scroll/models/comment_model.dart';
import 'package:scroll/shared/styles/icon_broken.dart';

import '../../shared/components/constants.dart';

class ReplyCommentScreen extends StatefulWidget {
  String postId;
  String commentId;
  CommentModel model;

  ReplyCommentScreen(this.model,this.postId, this.commentId, {Key? key})
      : super(key: key);

  @override
  State<ReplyCommentScreen> createState() => _ReplyCommentScreenState();
}

class _ReplyCommentScreenState extends State<ReplyCommentScreen> {
  var replyCommentsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MasterCubit, MasterStates>(
      listener: (context, state) {
        if (state is SetReplyCommentsSuccessState) {
          replyCommentsController.clear();
        }
      },
      builder: (context, state) {
        var cubit = MasterCubit.get(context);
        var userModel = MasterCubit.get(context).user;
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              elevation: 10,
              leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                  icon: const Icon(IconBroken.Arrow___Left_2,),),
              title: const Text('Replying Comments',),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        child: CircleAvatar(
                          radius: 25.0,
                          backgroundImage: NetworkImage(
                            '${widget.model.commentUser!.image}',
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
                                            '  ${widget.model.commentUser!.name}  ',
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
                                        const Spacer(),
                                        Padding(
                                          padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            daysBetween(DateTime.parse(widget.model.dateTime
                                                .toString())),
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8.0,
                                        left: 25.0,
                                        top: 0.0,),
                                    child: ExpandableText(
                                      '${widget.model.commentText}',
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
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200]
                      ),
                      child:  Center(
                        child: Text('Replying of this comment...',
                        style: Theme.of(context).textTheme.caption,),
                      ),
                    ),
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
                                        '${cubit.replyComments[index].commentUser!.image}',
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
                                                        '  ${cubit.replyComments[index].commentUser!.name}  ',
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
                                                    const Spacer(),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 8.0),
                                                      child: Text(
                                                        daysBetween(DateTime.parse(cubit
                                                            .replyComments[index].dateTime
                                                            .toString())),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .caption,
                                                      ),
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
                                                  '${cubit.replyComments[index].commentText}',
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
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 10.0,
                              ),
                              itemCount: cubit.replyComments.length,
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
                              controller: replyCommentsController,
                              decoration: const InputDecoration(
                                hintText: 'Write your reply...',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          cubit.setReplyComments(
                              commentId: widget.commentId,
                              text: replyCommentsController.text,
                              user: userModel!,
                              postId: widget.postId,
                          );
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
