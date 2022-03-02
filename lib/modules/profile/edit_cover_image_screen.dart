import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll/layout/cubit/cubit.dart';
import 'package:scroll/layout/cubit/states.dart';
import 'package:scroll/shared/styles/icon_broken.dart';

class EditCoverImageScreen extends StatelessWidget {
  const EditCoverImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MasterCubit, MasterStates>(
      listener: (context, state) {
        if (state is UploadCoverImageSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var coverImage = MasterCubit.get(context).coverImage;
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
                        'Drag to adjust',
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
                            cubit.uploadNewCoverImage();
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
                if (state is UploadCoverImageLoadingState)
                  const LinearProgressIndicator(),
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
                            image: coverImage == null
                                ? NetworkImage(
                                    '${userModel!.coverImage}',
                                  ) as ImageProvider
                                : FileImage(coverImage),
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
                            backgroundImage: NetworkImage('${userModel!.image}'),
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
              ],
            ),
          ),
        );
      },
    );
  }
}
