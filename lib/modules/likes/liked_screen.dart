import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll/layout/cubit/cubit.dart';
import 'package:scroll/layout/cubit/states.dart';
import 'package:scroll/shared/styles/icon_broken.dart';

import '../../models/user_model.dart';

class LikedScreen extends StatelessWidget {
  const LikedScreen({Key? key}) : super(key: key);

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
                color: Colors.red,
              ),
            ),
            title: Text(
              'Likes',
              style:
                  Theme.of(context).textTheme.caption?.copyWith(fontSize: 18),
            ),
          ),
          body: state is GetLikedUsersLoadingState
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        //  physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 25.0,
                                        backgroundImage: NetworkImage(
                                          '${cubit.usersWhoLikes![index].image}',
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15.0,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${cubit.usersWhoLikes![index].name}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              '${cubit.usersWhoLikes![index].bio}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {},
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              //const Spacer(),
                              OutlinedButton(
                                onPressed: () {},
                                child: Text(
                                  'Follow',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ),
                            ],
                          ),
                        ),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 5.0,
                        ),
                        itemCount: cubit.usersWhoLikes!.length,
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }

  Widget whoLikesPostItemBuilder(UserModel likerUser, context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(likerUser.image.toString()),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  likerUser.name.toString(),
                  style: Theme.of(context).textTheme.bodyText2!,
                ),
                likerUser.bio == null
                    ? const SizedBox()
                    : Text(
                        likerUser.bio.toString(),
                        style: Theme.of(context).textTheme.caption!,
                      )
              ],
            )
          ],
        ),
      ),
    );
  }
}
