import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll/layout/cubit/cubit.dart';
import 'package:scroll/layout/cubit/states.dart';
import 'package:scroll/shared/styles/icon_broken.dart';

class EditProfileImageScreen extends StatefulWidget {
  const EditProfileImageScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileImageScreen> createState() => _EditProfileImageScreenState();
}

class _EditProfileImageScreenState extends State<EditProfileImageScreen> {
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MasterCubit, MasterStates>(
      listener: (context, state) {
        if (state is UploadProfileImageSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var profileImage = MasterCubit.get(context).profileImage;
        var userModel = MasterCubit.get(context).user;
        var cubit = MasterCubit.get(context);
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 8.0,
                    left: 8.0,
                    top: 8.0,
                    bottom: 5.0,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          IconBroken.Arrow___Left_2,
                          color: Colors.redAccent,
                        ),
                      ),
                      Text(
                        'Preview profile picture',
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              color: Colors.black87,
                              fontSize: 16,
                            ),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 40,
                        width: 90,
                        child: OutlinedButton(
                          onPressed: () {
                            cubit.uploadNewProfileImage();
                          },
                          child: const Text('SAVE'),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1.0,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
                if (state is UploadProfileImageLoadingState)
                  const LinearProgressIndicator(),
                const SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            const CircleAvatar(
                              radius: 165,
                              backgroundColor: Colors.blueAccent,
                            ),
                            CircleAvatar(
                              radius: 160.0,
                              backgroundImage: profileImage == null
                                  ? NetworkImage('${userModel!.image}')
                                      as ImageProvider
                                  : FileImage(profileImage),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          height: 1.0,
                          width: double.infinity,
                          color: Colors.grey[400],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              color: Colors.black12,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: TextFormField(
                                controller: textController,
                                maxLines: 16,
                                decoration: const InputDecoration(
                                  hintText:
                                      'Say something about your profile picture...',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
