part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileErrorState extends ProfileState {
  final String error;

  ProfileErrorState({required this.error});
}

class ProfileSuccessState extends ProfileState {final ProfileModel profileModel;

  ProfileSuccessState({required this.profileModel});
}
