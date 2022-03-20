import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scroll/layout/cubit/states.dart';
import 'package:scroll/models/comment_model.dart';
import 'package:scroll/models/post_model.dart';
import 'package:scroll/models/user_model.dart';
import 'package:scroll/modules/add_post/new_post_screen.dart';
import 'package:scroll/modules/chat/chat_screen.dart';
import 'package:scroll/modules/feeds/feed_screen.dart';
import 'package:scroll/modules/profile/profile_screen.dart';
import 'package:scroll/modules/requests/requests_screen.dart';
import 'package:scroll/shared/styles/icon_broken.dart';

import '../../models/message_model.dart';
import '../../models/notificationModel.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/network/remote/dio_helper.dart';

class MasterCubit extends Cubit<MasterStates> {
  MasterCubit() : super(MasterInitialState());

  static MasterCubit get(context) => BlocProvider.of(context);

  //*// BottomNavigationBar

  var currentIndex = 0;

  List<IconData> listOfIcons = [
    IconBroken.Home,
    IconBroken.Chat,
    IconBroken.Paper_Upload,
    IconBroken.User,
    IconBroken.Profile,
  ];

  List<String> listOfStrings = [
    'Home',
    'Chat',
    'Post',
    'Users',
    'Profile',
  ];

  List<Widget> listOfScreens = [
    const ProfileScreen(),
    const FeedsScreen(),
    ChatScreen(),
    const NewPostScreen(),
    const UsersScreen(),

  ];

  void changeBottomNavigationBar(int index) {
    if (index == 1) {
      getChatUsers();
    }

    if (index == 2) {
      emit(NewPostScreenState());
    } else {
      currentIndex = index;
      emit(ChangeBottomNavBarState());
    }
  }

  //*//User Data

  UserModel? user;

