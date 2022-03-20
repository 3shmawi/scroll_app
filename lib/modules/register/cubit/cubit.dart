import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll/models/user_model.dart';
import 'package:scroll/modules/register/cubit/states.dart';
import 'package:scroll/shared/network/local/cache_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  Future<void> userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    debugPrint('hello');

    emit(RegisterLoadingState());

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    )
        .then((value) {
      userCreate(
        userID: value.user!.uid,
        phone: phone,
        email: email,
        name: name,
      );
    }).catchError((error) {
      debugPrint(error.toString());
      emit(RegisterErrorState());
    });
  }

  late UserModel model;

  Future<void> userCreate({
    required String name,
    required String email,
    required String phone,
    required String userID,
  }) async {
    await FirebaseMessaging.instance.getToken().then((value) {
      UserModel model = UserModel(
        name: name,
        email: email,
        phone: phone,
        uId: userID,
        isEmailVerified: false,
        image:
            'https://e7.pngegg.com/pngimages/753/432/png-clipart-user-profile-2018-in-sight-user-conference-expo-business-default-business-angle-service-thumbnail.png',
        coverImage:
            'https://fedoramagazine.org/wp-content/uploads/2017/05/f23.png-768x480.jpg',
        uPosts: [],
        uToken: value,
        friends: [],
        bio: 'Write Your bio...',
        userPhotos: [],
      );
      FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .set(model.toMap())
          .then((value) {
        CacheHelper.saveData(key: 'uId', value: userID);
        emit(CreateUserSuccessState());
      }).catchError((error) {
        emit(CreateUserErrorState());
      });
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(RegisterChangePasswordVisibilityState());
  }


}
