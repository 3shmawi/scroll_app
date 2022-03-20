import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll/layout/cubit/cubit.dart';
import 'package:scroll/layout/cubit/states.dart';
import 'package:scroll/models/user_model.dart';
import '../../shared/components/constants.dart';
import '../../shared/styles/icon_broken.dart';
import '../comments/comment_screen.dart';
import '../likes/liked_screen.dart';
import '../show_expanded_photo/show_expanded_photo.dart';

class ShowUserProfile extends StatelessWidget {
  UserModel userModel;

  ShowUserProfile(this.userModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MasterCubit, MasterStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MasterCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                IconBroken.Arrow___Left_2,
              ),
            ),
            title: const Text(
              'profile info...',
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 0.0,
                  margin: const EdgeInsets.all(
                    8.0,
                  ),
                  child: SizedBox(
                    height: 210.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Image(
                            image: NetworkImage(
                              '${userModel.coverImage}',
                            ),
                            fit: BoxFit.cover,
                            height: 150.0,
                            width: double.infinity,
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        CircleAvatar(
                          radius: 64.0,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: CircleAvatar(
                            radius: 60.0,
                            backgroundImage: NetworkImage(
                              '${userModel.image}',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  '${userModel.name}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  '${userModel.bio}',
                  style: Theme.of(context).textTheme.caption,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '${userModel.uPosts.length}',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text(
                                'Posts',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: () {},
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '${userModel.userPhotos!.length}',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text(
                                'Photos',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: () {},
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '10k',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text(
                                'Followers',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: () {},
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '15',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text(
                                'Following',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: () {},
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Card(
                    margin: const EdgeInsets.all(1),
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      childAspectRatio: 0.76,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(
                        userModel.userPhotos!.length,
                        (index) => Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Container(
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(5)),
                            child: InkWell(
                              child: Image(
                                image: NetworkImage(
                                  userModel.userPhotos![index],
                                ),
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ShowExpandedPhoto(
                                      userModel.userPhotos![index],
                                    ),
                                  ),
                                  (route) {
                                    return true;
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all( 8.0),
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                ListView.separated(
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
                                    '${userModel.image}',
                                  ),
                                ),
                                onTap: () {
                                  // cubit.getProfileUser(cubit.allPosts[index].uId!);
                                  // Navigator.pushAndRemoveUntil(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         ShowUserProfile(
                                  //           cubit.profileUser!,
                                  //         ),
                                  //   ),
                                  //       (route) {
                                  //     return true;
                                  //   },
                                  // );
                                },
                                borderRadius: BorderRadius.circular(25),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    child: Text(
                                      '${userModel.name}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2
                                          ?.copyWith(
                                            height: 1.4,
                                            fontSize: 15.50,
                                          ),
                                    ),
                                    onTap: () {
                                      // cubit.getProfileUser(cubit.allPosts[index].uId!);
                                      // Navigator.pushAndRemoveUntil(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         ShowUserProfile(
                                      //           cubit.profileUser!,
                                      //         ),
                                      //   ),
                                      //       (route) {
                                      //     return true;
                                      //   },
                                      // );
                                    },
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  Text(
                                    daysBetween(
                                      DateTime.parse(
                                        userModel.uPosts[index].dateTime
                                            .toString(),
                                      ),
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        ?.copyWith(height: 1.4, fontSize: 10),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Container(
                              width: double.infinity,
                              height: 1.0,
                              color: Colors.grey[300],
                            ),
                          ),
                          Text(
                            '${userModel.uPosts[index].postText}',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          if (userModel.uPosts[index].postImage != null)
                            const SizedBox(
                              height: 10.0,
                            ),
                          if (userModel.uPosts[index].postImage != null)
                            Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              elevation: 5.0,
                              margin: const EdgeInsets.all(0),
                              child: InkWell(
                                child: Image(
                                  image: NetworkImage(
                                    '${userModel.uPosts[index].postImage}',
                                  ),
                                  fit: BoxFit.cover,
                                  height: 330.0,
                                  width: double.infinity,
                                ),
                                onTap: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ShowExpandedPhoto(
                                        userModel.uPosts[index].postImage,
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
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: (userModel
                                          .uPosts[index].postLikes.isEmpty)
                                      ? const SizedBox()
                                      : InkWell(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
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
                                                  '${userModel.uPosts[index].postLikes.length}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption,
                                                ),
                                              ],
                                            ),
                                          ),
                                          onTap: () {
                                            cubit.getPostUsersLikes(
                                                userModel.uPosts[index].postID);
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
                                            '${cubit.countOfComments[userModel.uPosts[index].postID] ?? 0} comment',
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption,
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      cubit.getComments(
                                          postId:
                                              userModel.uPosts[index].postID!);
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CommentScreen(
                                            index,
                                            userModel.uPosts[index].postID!,
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
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    cubit.getComments(
                                        postId: cubit.allPosts[index].postID!);
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CommentScreen(
                                            index,
                                            userModel.uPosts[index].postID!),
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
                                      userModel.uPosts[index].postLikes
                                              .contains(uId)
                                          ? Icons.favorite_outlined
                                          : IconBroken.Heart,
                                      size: 18.0,
                                      color: Colors.red,
                                    ),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    userModel.uPosts[index].postLikes
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
                  itemCount: userModel.uPosts.length,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