  Future<void> getUserData() async {
    emit(GetUserDataLoadingState());

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      //debugPrint(value.data());
      user = UserModel.fromJson(value.data());
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetUserDataErrorState());
    });
  }

  //*//get profile user

  UserModel? profileUser;

  List<PostModel> userProfilePosts = [];

  Future<void> getProfileUser(String userID) async {
    userProfilePosts.clear();
    emit(GetProfileUserInfoLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .get()
        .then((value) {
      profileUser = UserModel.fromJson(value.data());

      for (var element in allPosts) {
        if (element.uId == userID) {
          userProfilePosts.add(element);
        }
      }

      //friendOrUnfriend(profileUser);

      emit(GetProfileUserInfoSuccessState());
    }).onError((error, stack) {
      emit(GetProfileUserInfoErrorState());
      debugPrint(stack.toString());
      debugPrint(error.toString());
    });
  }

  //*//Image Picker
  final ImagePicker _picker = ImagePicker();

  //profile image

  File? profileImage;

  Future<void> getProfileImage() async {
    if (profileImage != null) {
      profileImage = null;
    }
    await _picker.pickImage(source: ImageSource.gallery).then((value) {
      profileImage = File(value!.path);
      emit(ProfileImagePickedSuccessState());
    }).catchError((error) {
      emit(ProfileImagePickedErrorState());
    });
  }

  //cover image
  File? coverImage;

  Future<void> getCoverImage() async {
    if (coverImage != null) {
      coverImage = null;
    }
    await _picker.pickImage(source: ImageSource.gallery).then((value) {
      coverImage = File(value!.path);
      emit(CoverImagePickedSuccessState());
    }).catchError((error) {
      emit(CoverImagePickedErrorState());
    });
  }

  //post image
  File? postImage;

  Future<void> getNewPostImage() async {
    if (postImage != null) {
      postImage = null;
    }
    await _picker.pickImage(source: ImageSource.gallery).then((value) {
      postImage = File(value!.path);
      emit(NewPostImagePickedSuccessState());
    }).catchError((error) {
      emit(NewPostImagePickedErrorState());
    });
  }

  //remove picked post image
  void removePickedPostImage() {
    postImage = null;
    emit(RemoveNewPostImagePickedState());
  }

  //*// Uploading New  Image

  //profile
  String profileImageUrl =
      'https://e7.pngegg.com/pngimages/753/432/png-clipart-user-profile-2018-in-sight-user-conference-expo-business-default-business-angle-service-thumbnail.png';

  void uploadNewProfileImage() {
    emit(UploadProfileImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profileImageUrl = value;
        debugPrint(value);
        updateProfilePhoto(value);
        emit(UploadProfileImageSuccessState());
      }).catchError((error) {
        debugPrint(error.toString());
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      debugPrint(error.toString());
      emit(UploadProfileImageErrorState());
    });
  }

  //cover
  String coverImageUrl =
      'https://fedoramagazine.org/wp-content/uploads/2017/05/f23.png-768x480.jpg';

  void uploadNewCoverImage() {
    emit(UploadCoverImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        coverImageUrl = value;
        updateCoverPhoto(value);
        emit(UploadCoverImageSuccessState());
        debugPrint(value);
      }).catchError((error) {
        emit(UploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(UploadCoverImageErrorState());
    });
  }

  //*//Update User Data

  void updateProfilePhoto(String newPhoto) {
    emit(EditProfileUpdatePhotoLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update({'image': newPhoto}).then((value) {
      addPhotoToUserPhotos(newPhoto);
      emit(EditProfileUpdatePhotoSuccessState());
    }).catchError((error) {
      debugPrint('error in update $error');
      emit(EditProfileUpdatePhotoErrorState());
    });
  }

  void addPhotoToUserPhotos(String newPhotoUrl) {
    List<String> photos = List.empty(growable: true);
    photos = (user!.userPhotos ?? []);
    photos.add(newPhotoUrl);

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update({'userPhotos': photos}).then((value) {
      emit(EditProfileUpdatePhotosListSuccessState());
      getUserData();
    }).catchError((error) {
      debugPrint(error.toString());
      emit(EditProfileUpdatePhotosListErrorState());
    });
  }

  void updateCoverPhoto(String newPhoto) {
    emit(EditProfileUpdatePhotoLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update({'coverImage': newPhoto}).then((value) {
      getUserData();
      emit(EditProfileUpdatePhotoSuccessState());
    }).catchError((error) {
      debugPrint('error in update $error');
      emit(EditProfileUpdatePhotoErrorState());
    });
  }

  void updateName(String newName) {
    emit(EditProfileUpdateNameLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update({'name': newName}).then((value) {
      emit(EditProfileUpdateNameSuccessState());
      getUserData();
    }).catchError((error) {
      emit(EditProfileUpdateNameErrorState());
    });
  }

// change Phone ..................................

  void updatePhone(String newPhone) {
    emit(EditProfileUpdatePhoneLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update({'phone': newPhone}).then((value) {
      emit(EditProfileUpdatePhoneSuccessState());
      getUserData();
    }).catchError((error) {
      emit(EditProfileUpdatePhoneErrorState());
    });
  }

//-------------------Update Bio ---------------------

  void updateBio(String newBio) {
    emit(EditProfileUpdateBioLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update({'bio': newBio}).then((value) {
      emit(EditProfileUpdateBioSuccessState());
      getUserData();
    }).catchError((error) {
      emit(EditProfileUpdateBioErrorState());
    });
  }

  //*//Create New Post

  void uploadNewPostImage({
    required String postText,
  }) {
    emit(CreateNewPostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createNewPost(
          postText: postText,
          postImage: value,
        );
        addPhotoToUserPhotos(value);
        debugPrint(value);
      }).catchError((error) {
        emit(CreateNewPostErrorState());
      });
    }).catchError((error) {
      emit(CreateNewPostErrorState());
    });
  }

  late PostModel postModel;

  void createNewPost({
    String? postText,
    String? postImage,
  }) {
    emit(CreateNewPostLoadingState());
    postModel = PostModel(
      uName: user!.name,
      uImage: user!.image,
      uId: user!.uId,
      dateTime: DateTime.now().toString(),
      postText: postText,
      postImage: postImage,
      postID: null,
      postLikes: [],
    );
    String postID = '';

    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      postID = value.id;
      FirebaseFirestore.instance
          .collection('posts')
          .doc(value.id)
          .update({'postID': value.id}).then((value) {
        postModel.postID = postID;
        addPostToUser(postModel);
        allPosts.add(postModel);
        updateCountOfComments(postID, 0);
      });
      //getUsersDataPosts();
      emit(CreateNewPostSuccessState());
    }).catchError((error) {
      emit(CreateNewPostErrorState());
    });
  }

  void deleteMyPost(String postId) {
    emit(DeletePostLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .delete()
        .then((value) {
      getUsersDataPosts();
      emit(DeletePostSuccessState());
    }).catchError((error) {
      emit(DeletePostErrorState());
    });
  }

  void addPostToUser(PostModel newPost) {
    List<PostModel> userPosts = [];
    userPosts = user!.uPosts;
    userPosts.add(newPost);

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update({'uPosts': userPosts.map((e) => e.toMap()).toList()})
        .then((value) => user!.uPosts.add(newPost))
        .catchError((error) {
          debugPrint(error.toString());
        });
  }

  //*//Get Users Data Posts to feeds

  late List<PostModel> allPosts = [];

  Future<void> getUsersDataPosts() async {
    emit(GetUsersDataPostsLoadingState());

    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .listen((value) {
      allPosts.clear();
      emit(GetUsersDataPostsSuccessState());
      for (var element in value.docs) {
        allPosts.add(PostModel.fromJson(element.data()));
        for (var element in allPosts) {
          getCountOfComments(element.postID!);
          if (element.uId == uId) {
            element.uName = user!.name;
            element.uImage = user!.image;
            //countOfMyPosts++;
          }
        }
      }
    });
  }

//Like / unlike a post --------------------------------------------------------------

  List<String> postLikesUID = [];

  Future<void> getPostLikes(String? postID) async {
    // for (var element in user!.uPosts) {
    //   if (element.postID == postID) {
    postLikesUID.clear();
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postID!)
        .get()
        .then(
      (value) {
        postLikesUID = List<String>.from(value.data()!['postLikes']);
        debugPrint('this post likes are : $postLikesUID');
      },
    );
    // } else {
    //   FirebaseFirestore.instance
    //       .collection('posts')
    //       .doc(postID!)
    //       .snapshots()
    //       .listen(
    //         (value) {
    //       postLikesUID = List<String>.from(value.data()!['postLikes']);
    //       debugPrint('this post likes are : $postLikesUID');
    //     },
    //   );
    // }
    // }
  }

  void likeUnlikePost(String? postID) {
    getPostLikes(postID).then((value) {
      postLikesUID.contains(user!.uId) ? unlike(postID!) : like(postID!);
    });
  }

  void like(String postID) {
    FirebaseFirestore.instance.collection('posts').doc(postID).update({
      'postLikes': FieldValue.arrayUnion([user!.uId])
    }).then((value) {
      // for (var element in allPosts) {
      //   if (element.postID == postID) {
      //     element.postLikes.add(user!.uId.toString());
      //   }
      // }

      for (var element in user!.uPosts) {
        if (element.postID == postID) {
          element.postLikes.add(user!.uId.toString());
        }
      }
      //getUsersDataPosts();

      emit(LikePostsSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(LikePostsErrorState());
    });
  }

  void unlike(String postID) {
    FirebaseFirestore.instance.collection('posts').doc(postID).update({
      'postLikes': FieldValue.arrayRemove([user!.uId])
    }).then((value) {
      // getPostLikes(postID);
      for (var element in allPosts) {
        if (element.postID == postID) {
          element.postLikes.remove(user!.uId.toString());
        }
      }

      for (var element in user!.uPosts) {
        if (element.postID == postID) {
          element.postLikes.remove(user!.uId.toString());
        }
      }
      //getUsersDataPosts();
      emit(UnLikePostsSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(UnLikePostsErrorState());
    });
  }

  // get users who Likes this post -------------------------------------

  List<UserModel>? usersWhoLikes = [];

  Future<void> getPostUsersLikes(String? postID) async {
    usersWhoLikes!.clear();
    emit(GetLikedUsersLoadingState());
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postID!)
        .get()
        .then((value) {
      for (var element in List<String>.from(value.data()!['postLikes'])) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(element)
            .get()
            .then((value) {
          usersWhoLikes!.add(UserModel.fromJson(value.data()));
          emit(GetLikedUsersSuccessState());
        });
      }
    });
  }

  //*// Get Users Model

  List<UserModel> chatUsers = [];

  Future<void> getChatUsers() async {
    emit(GetChatUsersInfoLoadingState());

    FirebaseFirestore.instance.collection('users').snapshots().listen((value) {
      chatUsers.clear();
      for (var element in value.docs) {
        if (element.id != user!.uId.toString()) {
          chatUsers.add(UserModel.fromJson(element.data()));
        }
      }

      emit(GetChatUsersInfoSuccessState());
    }).onError((error) {
      debugPrint(error.toString());
      emit(GetChatUsersInfoErrorState());
    });
  }

  void sendMessage({
    required String receiverID,
    required String text,
    required UserModel receiverUser,
  }) {
    MessageModel message = MessageModel(
      dateTime: DateTime.now().toString(),
      receiverId: receiverID,
      senderId: user!.uId,
      text: text,
    );

    ////////////// sender chat:

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(receiverID)
        .collection('messages')
        .add(message.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(SendMessageErrorState());
    });

    ////////////// receiver chat:

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverID)
        .collection('chats')
        .doc(uId)
        .collection('messages')
        .add(message.toMap())
        .then((value) {
      DioHelper.postData(
        senderUser: user!,
        receiverToken: receiverUser.uToken.toString(),
        dateTime: DateTime.now().toString(),
      ).then(
        (value) => saveNotifications(
          NotificationModel(
            senderName: user!.name,
            senderImage: user!.image,
            dateTime: DateTime.now().toString(),
          ),
        ),
      );
      emit(SendMessageSuccessState());
    }).catchError(
      (error) {
        debugPrint(error.toString());
        emit(SendMessageErrorState());
      },
    );
  }

