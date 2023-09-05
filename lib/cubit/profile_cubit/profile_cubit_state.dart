part of 'profile_cubit.dart';

enum ProfileStatus{initial,submit,success,error}

class ProfileCubitState extends Equatable{
  final ProfileStatus status;
  final String validator,validatorString,id,gender;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final TextEditingController addressSearchController;
  final TextEditingController nameController;
  final TextEditingController profilePic;
  final bool passwordVisible,confirmVisible;
  final ResponseProfile? responseProfile;
  final farmer_profile.Data? responseFarmerProfile;

  const ProfileCubitState({
    required this.status,
    required this.id,
    required this.gender,
    required this.responseProfile,
    required this.emailController,
    required this.validator,
    required this.validatorString,
    required this.phoneController,
    required this.addressSearchController,
    required this.addressController,
    required this.nameController,
    required this.passwordVisible,
    required this.confirmVisible,
    required this.profilePic,
    required this.responseFarmerProfile,
  });

  factory ProfileCubitState.initial() {
    return ProfileCubitState(
      status: ProfileStatus.initial,
      emailController: TextEditingController(),
      nameController: TextEditingController(),
      addressSearchController: TextEditingController(),
      validator: '',
      gender: 'Male',
      responseProfile: null,
      id: '',
      validatorString: '',
      profilePic: TextEditingController(),
      phoneController: TextEditingController(),
      addressController: TextEditingController(),
      passwordVisible: true,
      confirmVisible: true,
      responseFarmerProfile: null,
    );
  }

  ProfileCubitState copyWith({
    ProfileStatus? status,
    TextEditingController? emailController,
    TextEditingController? nameController,
    TextEditingController? addressSearchController,
    ResponseProfile? responseProfile,
    TextEditingController? passwordController,
    TextEditingController? phoneController,
    TextEditingController? addressController,
    String? token,validator,validatorString,id,gender,
    bool? passwordVisible,confirmVisible,
    TextEditingController? profilePic,
    farmer_profile.Data? responseFarmerProfile,
  }) {
    return ProfileCubitState(
      status: status ?? this.status,
      id: id ?? this.id,
      gender: gender ?? this.gender,
      responseProfile: responseProfile ?? this.responseProfile,
      nameController: nameController ?? this.nameController,
      addressSearchController: addressSearchController ?? this.addressSearchController,
      emailController: emailController ?? this.emailController,
      phoneController: phoneController ?? this.phoneController,
      addressController: addressController ?? this.addressController,
      passwordVisible: passwordVisible ?? this.passwordVisible,
      confirmVisible: confirmVisible ?? this.confirmVisible,
      validator: validator ?? this.validator,
      profilePic: profilePic ?? this.profilePic,
      validatorString: validatorString ?? this.validatorString,
      responseFarmerProfile: responseFarmerProfile ?? this.responseFarmerProfile,
    );
  }

  @override
  List<Object?> get props => [
    status,
    emailController,
    nameController,
    responseProfile,
    addressController,
    phoneController,
    passwordVisible,
    confirmVisible,
    validator,
    validatorString,
    profilePic,
    responseFarmerProfile,
    gender,
    addressSearchController,
  ];

}