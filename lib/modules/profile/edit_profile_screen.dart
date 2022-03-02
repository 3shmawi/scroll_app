import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll/layout/cubit/cubit.dart';
import 'package:scroll/layout/cubit/states.dart';
import 'package:scroll/modules/profile/edit_cover_image_screen.dart';
import 'package:scroll/modules/profile/edit_profile_bio_screen.dart';
import 'package:scroll/modules/profile/edit_profile_image_screen.dart';
import 'package:scroll/modules/profile/edit_profile_name_screen.dart';
import 'package:scroll/modules/profile/edit_profile_phone_screen.dart';
import 'package:scroll/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MasterCubit, MasterStates>(
      listener: (context, state) {
        if (state is GetUserDataSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var user = MasterCubit.get(context).user;
        var cubit = MasterCubit.get(context);
        nameController.text = user!.name!;
        bioController.text = user.bio!;
        phoneController.text = user.phone!;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                cubit.profileImageUrl = cubit.user!.image!;
                cubit.coverImageUrl = cubit.user!.coverImage!;
                Navigator.pop(context);
              },
              icon: const Icon(
                IconBroken.Arrow___Left_2,
              ),
            ),
            title: const Text(
              'Edit Profile',
            ),
            titleSpacing: 0.0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state is UpdateUserDataLoadingState)
                    const LinearProgressIndicator(),
                  if (state is UpdateUserDataLoadingState)
                    const SizedBox(
                      height: 3.0,
                    ),
                  Row(
                    children: [
                      Text(
                        'Profile Picture',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const Spacer(),
                      OutlinedButton(
                        onPressed: () {
                          cubit.getProfileImage();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const EditProfileImageScreen(),
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
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: CircleAvatar(
                      radius: 70.0,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 66.0,
                        backgroundImage: NetworkImage(
                          cubit.profileImageUrl,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      height: 1.0,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Cover Photo',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const Spacer(),
                      OutlinedButton(
                        onPressed: () {
                          cubit.getCoverImage();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const EditCoverImageScreen(),
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
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image(
                      image: NetworkImage(
                        cubit.coverImageUrl,
                      ),
                      fit: BoxFit.cover,
                      height: 170.0,
                      width: double.infinity,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      height: 1.0,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Name',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      const Spacer(),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const EditProfileNameScreen(),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      nameController.text,
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      height: 1.0,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Bio',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      const Spacer(),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const EditProfileBioScreen(),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      bioController.text,
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      height: 1.0,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Phone Number',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      const Spacer(),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const EditProfilePhoneScreen(),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      phoneController.text,
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      height: 1.0,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
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
