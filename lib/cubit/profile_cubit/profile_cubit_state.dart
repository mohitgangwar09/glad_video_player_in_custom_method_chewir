part of 'profile_cubit.dart';

enum ProfileStatus{initial,submit,success,error}

class ProfileCubitState extends Equatable{
  final ProfileStatus status;
  final String validator,validatorString,id;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final TextEditingController profilePic;
  final bool passwordVisible,confirmVisible;
  final ResponseProfile? responseProfile;

  const ProfileCubitState({
    required this.status,
    required this.id,
    required this.responseProfile,
    required this.emailController,
    required this.validator,
    required this.validatorString,
    required this.phoneController,
    required this.addressController,
    required this.passwordVisible,
    required this.confirmVisible,
    required this.profilePic,
  });

  factory ProfileCubitState.initial() {
    return ProfileCubitState(
      status: ProfileStatus.initial,
      emailController: TextEditingController(),
      validator: '',
      responseProfile: null,
      id: '',
      validatorString: '',
      profilePic: TextEditingController(),
      phoneController: TextEditingController(),
      addressController: TextEditingController(),
      passwordVisible: true,
      confirmVisible: true,
    );
  }

  ProfileCubitState copyWith({
    ProfileStatus? status,
    TextEditingController? emailController,
    ResponseProfile? responseProfile,
    TextEditingController? passwordController,
    TextEditingController? phoneController,
    TextEditingController? addressController,
    String? token,validator,validatorString,id,
    bool? passwordVisible,confirmVisible,
    TextEditingController? profilePic
  }) {
    return ProfileCubitState(
      status: status ?? this.status,
      id: id ?? this.id,
      responseProfile: responseProfile ?? this.responseProfile,
      emailController: emailController ?? this.emailController,
      phoneController: phoneController ?? this.phoneController,
      addressController: addressController ?? this.addressController,
      passwordVisible: passwordVisible ?? this.passwordVisible,
      confirmVisible: confirmVisible ?? this.confirmVisible,
      validator: validator ?? this.validator,
      profilePic: profilePic ?? this.profilePic,
      validatorString: validatorString ?? this.validatorString,
    );
  }

  @override
  List<Object?> get props => [
    status,
    emailController,
    responseProfile,
    addressController,
    phoneController,
    passwordVisible,
    confirmVisible,
    validator,
    validatorString,
    profilePic,
  ];

}