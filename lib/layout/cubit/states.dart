abstract class MasterStates {}

class MasterInitialState extends MasterStates {}

// bottomNavigationBar States

class ChangeBottomNavBarState extends MasterStates {}

class NewPostScreenState extends MasterStates {}

//Change Like Icon State

class ChangeLikeIconState extends MasterStates {}

//Get UserData

class GetUserDataLoadingState extends MasterStates {}

class GetUserDataSuccessState extends MasterStates {}

class GetUserDataErrorState extends MasterStates {}

//Get Profile User Info

class GetProfileUserInfoLoadingState extends MasterStates {}

class GetProfileUserInfoSuccessState extends MasterStates {}

class GetProfileUserInfoErrorState extends MasterStates {}

//Get Users Data Posts

class GetUsersDataPostsLoadingState extends MasterStates {}

class GetUsersDataPostsSuccessState extends MasterStates {}

class GetUsersDataPostsErrorState extends MasterStates {}

//Set Users Data Posts Like

class SetUsersDataPostsLikesSuccessState extends MasterStates {}

class SetUsersDataPostsLikesErrorState extends MasterStates {}

//Get Users Data Posts Like

class GetUsersDataPostsLikesSuccessState extends MasterStates {}

class GetUsersDataPostsLikesErrorState extends MasterStates {}

//Set Users Data Posts Dis Like

class SetUsersDataPostsDisLikesSuccessState extends MasterStates {}

class SetUsersDataPostsDisLikesErrorState extends MasterStates {}

//PickedImage

//profile
class ProfileImagePickedSuccessState extends MasterStates {}

class ProfileImagePickedErrorState extends MasterStates {}

//cover
class CoverImagePickedSuccessState extends MasterStates {}

class CoverImagePickedErrorState extends MasterStates {}

//new post
class NewPostImagePickedSuccessState extends MasterStates {}

class NewPostImagePickedErrorState extends MasterStates {}

//remove picked image from new post

class RemoveNewPostImagePickedState extends MasterStates {}

//Uploading Profile Image

class UploadProfileImageLoadingState extends MasterStates {}

class UploadProfileImageSuccessState extends MasterStates {}

class UploadProfileImageErrorState extends MasterStates {}

//Uploading Cover Image

class UploadCoverImageLoadingState extends MasterStates {}

class UploadCoverImageSuccessState extends MasterStates {}

class UploadCoverImageErrorState extends MasterStates {}

//Update UserData

class UpdateUserDataLoadingState extends MasterStates {}

class UpdateUserDataErrorState extends MasterStates {}

//Create New Post

class UploadNewPostImageState extends MasterStates {}

class CreateNewPostLoadingState extends MasterStates {}

class CreateNewPostSuccessState extends MasterStates {}

class CreateNewPostErrorState extends MasterStates {}

//Delete Post

class DeletePostLoadingState extends MasterStates {}

class DeletePostSuccessState extends MasterStates {}

class DeletePostErrorState extends MasterStates {}

//Users And Messages

class GetChatUsersInfoLoadingState extends MasterStates {}

class GetChatUsersInfoSuccessState extends MasterStates {}

class GetChatUsersInfoErrorState extends MasterStates {}

class SendMessageSuccessState extends MasterStates {}

class SendMessageErrorState extends MasterStates {}

class GetMessageLoadingState extends MasterStates {}

class GetMessageSuccessState extends MasterStates {}

//like post

class LikePostsSuccessState extends MasterStates {}

class LikePostsErrorState extends MasterStates {}

class UnLikePostsSuccessState extends MasterStates {}

class UnLikePostsErrorState extends MasterStates {}

//who like

class GetLikedUsersLoadingState extends MasterStates {}

class GetLikedUsersSuccessState extends MasterStates {}

class GetLikedUsersErrorState extends MasterStates {}

//like comment

class LikeCommentSuccessState extends MasterStates {}

class LikeCommentErrorState extends MasterStates {}

class UnLikeCommentSuccessState extends MasterStates {}

class UnLikeCommentErrorState extends MasterStates {}

//who like

class GetCommentLikedUsersLoadingState extends MasterStates {}

class GetCommentLikedUsersSuccessState extends MasterStates {}

class GetCommentLikedUsersErrorState extends MasterStates {}

//*//update user data

class EditProfileUpdatePhotoLoadingState extends MasterStates {}

class EditProfileUpdatePhotoSuccessState extends MasterStates {}

class EditProfileUpdatePhotoErrorState extends MasterStates {}

//*******

class EditProfileUpdatePhotosListSuccessState extends MasterStates {}

class EditProfileUpdatePhotosListErrorState extends MasterStates {}

//********

class EditProfileUpdateNameLoadingState extends MasterStates {}

class EditProfileUpdateNameSuccessState extends MasterStates {}

class EditProfileUpdateNameErrorState extends MasterStates {}

//************

class EditProfileUpdatePhoneLoadingState extends MasterStates {}

class EditProfileUpdatePhoneSuccessState extends MasterStates {}

class EditProfileUpdatePhoneErrorState extends MasterStates {}

//**********

class EditProfileUpdateBioLoadingState extends MasterStates {}

class EditProfileUpdateBioSuccessState extends MasterStates {}

class EditProfileUpdateBioErrorState extends MasterStates {}

//*//comments of post states

//set comment of post
class SetCommentsLoadingState extends MasterStates {}

class SetCommentsSuccessState extends MasterStates {}

class SetCommentsErrorState extends MasterStates {}

//get comments of post
class GetCommentsLoadingState extends MasterStates {}

class GetCommentsSuccessState extends MasterStates {}

class GetCommentsErrorState extends MasterStates {}

//*//reply comments states

//set reply of comment
class SetReplyCommentsLoadingState extends MasterStates {}

class SetReplyCommentsSuccessState extends MasterStates {}

class SetReplyCommentsErrorState extends MasterStates {}

//get reply of comments
class GetReplyCommentsLoadingState extends MasterStates {}

class GetReplyCommentsSuccessState extends MasterStates {}

class GetReplyCommentsErrorState extends MasterStates {}





//*******************
class GetLastChatSuccessState extends MasterStates {}
//
// //*//likes states
//
// //set like
// class SetLikesLoadingState extends MasterStates {}
//
// class SetLikesSuccessState extends MasterStates {}
//
// class SetLikesErrorState extends MasterStates {}
//
// //set unLike
//
// class SetUnLikesLoadingState extends MasterStates {}
//
// class SetUnLikesSuccessState extends MasterStates {}
//
// class SetUnLikesErrorState extends MasterStates {}
//
// //get likes
// class GetLikesLoadingState extends MasterStates {}
//
// class GetLikesSuccessState extends MasterStates {}
//
// class GetLikesErrorState extends MasterStates {}

//num of comments

class GetNumOfCommentsSuccessState extends MasterStates {}

class UpdateNumOfCommentsSuccessState extends MasterStates {}

//*//SignOut States
class SignOutSuccessState extends MasterStates {}

class SignOutErrorState extends MasterStates {}

class GetSuccessState extends MasterStates {}

//*// Search States

class SearchLoadingState extends MasterStates {}
class SearchSuccessState extends MasterStates {}