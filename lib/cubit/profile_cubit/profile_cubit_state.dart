part of 'profile_cubit.dart';

enum ProfileStatus{initial,submit,success,error, loading}

class ProfileCubitState extends Equatable{
  final ProfileStatus status;
  final String validator,validatorString,id,selectDistrict,districtId, selectDob,farmerSince;
  final String? profileImage,gender;
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
  final TextEditingController regionController;
  final TextEditingController countyController;
  final TextEditingController zipCodeController;
  final TextEditingController editAddressController;
  final TextEditingController centreNameController;
  final TextEditingController districtController;
  final bool passwordVisible,confirmVisible;
  final ResponseProfile? responseProfile;
  final farmer_profile.Data? responseFarmerProfile;
  final List<DistrictData> ? districtResponse;
  final List<DistrictData> ? searchDistrictList;
  final ResponseCountyList responseCountyList;
  final ResponseSubCounty responseSubCounty;
  final int? selectedBreedIndex;
  final ImprovementAreaListModel? improvementAreaListResponse;
  final List<StepperItemData> stepperData;
  final List<Counties>? counties;
  final List<DataSubCounty>? dataSubCounty;
  final Results? resultData;
  final String ?selectCounty,selectSubCounty;
  final List<TextEditingController>? areaControllers;
  // final GoogleMapController

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
    required this.editAddressController,
    required this.countryController,
    required this.zipCodeController,
    required this.countyController,
    required this.districtController,
    required this.selectedBreedIndex,
    required this.landlineController,
    required this.improvementAreaListResponse,
    required this.stepperData,
    required this.resultData,
    required this.regionController,
    required this.responseCountyList,
    required this.responseSubCounty,
    required this.counties,
    required this.dataSubCounty,
    required this.selectCounty,
    required this.selectSubCounty,
    required this.areaControllers,
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
      regionController: TextEditingController(),
      validator: '',
      profileImage: "",
      gender: null,
      selectDistrict: '',
      responseProfile: null,
      id: '',
      selectDob: '0000-00-00',
      farmerSince: '0000-00-00',
      selectCounty: 'Select County',
      selectSubCounty: 'Select Sub County',
      validatorString: '',
      profilePic: TextEditingController(),
      phoneController: TextEditingController(),
      addressController: TextEditingController(),
      centreNameController: TextEditingController(),
      countyController: TextEditingController(),
      countryController: TextEditingController(),
      zipCodeController: TextEditingController(),
      editAddressController: TextEditingController(),
        districtController: TextEditingController(),
      passwordVisible: true,
      confirmVisible: true,
      responseFarmerProfile: null,
      districtResponse: null,
      searchDistrictList: null,
      districtId: '',
      selectedBreedIndex: 0,
        improvementAreaListResponse: null,
      stepperData: const [],
      resultData: null,
      counties: const [],
      dataSubCounty: const [],
      responseCountyList: ResponseCountyList(),
      responseSubCounty: ResponseSubCounty(),
      areaControllers: const [],
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
    TextEditingController? editAddressController,
    TextEditingController? countryController,
    TextEditingController? zipCodeController,
    TextEditingController? countyController,
    TextEditingController? centreNameController,
    TextEditingController? districtController,
    TextEditingController? regionController,
    String? token,validator,validatorString,id,gender,selectDistrict,districtId, selectDob,farmerSince,profileImage,
    bool? passwordVisible,confirmVisible,
    TextEditingController? profilePic,farmSize,dairyArea,staffQuantity,managerName,managerPhone,
    farmer_profile.Data? responseFarmerProfile,
    List<DistrictData> ? districtResponse,
    List<DistrictData> ? searchDistrictList,
    int? selectedBreedIndex,
    ImprovementAreaListModel? improvementAreaListResponse,
    List<StepperItemData>? stepperData,
    Results? resultData,
    ResponseCountyList? responseCountyList,
    List<Counties>? counties,
    List<DataSubCounty>? dataSubCounty,
    ResponseSubCounty? responseSubCounty,
    String? selectCounty,
    String? selectSubCounty,
    List<TextEditingController>? areaControllers,
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
        zipCodeController:zipCodeController ?? this.zipCodeController,
        editAddressController:editAddressController ?? this.editAddressController,
      districtController:districtController ?? this.districtController,
        selectedBreedIndex: selectedBreedIndex ?? this.selectedBreedIndex,
        improvementAreaListResponse: improvementAreaListResponse ?? this.improvementAreaListResponse,
        stepperData: stepperData ?? this.stepperData,
      resultData: resultData ?? this.resultData,
        regionController: regionController ?? this.regionController,
        responseCountyList: responseCountyList ?? this.responseCountyList,
        responseSubCounty: responseSubCounty ?? this.responseSubCounty,
        counties: counties ?? this.counties,
        dataSubCounty: dataSubCounty ?? this.dataSubCounty,
        selectCounty: selectCounty ?? this.selectCounty,
        selectSubCounty: selectSubCounty ?? this.selectSubCounty,
      areaControllers: areaControllers ?? this.areaControllers,
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
    editAddressController,
    zipCodeController,
    centreNameController,
    districtController,
    districtId,
    landlineController,
    farmerSince,
    selectDob,
    selectedBreedIndex,
    improvementAreaListResponse,
    stepperData,
    resultData,
    regionController,
    responseCountyList,
    responseSubCounty,
    counties,
    dataSubCounty,
    selectCounty,
    selectSubCounty,
    areaControllers,
  ];

}