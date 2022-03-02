import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll/layout/cubit/cubit.dart';
import 'package:scroll/layout/cubit/states.dart';
import 'package:scroll/modules/profile/edit_profile_screen.dart';
import 'package:scroll/shared/styles/icon_broken.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MasterCubit, MasterStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = MasterCubit.get(context).user;
        var cubit = MasterCubit.get(context);
        return SingleChildScrollView(
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
                            '${userModel!.coverImage}',
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
                              '${cubit.user!.uPosts.length}',
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
                              '265',
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
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text(
                          'Add Photos',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfileScreen(),
                          ),
                          (route) {
                            return true;
                          },
                        );
                      },
                      child: const Icon(
                        IconBroken.Edit,
                        size: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
