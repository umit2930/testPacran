part of 'profile_cubit.dart';

enum ProfileStatus { init, loading, success, error }

class ProfileState extends Equatable {
  const ProfileState(
      {required this.profileStatus, this.profileResponse, this.errorMessage});

  final ProfileStatus profileStatus;
  final ProfileResponse? profileResponse;
  final String? errorMessage;


  @override
  List<Object?> get props => [profileStatus, profileResponse, errorMessage];

  ProfileState copyWith({
    ProfileStatus? profileStatus,
    ProfileResponse? profileResponse,
    String? errorMessage,
  }) {
    return ProfileState(
      profileStatus: profileStatus ?? this.profileStatus,
      profileResponse: profileResponse ?? this.profileResponse,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
