part of 'profile_cubit.dart';

enum ProfileStatus{initial,submit,success,error, loading}

class ProfileCubitState extends Equatable{
  final ProfileStatus status;
  final String validator,validatorString,id,gender,selectDistrict,districtId, selectDob,farmerSince;
  final String? profileImage;
  final TextEditingController emailController;
  final TextEditingController farmSize;
  final TextEditingController dairyArea;
  final TextEditingController staffQuantity;
  final TextEditingController managerName;
  final TextEditingController managerPhone;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final TextEditingController addressSearchController;
  final TextEditingController nameController;
  final TextEditingController landlineController;
  final TextEditingController profilePic;
  final TextEditingController countryController;
  final TextEditingController countyController;
  final TextEditingController parishController;
  final TextEditingController villageController;
  final TextEditingController centreNameController;
  final TextEditingController districtController;
  final bool passwordVisible,confirmVisible;
  final ResponseProfile? responseProfile;
  final farmer_profile.Data? responseFarmerProfile;
  final List<DistrictData> ? districtResponse;
  final List<DistrictData> ? searchDistrictList;
  final int? selectedBreedIndex;

  const ProfileCubitState({
    required this.status,
    required this.id,
    required this.profileImage,
    required this.selectDob,
    required this.farmerSince,
    required this.gender,
    required this.selectDistrict,
    required this.districtId,
    required this.farmSize,
    required this.dairyArea,
    required this.staffQuantity,
    required this.managerName,
    required this.managerPhone,
    required this.responseProfile,
    required this.emailController,
    required this.validator,
    required this.searchDistrictList,
    required this.validatorString,
    required this.phoneController,
    required this.addressSearchController,
    required this.addressController,
    required this.nameController,
    required this.passwordVisible,
    required this.confirmVisible,
    required this.profilePic,
    required this.responseFarmerProfile,
    required this.districtResponse,
    required this.centreNameController,
    required this.villageController,
    required this.countryController,
    required this.parishController,
    required this.countyController,
    required this.districtController,
    required this.selectedBreedIndex,
    required this.landlineController,
  });

  factory ProfileCubitState.initial() {
    return ProfileCubitState(
      status: ProfileStatus.initial,
      emailController: TextEditingController(),
      nameController: TextEditingController(),
      addressSearchController: TextEditingController(),
      landlineController: TextEditingController(),
      managerName: TextEditingController(),
      managerPhone: TextEditingController(),
      farmSize: TextEditingController(),
      dairyArea: TextEditingController(),
      staffQuantity: TextEditingController(),
      validator: '',
      profileImage: "",
      gender: 'Male',
      selectDistrict: '',
      responseProfile: null,
      id: '',
      selectDob: '',
      farmerSince: '',
      validatorString: '',
      profilePic: TextEditingController(),
      phoneController: TextEditingController(),
      addressController: TextEditingController(),
      centreNameController: TextEditingController(),
      countyController: TextEditingController(),
      countryController: TextEditingController(),
      parishController: TextEditingController(),
      villageController: TextEditingController(),
        districtController: TextEditingController(),
      passwordVisible: true,
      confirmVisible: true,
      responseFarmerProfile: null,
      districtResponse: null,
      searchDistrictList: null,
      districtId: '',
      selectedBreedIndex: 0,
    );
  }


  ProfileCubitState copyWith({
    ProfileStatus? status,
    TextEditingController? emailController,
    TextEditingController? landlineController,
    TextEditingController? nameController,
    TextEditingController? addressSearchController,
    ResponseProfile? responseProfile,
    TextEditingController? passwordController,
    TextEditingController? phoneController,
    TextEditingController? addressController,
    TextEditingController? villageController,
    TextEditingController? countryController,
    TextEditingController? parishController,
    TextEditingController? countyController,
    TextEditingController? centreNameController,
    TextEditingController? districtController,
    String? token,validator,validatorString,id,gender,selectDistrict,districtId, selectDob,farmerSince,profileImage,
    bool? passwordVisible,confirmVisible,
    TextEditingController? profilePic,farmSize,dairyArea,staffQuantity,managerName,managerPhone,
    farmer_profile.Data? responseFarmerProfile,
    List<DistrictData> ? districtResponse,
    List<DistrictData> ? searchDistrictList,
    int? selectedBreedIndex,
  }) {
    return ProfileCubitState(
      status: status ?? this.status,
      id: id ?? this.id,
      profileImage: profileImage ?? this.profileImage,
      selectDob: selectDob ?? this.selectDob,
      farmerSince: farmerSince ?? this.farmerSince,
      gender: gender ?? this.gender,
        selectDistrict: selectDistrict ?? this.selectDistrict,
        districtId: districtId ?? this.districtId,
      managerName: managerName ?? this.managerName,
      managerPhone: managerPhone ?? this.managerPhone,
      staffQuantity: staffQuantity ?? this.staffQuantity,
      dairyArea: dairyArea ?? this.dairyArea,
      farmSize: farmSize ?? this.farmSize,
      responseProfile: responseProfile ?? this.responseProfile,
      nameController: nameController ?? this.nameController,
      addressSearchController: addressSearchController ?? this.addressSearchController,
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
      districtResponse: districtResponse ?? this.districtResponse,
        searchDistrictList: searchDistrictList ?? this.searchDistrictList,
        centreNameController:centreNameController ?? this.centreNameController,
        countryController:countryController ?? this.countryController,
        countyController:countyController ?? this.countyController,
        parishController:parishController ?? this.parishController,
        villageController:villageController ?? this.villageController,
      districtController:districtController ?? this.districtController,
        selectedBreedIndex: selectedBreedIndex?? this.selectedBreedIndex,
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
    addressSearchController,
    districtResponse,
    searchDistrictList,
    selectDistrict,
    countyController,
    countryController,
    villageController,
    parishController,
    centreNameController,
    districtController,
    districtId,
    landlineController,
    farmerSince,
    selectDob,
    selectedBreedIndex,
  ];

}