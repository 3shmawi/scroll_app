import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/styles/icon_broken.dart';

class EditProfileNameScreen extends StatelessWidget {
  const EditProfileNameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MasterCubit, MasterStates>(
      listener: (context, state) {
        if (state is EditProfileUpdateNameSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var nameController = TextEditingController();
        var userModel = MasterCubit.get(context).user;
        var cubit = MasterCubit.get(context);
        nameController.text = userModel!.name!;
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
                        'Preview profile name',
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
                            cubit.updateName(nameController.text);
                          },
                          child: const Text('UPDATE'),
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
                if (state is EditProfileUpdateNameLoadingState)
                  const LinearProgressIndicator(),
                const SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        maxLength: 20,
                        // maxLines: null,
                        minLines: null,
                        controller: nameController,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                        maxLines: 1,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          hintText: 'Name',
                          border: InputBorder.none,
                        ),
                      ),
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
