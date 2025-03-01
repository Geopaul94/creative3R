import 'package:bloc/bloc.dart';
import 'package:creative/data/models/profile/profile_model.dart';
import 'package:creative/data/repository/profile/profile.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileInitialEvent>(_profileInitialEvent);
  }
  Future<void> _profileInitialEvent(
      ProfileInitialEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    try {
      final ProfileModel profileModel = await ProfileApi().fetchProfile();
      emit(ProfileSuccessState(profileModel: profileModel));
    } catch (e) {
      emit(ProfileErrorState(error: e.toString()));
    }
  }
}
