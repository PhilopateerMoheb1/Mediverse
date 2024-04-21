part of 'profile_edit_cubit.dart';

@immutable
abstract class ProfileEditState {}

class ProfileEditInitial extends ProfileEditState {}
class ProfileEditLoading extends ProfileEditState {}
class ProfileEditSuccess extends ProfileEditState {}
class ProfileEditFailure extends ProfileEditState {
  String errMsg;
  ProfileEditFailure(this.errMsg);
}
