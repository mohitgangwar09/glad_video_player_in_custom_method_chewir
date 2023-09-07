part of 'profile_cubit.dart';

enum ProfileStatus{initial,submit,success,error}

class ProfileCubitState extends Equatable{
  final ProfileStatus status;
  final String validator,validatorString,id,gender,selectDob,farmerSince;
  final String? profileImage;
  final TextEditingController emailController;
  final TextEditingController farmSize;
  final TextEditingController dairyArea;
  final TextEditingController staffQuantity;
  final TextEditingController managerName;
  final TextEditingController managerPhone;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final TextEditingController nameController;
  final TextEditingController landlineController;
  final TextEditingController profilePic;
  final bool passwordVisible,confirmVisible;
  final ResponseProfile? responseProfile;
  final farmer_profile.Data? responseFarmerProfile;

  const ProfileCubitState({
    required this.status,
    required this.id,
    required this.profileImage,
    required this.selectDob,
    required this.farmerSince,
    required this.gender,
    required this.farmSize,
    required this.dairyArea,
    required this.staffQuantity,
    required this.managerName,
    required this.managerPhone,
    required this.responseProfile,
    required this.emailController,
    required this.validator,
    required this.validatorString,
    required this.phoneController,
    required this.addressController,
    required this.nameController,
    required this.passwordVisible,
    required this.confirmVisible,
    required this.profilePic,
    required this.responseFarmerProfile,
    required this.landlineController,
  });

  factory ProfileCubitState.initial() {
    return ProfileCubitState(
      status: ProfileStatus.initial,
      emailController: TextEditingController(),
      nameController: TextEditingController(),
      landlineController: TextEditingController(),
      managerName: TextEditingController(),
      managerPhone: TextEditingController(),
      farmSize: TextEditingController(),
      dairyArea: TextEditingController(),
      staffQuantity: TextEditingController(),
      validator: '',
      profileImage: "",
      gender: 'Male',
      responseProfile: null,
      id: '',
      selectDob: '',
      farmerSince: '',
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
    TextEditingController? landlineController,
    TextEditingController? nameController,
    ResponseProfile? responseProfile,
    TextEditingController? passwordController,
    TextEditingController? phoneController,
    TextEditingController? addressController,
    String? token,validator,validatorString,id,gender,selectDob,farmerSince,profileImage,
    bool? passwordVisible,confirmVisible,
    TextEditingController? profilePic,farmSize,dairyArea,staffQuantity,managerName,managerPhone,
    farmer_profile.Data? responseFarmerProfile,
  }) {
    return ProfileCubitState(
      status: status ?? this.status,
      id: id ?? this.id,
      profileImage: profileImage ?? this.profileImage,
      selectDob: selectDob ?? this.selectDob,
      farmerSince: farmerSince ?? this.farmerSince,
      gender: gender ?? this.gender,
      managerName: managerName ?? this.managerName,
      managerPhone: managerPhone ?? this.managerPhone,
      staffQuantity: staffQuantity ?? this.staffQuantity,
      dairyArea: dairyArea ?? this.dairyArea,
      farmSize: farmSize ?? this.farmSize,
      responseProfile: responseProfile ?? this.responseProfile,
      nameController: nameController ?? this.nameController,
      emailController: emailController ?? this.emailController,
      landlineController: landlineController ?? this.landlineController,
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
    profileImage,
    farmSize,
    dairyArea,
    staffQuantity,
    managerName,
    managerPhone,
    addressController,
    phoneController,
    passwordVisible,
    confirmVisible,
    validator,
    validatorString,
    profilePic,
    responseFarmerProfile,
    gender,
    landlineController,
    farmerSince,
    selectDob
  ];

}