// get Messages .........

  List<MessageModel> messages = [];

  void getMessages({required String receiverID}) {
    emit(GetMessageLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(receiverID)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages.clear();
      for (var element in event.docs) {
        messages.add(MessageModel.fromJson(element.data()));
      }
      emit(GetMessageSuccessState());
    });
  }

// get last message of chats*****************

  Map<String, dynamic> lastChat = {};

  void getLastChat() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .snapshots()
        .listen((value) {
      for (var element in value.docs) {
        lastChat.addAll(element.data());
      }
      emit(GetLastChatSuccessState());
    });
  }

  void updateLastChat(String lastText, String time, String receiverId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(receiverId)
        .set({
      'lastText': lastText,
      'dateTime': time,
    }).then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('chats')
          .doc(receiverId)
          .update({
        'lastText': lastText,
        'dateTime': time,
      }).then((value) {
        getLastChat();
      });
    });
  }

//*// ******SignOut**********

  void signOut() {
    FirebaseAuth.instance.signOut().then((value) {
      CacheHelper.removeData(key: 'uId');
      emit(SignOutSuccessState());
    }).catchError((error) {
      emit(SignOutErrorState());
    });
  }

//*// comments**********************

  //set comments****************
  void setComments({
    required String text,
    required UserModel user,
    required String postId,
  }) {
    emit(SetCommentsLoadingState());
    CommentModel comment = CommentModel(
      dateTime: DateTime.now().toString(),
      commentUser: user,
      commentID: null,
      commentText: text,
    );
    String commentId = '';
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(comment.toMap())
        .then((value) {
      commentId = value.id;
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .doc(value.id)
          .update({'commentID': value.id}).then((value) {
        comment.commentID = commentId;
        emit(SetCommentsSuccessState());
      }).catchError((error) {
        debugPrint(error.toString());
        emit(SetCommentsErrorState());
      });
    });
  }

  // get comments************************

  List<CommentModel> comments = [];

  void getComments({required String postId}) {
    emit(GetCommentsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      comments.clear();
      for (var element in event.docs) {
        comments.add(CommentModel.fromJson(element.data()));
        for (var element in comments) {
          if (element.commentUser!.uId == uId) {
            element.commentUser!.name = user!.name;
            element.commentUser!.image = user!.image;
          }
        }
      }
      emit(GetCommentsSuccessState());
    }).onError((error) {
      emit(GetCommentsErrorState());
    });
  }

  //*//reply of comments**********************

  //set reply of comments****************
  void setReplyComments({
    required String text,
    required UserModel user,
    required String postId,
    required String commentId,
  }) {
    emit(SetReplyCommentsLoadingState());
    CommentModel comment = CommentModel(
      dateTime: DateTime.now().toString(),
      commentUser: user,
      commentID: null,
      commentText: text,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .collection('reply')
        .add(comment.toMap())
        .then((value) {
      emit(SetReplyCommentsSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(SetReplyCommentsErrorState());
    });
  }

  // get comments************************

  List<CommentModel> replyComments = [];

  void getReplyComments({required String postId, required String commentId}) {
    emit(GetReplyCommentsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .collection('reply')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      replyComments.clear();
      for (var element in event.docs) {
        replyComments.add(CommentModel.fromJson(element.data()));
        for (var element in replyComments) {
          if (element.commentUser!.uId == uId) {
            element.commentUser!.name = user!.name;
            element.commentUser!.image = user!.image;
          }
        }
      }
      emit(GetReplyCommentsSuccessState());
    }).onError((error) {
      emit(GetReplyCommentsErrorState());
    });
  }

  // get count of comments*****************

  Map<String, dynamic> countOfComments = {};

  void getCountOfComments(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('commentsCount')
        .snapshots()
        .listen((value) {
      for (var element in value.docs) {
        countOfComments.addAll(element.data());
      }
      emit(GetNumOfCommentsSuccessState());
    });
  }

  void updateCountOfComments(String postId, int count) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('commentsCount')
        .doc('kali')
        .set({postId: count}).then((value) {
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('commentsCount')
          .doc('kali')
          .update({postId: count}).then((value) {
        getCountOfComments(postId);
      });
    });
  }

//*// Search post

  List<PostModel> searchResult = [];

  Future<void> search(String text) async {
    emit(SearchLoadingState());
    searchResult.clear();

    for (var element in allPosts) {
      if (element.postText!.contains(text)) {
        searchResult.add(element);
      }
    }

    emit(SearchSuccessState());
  }

  // save Notifications.......
  void saveNotifications(NotificationModel notification) {
    FirebaseFirestore.instance
        .collection('notifications')
        .add(notification.toMap());
  }

  //get notifications.........
  Future<void> getNotifications() async {
    notificationList.clear();
    await FirebaseFirestore.instance
        .collection('notifications')
        .orderBy('dateTime', descending: true)
        .get()
        .then((value) {
      for (var element in value.docs) {
        notificationList.add(NotificationModel.fromJson(element.data()));
      }
    });
  }
}
