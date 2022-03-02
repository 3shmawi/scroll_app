import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll/layout/cubit/cubit.dart';
import 'package:scroll/layout/cubit/states.dart';
import 'package:scroll/shared/styles/icon_broken.dart';

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MasterCubit, MasterStates>(
      listener: (context, state) {
        if (state is CreateNewPostSuccessState) {
          textController.clear();
          MasterCubit.get(context).removePickedPostImage();
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = MasterCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                textController.clear();
                cubit.removePickedPostImage();
              },
              icon: const Icon(
                IconBroken.Arrow___Left_2,
              ),
            ),
            title: const Text(
              'Create Post',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (cubit.postImage == null) {
                    if (textController.text.isNotEmpty) {
                      cubit.createNewPost(postText: textController.text);
                    }
                  } else {
                    cubit.uploadNewPostImage(
                      postText: textController.text,
                    );
                  }
                },
                child: const Text(
                  'POST',
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is CreateNewPostLoadingState)
                  const LinearProgressIndicator(),
                if (state is CreateNewPostLoadingState)
                  const SizedBox(
                    height: 5.0,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                        '${cubit.user!.image}',
                      ),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Text(
                        '${cubit.user!.name}',
                        style: const TextStyle(
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    maxLength: 400,
                    maxLines: null,
                    minLines: null,
                    //  expands: true,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      hintText: 'What\'s on your mind?...',
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      border: OutlineInputBorder(),
                    ),
                    textAlign: TextAlign.start,
                    controller: textController,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                if (cubit.postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 200.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            4.0,
                          ),
                          image: DecorationImage(
                              image: FileImage(cubit.postImage!),
                              fit: BoxFit.cover),
                        ),
                      ),
                      IconButton(
                        icon: const CircleAvatar(
                          radius: 20.0,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.close,
                            size: 16.0,
                            color: Colors.redAccent,
                          ),
                        ),
                        onPressed: () {
                          cubit.removePickedPostImage();
                        },
                      ),
                    ],
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          cubit.getNewPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              IconBroken.Image,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'add photo',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          '# tags',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
