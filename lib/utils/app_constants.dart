class AppConstants {
  // static const String baseUrl = 'https://develop-glad.staqo.com';
  static const String baseUrl = 'http://staging-glad.staqo.com';
  static const String gMapsApiKey = 'AIzaSyAJg4PGbl1XfwJFKo-vQWlUVtH1Zzg3FEQ';


  // api End Point
  static const String loginWithPasswordApi = '/api/login';
  static const String loginWithMobileApi = '/api/generate-otp';
  static const String verifyMobileApi = '/api/login-otp';
  static const String createPasswordPasswordApi = '/api/create/password';
  static const String verifyOtpApi = '/api/validate/otp';
  static const String resendOtpApi = '/api/resend-otp';
  static const String forgotPasswordApi = '/api/password/reset';
  static const String updateProfileImageAPi = '/api/profile-pic';
  static const String profileApi = '/api/profile';
  static const String farmerDashboardApi = '/api/landing/dashboard';
  static const String farmerList = '/api/farmerlist';
  static const String farmerDetailsApi = '/api/farmer';
  static const String updateFarmerApi = '/api/farmer/update';
  static const String updateFarmApi = '/api/farm/update';
  static const String addTestimonialApi = '/api/testimonials';
  static const String milkProductionChart = '/api/last_six_month_data';
  static const String getDistrict = '/api/district/227';
  static const String countyListApi = '/api/address/countylist';
  static const String subCountyListApi = '/api/address/subcounty-list';
  static const String getBreedListApi = '/api/breed';
  static const String getCowBreedDetailApi = '/api/cow_breed_details';
  static const String updateCowBreedDetailApi = '/api/cow_breed_details_update';
  static const String addMonthApi = '/api/farmer/add-month';
  static const String deleteMonthApi = '/api/farmer/delete-month';
  static const String updateCowBreedDetail = '/api/cow_breed_details_update';
  static const String inviteExpertDetails= '/api/add-enquiry';
  static const String followupRemarkList = '/api/followup-remark-list';
  static const String addFollowupRemark = '/api/add-followup-remark';
  static const String getGuestDashboard = '/api/guest-user-dashboard';
  static const String enquiryListApi = '/api/enquiry-list';
  static const String enquiryDetailsApi = '/api/enquiry-details';
  static const String improvementAreaList = '/api/improvement/list';
  static const String improvementAreaUpdate = '/api/improvement/area-update';
  static const String enquiryClosedApi = '/api/dde/enquiry-closed';
  static const String ddeDashboardApi = '/api/dairy-executives/dde-dashboard';
  static const String farmerProjectListApi = '/api/farmer-project/list';
  static const String ddeProjectListApi = '/api/dairy-executives/project-list';
  static const String farmerProjectDetailApi = '/api/farmer-project/details';
  static const String farmerProjectMilestoneDetailApi = '/api/farmer-project/milestone-details';
  static const String addInviteExpertForSurveyApi = '/api/farmer-project/add-invite-expert';
  // static const String updateProjectStatusApi = '/api/farmer-project/update-status';
  static const String validateCountry = '/api/address/check-country';
  static const String projectUOMListApi = '/api/farmer-project/project-uom-list';
  static const String resourceCapacityListApi = '/api/farmer-project/resource-capacity-list';
  static const String resourceNameListApi = '/api/farmer-project/resource-name-list';
  static const String resourceTypeListApi = '/api/farmer-project/resource-type-list';
  static const String updateKycDocument = '/api/farmer-project/kyc-document';
  static const String editKycDocument = '/api/farmer-project/kyc-document-update';
  static const String updateAttributeApi = '/api/farmer-project/add-attribute';
  static const String addAttributeApi = '/api/farmer-project/add-attribute';
  static const String priceAttributeApi = '/api/farmer-project/price-attribute';
  static const String deleteAttributeApi = '/api/farmer-project/delete-attribute';
  static const String ddeFarmerVisitorApi = '/api/dde/farmer-visitor';
  static const String notRequiredDataApi = '/api/farmer-project/fetch-not-required-data';
  static const String trainingListApi = '/api/training/list';
  static const String trainingCategoryApi = '/api/training/category';
  static const String newsListApi = '/api/news-event/list';
  static const String newsCategoryApi = '/api/news-event/category';
  static const String trainingDetailApi = '/api/training/details';
  static const String projectKycDocumentsApi = '/api/farmer-project/project-kyc-document';
  //mileStoneApi
  static const String mileStoneDeleteAp = '/api/farmer-project/milestone-delete';
  static const String mileStoneNameApi = '/api/farmer-project/milestone-name-list';
  static const String fetchMileStoneDataApi = '/api/farmer-project/fetch-milestone-data';
  static const String addTaskApi = '/api/farmer-project/add-task';
  static const String deleteTaskApi = '/api/farmer-project/delete-task';

  //////////////////////// sharedKey ////////////////////////
  static const String fcmToken = 'fcmToken';
  static const String token = 'token';
  static const String userId = 'userId';
  static const String userType = 'userType';
  static const String deviceImeiId = 'deviceImeiId';
  static const String countryCode = 'countryCode';

  static const Map languages = {'Swahili': 'Hujambo\nMimi Sam', 'English': 'Hi\nI\'m Sam'};
}
